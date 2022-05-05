module Nutrios::FoodItem {
    use Std::Signer;
	use Std::ASCII;
    use AptosFramework::Table;
	use Std::Vector;
	use AptosFramework::TestCoin;

	struct Entity has store, copy {

	}

	struct Food has key {
		creator: address,
		access_tokens: vector<AccessToken>,
		encryptedSource: vector<u8>,
		nutrition: Table::Table<vector<u8>,u64>,
		flavor: Table::Table<vector<u8>,u64>,
		// social_graph: ,

	}

	struct AccessToken has key, store, drop {
		visibility: ItemVisibility,
		deposit: TestCoin::Coin
	}

	struct ItemVisibility has store, drop {
		location: ASCII::String, //as UTM coordinate
		radius: u64, // units of 100m/(0.1km)
	}

	struct ItemAvailability has store, drop {
		entity: Entity,
		location: ASCII::String,
		in_store: boolean,
		curbside: boolean,
		delivery: boolean,
		average_lead_time: u64,
		average_price: u64 // currency? units?
	}




fun create(creator: address): Recipe {
	Recipe {
		creator,
		encryptedSource: Vector::empty(),
		nutrition: Table::create<vector<u8>, u64>(),
		flavor: Table::create<vector<u8>, u64>(),
	}
}

#[test(creator = @0x1, faucet = @CoreResources)]
public(script) fun sender_can_recipe(creator: signer, faucet: signer) {
	let creator_addr = Signer::address_of(&creator);
	let recipe = create(creator_addr);
	move_to<Recipe>(&creator, recipe);
	assert!(exists<Recipe>(creator_addr), 0);

	TestCoin::initialize(&faucet, 1000000);
        TestCoin::register(&creator);
        let amount = 1000;
        let faucet_addr = Signer::address_of(&faucet);

        TestCoin::mint_internal(&faucet, faucet_addr, amount);
        TestCoin::transfer(faucet, creator_addr, 100);



	let stake = TestCoin::withdraw(&creator, 50);
	move_to<AccessToken>(&creator, AccessToken {stake});
	assert!(exists<AccessToken>(creator_addr), 0)
}
}

