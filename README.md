# Adaptive Course Licenses (Aptos Move)

## Description
On-chain course licensing with progressive module unlocking. Each learner receives a `CourseLicense` that tracks their progress; passing checkpoints unlocks the next module, enabling adaptive learning paths fully verifiable on-chain.

Contract: `sources/project.move` defines `module AdaptiveCourseLicenses::AdaptiveCourseLicenses` using `aptos_framework` and `std::vector`.

## Vision
Build an open, verifiable credentialing layer for education where:
- Learners own their progress and credentials.
- Platforms can integrate trustlessly with standardized, auditable progress data.
- Instructors can design adaptive curricula that unlock dynamically based on achievements.

## Future Scope
- Role-based controls (instructor/admin) to issue/revoke licenses.
- Event emissions for checkpoint passed and module unlocked.
- Support for multiple courses per account and course metadata.
- Off-chain frontend dApp for instructors and students.
- Cross-course prerequisites and badge/NFT credentialing.
- Gas-efficient data layout and pagination for large cohorts.
- Test suite and property-based tests with Move Prover specs.

## Contract Address
Deployed address (module account):

`0xa9d402b31db0a5575fb9d065f0b09798149b47efdb8392264926fd14224af39d`

Deployment transaction (devnet):
https://explorer.aptoslabs.com/txn/0xedf7def1c9f56fad860f8028fb1b194e5c1d76cf9c40512c87aff7141a32de7f?network=devnet

This corresponds to `[addresses] AdaptiveCourseLicenses` in `Move.toml`.

---

### Deployment Screenshot
![Deployment Transaction Screenshot](![alt text](image.png))

### Quick Start
- Compile: `aptos move compile`
- Run tests (once added): `aptos move test`

### Key Functions
- `create_course_license(student: &signer, total_modules: u64)`
- `pass_checkpoint(student: &signer, checkpoint_id: u64)`
- `get_unlocked_modules(student_addr: address): vector<u64>`
