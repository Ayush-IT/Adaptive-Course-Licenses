module AdaptiveCourseLicenses::AdaptiveCourseLicenses {
    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a course license with unlockable modules
    struct CourseLicense has store, key {
        total_modules: u64,           // Total number of modules in the course
        unlocked_modules: vector<u64>, // List of unlocked module IDs
        checkpoints_passed: u64,      // Number of checkpoints passed
    }

    /// Error codes
    const E_COURSE_LICENSE_NOT_FOUND: u64 = 1;
    const E_CHECKPOINT_ALREADY_PASSED: u64 = 2;
    const E_INVALID_MODULE_ID: u64 = 3;

    /// Function to create a new course license for a student
    public fun create_course_license(
        student: &signer, 
        total_modules: u64
    ) {
        let license = CourseLicense {
            total_modules,
            unlocked_modules: vector::empty<u64>(),
            checkpoints_passed: 0,
        };
        
        // Initially unlock the first module (module 1)
        vector::push_back(&mut license.unlocked_modules, 1);
        
        move_to(student, license);
    }

    /// Function to pass a checkpoint and unlock the next module
    public fun pass_checkpoint(
        student: &signer,
        checkpoint_id: u64
    ) acquires CourseLicense {
        let student_addr = signer::address_of(student);
        let license = borrow_global_mut<CourseLicense>(student_addr);
        
        // Verify checkpoint progression (must pass checkpoints in order)
        assert!(checkpoint_id == license.checkpoints_passed + 1, E_CHECKPOINT_ALREADY_PASSED);
        
        // Update checkpoints passed
        license.checkpoints_passed = license.checkpoints_passed + 1;
        
        // Unlock next module if available
        let next_module = license.checkpoints_passed + 1;
        if (next_module <= license.total_modules) {
            vector::push_back(&mut license.unlocked_modules, next_module);
        };
    }

    /// View function to check unlocked modules (read-only)
    #[view]
    public fun get_unlocked_modules(student_addr: address): vector<u64> acquires CourseLicense {
        let license = borrow_global<CourseLicense>(student_addr);
        license.unlocked_modules
    }
}