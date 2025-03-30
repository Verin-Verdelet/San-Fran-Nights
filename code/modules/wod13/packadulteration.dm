/datum/crafting_recipe/methpack
	name = "Make metamphetamine pack"
	time = 25
	reqs = list(/obj/item/reagent_containers/food/drinks/meth = 1, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/reagent_containers/drug/methpack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/morphpack
	name = "Make morphine pack"
	time = 25
	reqs = list(/datum/reagent/medicine/morphine = 15, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/reagent_containers/drug/morphpack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/cokepack
	name = "Make cocaine pack"
	time = 25
	reqs = list(/obj/item/reagent_containers/food/drinks/meth/cocaine = 1, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/reagent_containers/drug/cokepack
	always_available = TRUE
	category = CAT_DRUGS
