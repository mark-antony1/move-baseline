module OwningAccount::Module {
    use Std::Signer;

	#[test(account = @0x1)]
		public(script) fun run_test(account: signer) {
			let addr = Signer::address_of(&account);
			
		}
}

