// #[test_only]
// module OwningAccount::ModuleTests {
//     use Std::Signer;
//     use OwningAccount::Module;

//     fun get_account(): signer {
//         Vector::pop_back(&mut UnitTest::create_signers_for_testing(1))
//     }
	
// 	#[test]
//     public(script) fun run_test() {
// 		let account = get_account();
//         let account_addr = Signer::address_of(&owner);
//     }
// }