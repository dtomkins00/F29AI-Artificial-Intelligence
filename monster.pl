/*
 * This Prolog program is designed to represent knowledge regarding the Pokemon (monsters in this case) battle system
 * and will answer queries according to the provided knowledge base for it to work off of.
 * 
 * Author - Drew Tomkins
 */

/*
 * This is a knowledge base of facts for SWISH Prolog to use when determining the
 * results of rules.
 */

/*List of facts containing potential types the Pokemon can have.*/
type(fire).
    type(grass).
    type(water).
    type(electric).
    type(normal).

%List of facts stating which Pokemon has what type.
    monster(charmander,fire).
    monster(bulbasaur,grass).
    monster(squirtle,water).
    monster(pikachu,electric).
    monster(eevee,normal).

%List of facts which link Pokemon abilities(moves) to types.
    ability(scratch,normal).
    ability(fireFang,fire).
    ability(firePunch,fire).
    ability(thunderPunch,electric).
    ability(tackle,normal).
    ability(vineWhip,grass).
    ability(razorLeaf,grass).
    ability(solarBeam,grass).
    ability(tackle,normal).
    ability(waterPulse,water).
    ability(aquaTail,water).
    ability(bodySlam,normal).
    ability(thunderPunch,electric).
    ability(surf,water).
    ability(grassKnot,grass).
    ability(thunderbolt,electric).
    ability(rainDance,water).
    ability(sunnyDay,fire).
    ability(bite,normal).
    ability(lastResort,normal).

%List of facts that state the various abilities of each Pokemon.
    monsterability(charmander,scratch).
    monsterability(charmander,fireFang).
    monsterability(charmander,firePunch).
    monsterability(charmander,thunderPunch).
    monsterability(bulbasaur,tackle).
    monsterability(bulbasaur,vineWhip).
    monsterability(bulbasaur,razorLeaf).
    monsterability(bulbasaur,solarBeam).
    monsterability(squirtle,tackle).
    monsterability(squirtle,waterPulse).
    monsterability(squirtle,aquaTail).
    monsterability(squirtle,bodySlam).
    monsterability(pikachu,thunderPunch).
    monsterability(pikachu,surf).
    monsterability(pikachu,grassKnot).
    monsterability(pikachu,thunderbolt).
    monsterability(eevee,rainDance).
    monsterability(eevee,sunnyDay).
    monsterability(eevee,bite).
    monsterability(eevee,lastResort).

%List of facts which document the effectiveness of one type (the first one listed) versus another type (the second type listed).
    typeEffectiveness(normal,fire,ordinary).
    typeEffectiveness(normal,water,ordinary).
    typeEffectiveness(normal,grass,ordinary).
    typeEffectiveness(normal,electric,ordinary).
    typeEffectiveness(normal,normal,ordinary).
    typeEffectiveness(fire,fire,weak).
    typeEffectiveness(fire,water,weak).
    typeEffectiveness(fire,grass,super).
    typeEffectiveness(fire,electric,ordinary).
    typeEffectiveness(fire,normal,ordinary).
    typeEffectiveness(water,fire,super).
    typeEffectiveness(water,water,weak).
    typeEffectiveness(water,electric,ordinary).
    typeEffectiveness(water,grass,weak).
    typeEffectiveness(water,normal,ordinary).
    typeEffectiveness(electric,fire,ordinary).
    typeEffectiveness(electric,water,super).
    typeEffectiveness(electric,electric,weak).
    typeEffectiveness(electric,grass,weak).
    typeEffectiveness(electric,normal,ordinary).
    typeEffectiveness(grass,fire,weak).
    typeEffectiveness(grass,water,super).
    typeEffectiveness(grass,electric,ordinary).
    typeEffectiveness(grass,grass,weak).
    typeEffectiveness(grass,normal,ordinary).

/*
 * This rule checks to find the effectiveness of an ability (A) against a Pokemon (M). 
 * It gets the monster, ability and their types, then compares both of them using the typeEffectiveness rule.
 * It checks to see what effectiveness the ability's type has against the Pokemon, and then returns the result.
 * Example: abilityEffectiveness(fireFang,bulbasaur,X) leads to X being super, meaning Fire Fang is super effective against Bulbasaur.
 */

    abilityEffectiveness(A,M,E) :- monster(M,MT), ability(A,AT), typeEffectiveness(AT,MT,E).

/* This rule checks to see if ability A is a super effective ability for monster M1 to use against monster M2.
 * It takes both monsters and their types, and then compares the ability type to the targets type to check if the ability is super.
 * Example: superAbility(squirtle,waterPulse,bulbasaur) shows that waterPulse is not a super effective ability to use on Bulbasaur.
 * Alternatively, superAbility(squirtle,X,charmander) shows that Squirtle has 2 abilities that are super effective against Charmander.
 */

    superAbility(M1,A,M2) :- monsterability(M1,MA1), monster(M2,MT2), ability(MA1,MT1), typeEffectiveness(MT1,MT2,A), A=super.

/*
 * This rule checks to see if ability A is an ability of Pokemon M and that M and A have the same type.
 * It takes the Pokemon + its type, the ability + type and compares both types whilst also checking if the Pokemon knows that move.
 * Example: typeAbility(charmander,firePunch) returns true as Charmander knows Fire Punch and both are fire-types.
 */

    typeAbility(M,A) :- monster(M,T), monsterability(M,A), ability(A,T).

/*
 * This rule looks to see if ability A1 is more effective than ability A2 against monsters of type T: 
 * ordinary is more effective than weak, and super is more effective than ordinary and weak.
 * It takes both abilities, and compares their types against the monsters type to see which is more effective.
 * Example: moreEffectiveAbility(razorLeaf,surf,charmander) returns Razor Leaf being weak and Surf being super effective against Charmander.
 */

    moreEffectiveAbility(A1,A2,T) :- ability(A1,T), ability(A2,T), typeEffectiveness(MT,T,A1).

/*
 * This rule is designed to check if Pokemon M1 performs ability A1 and Pokemon M2 performs ability A2 that A2 is a more effective than A1: ordinary is
 * more effective than weak, and super is more effective than ordinary and weak.
 * It takes the two Pokemon and their abilities + types for both, then compares both to see which Pokemon has the more effective attack.
 * Example: counterAbility(charmander,fireFang,bulbasaur,tackle) would return Fire Fang being super effective and Tackle being ordinary, meaning Charmander has the better attack.
 */

    counterAbility(M1,A1,M2,A2) :- monster(M1,T), ability(A1,AT), monster(M2,T), ability(A2,AT).