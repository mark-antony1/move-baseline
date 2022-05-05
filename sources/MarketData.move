module Nutrios::MarketData {
	use AptosFramework::TestCoin;
	use Std::ASCII;

	struct AccessToken has key {
		deposit: TestCoin::Coin,
		location: ASCII::String, //as UTM coordinate to 1m resolution
		radius: u64,
		available_uses: u64, // how many times token can be used; decremented each use
		cost_per_usage: u64 // number of coins to burn per use
	}
}
