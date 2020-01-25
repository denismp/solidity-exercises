pragma solidity >=0.4.22 <0.6.2;
//import "github.com/Arachnid/solidity-stringutils/strings.sol";
pragma experimental ABIEncoderV2; // This is experimental.  don't use in main net.
// https://blog.ethereum.org/2019/03/26/solidity-optimizer-and-abiencoderv2-bug/

contract EarthContract {
    string[] private continents = ["Asia", "Afica", "Antartica", "Australia", "Europe", "North America", "South America"];
    //enum Continents {Asia, Africa, Antartica, Australia, NortAmerica, SouthAmerica}
    address private owner;
    struct Country {
        string country;
        string capital;
        uint population;
    }
    Country private countryRec;
    Country[] private countryArr;
    string[] private europeanCountries =
    [
        "Albania",
        "Andorra",
        "Armenia",
        "Austria",
        "Azerbaijan",
        "Belarus",
        "Belgium",
        "Bosnia",
        "Croatia",
        "Cyprus",
        "Czechia",
        "Denmark",
        "Estonia",
        "Finland",
        "France",
        "Georgia",
        "Germany",
        "Greece",
        "Hungary",
        "Iceland",
        "Ireland",
        "Italy",
        "Kazzakhstan",
        "Kosovo",
        "Latvia",
        "Liechtenstein",
        "Lithuania",
        "Luxembourg",
        "Malta",
        "Modova",
        "Monaco",
        "Montenegro",
        "Netherlands",
        "North Macedonia",
        "Norway",
        "Poland",
        "Portugal",
        "Romania",
        "Russia",
        "San Marino",
        "Serbia",
        "Slovakia",
        "Slovenia",
        "Spain",
        "Sweden",
        "Switzerland",
        "Turkey",
        "Ukraine",
        "United Kingdom",
        "Vatican City"
    ];

    mapping(string => string) private europeanCapitals;
    mapping(string => Country[]) private continentsMap; // key is the continent.

    constructor() public {
        owner = msg.sender;
        europeanCapitals["Albania"] = "Tirana";
        europeanCapitals["Andorra"] = "Andorra la Vella";
        europeanCapitals["Armenia"] = "Yerevan";
        europeanCapitals["Austria"] = "Vienna";
        europeanCapitals["Azerbaijan"] = "Baku";
        europeanCapitals["Belarus"] = "Minsk";
        europeanCapitals["Belgium"] = "Brussels";
        europeanCapitals["Bosnia"] = "Sarajevo";
        europeanCapitals["Croatia"] = "Zagreb";
        europeanCapitals["Cyprus"] = "Nicosia";
        europeanCapitals["Czechia"] = "Prague";
        europeanCapitals["Denmark"] = "Copenhagen";
        europeanCapitals["Estonia"] = "Tallinn";
        europeanCapitals["Finland"] = "Helsinki";
        europeanCapitals["France"] = "Paris";
        europeanCapitals["Georgia"] = "Tbilisi";
        europeanCapitals["Germany"] = "Berlin";
        europeanCapitals["Greece"] = "Athens";
        europeanCapitals["Hungary"] = "Budapest";
        europeanCapitals["Iceland"] = "Reyjavik";
        europeanCapitals["Ireland"] = "Dublin";
        europeanCapitals["Italy"] = "Rome";
        europeanCapitals["Kazzakhstan"] = "Nur-Sultan";
        europeanCapitals["Kosovo"] = "Pristina";
        europeanCapitals["Latvia"] = "Riga";
        europeanCapitals["Liechtenstein"] = "Vaduz";
        europeanCapitals["Lithuania"] = "Vilnius";
        europeanCapitals["Luxembourg"] = "Luxembourg";
        europeanCapitals["Malta"] = "Valletta";
        europeanCapitals["Modova"] = "Chisinau";
        europeanCapitals["Monaco"] = "Monaco";
        europeanCapitals["Montenegro"] = "Podgorica";
        europeanCapitals["Netherlands"] = "Amsterdam";
        europeanCapitals["North Macedonia"] = "Skopje";
        europeanCapitals["Norway"] = "Oslo";
        europeanCapitals["Poland"] = "Warsaw";
        europeanCapitals["Portugal"] = "Lisbon";
        europeanCapitals["Romania"] = "Bucharest";
        europeanCapitals["Russia"] = "Moscow";
        europeanCapitals["San Marino"] = "San Marino";
        europeanCapitals["Serbia"] = "Belgrade";
        europeanCapitals["Slovakia"] = "Bratislava";
        europeanCapitals["Slovenia"] = "Ljubljana";
        europeanCapitals["Spain"] = "Madrid";
        europeanCapitals["Sweden"] = "Stockholm";
        europeanCapitals["Switzerland"] = "Bern";
        europeanCapitals["Turkey"] = "Ankara";
        europeanCapitals["Ukraine"] = "Kyiv";
        europeanCapitals["United Kingdom"] = "London";
        europeanCapitals["Vatican City"] = "Vatican City";
    }


    function add(string memory country, string memory continent, uint population) public {
        require(bytes(europeanCapitals[country]).length != 0, "country is not a European country");
        countryRec.country = country;
        countryRec.capital = europeanCapitals[country];
        countryRec.population = population;
        continentsMap[continent].push(countryRec);
    }

    function getEuropeanCountries() public view returns(string memory) {
        string memory rString;
        Country[] memory eCountries = continentsMap["Europe"];
        for(uint i = 0; i < eCountries.length; i++) {
            rString = strConcat(rString,eCountries[i].country);
            rString = strConcat(rString, ",");
        }
        return rString;
    }

    // function getAllEuropeanCountriesOld() public view returns(string memory) {
    //     string memory rString;
    //     for(uint i = 0; i < europeanCountries.length; i++) {
    //         rString = strConcat(rString,europeanCountries[i]);
    //         rString = strConcat(rString, ",");
    //     }
    //     return rString;
    // }

    function getAllEuropeanCountries() public view returns(string[] memory) {
        return europeanCountries;
    }

    // function getContinentsOld() public view returns(string memory) {
    //     string memory rString;
    //     for(uint i = 0; i < continents.length; i++) {
    //         rString = strConcat(rString,continents[i]);
    //         rString = strConcat(rString,",");
    //     }
    //     return rString;
    // }

    function getContinents() public view returns(string[] memory) {
        return continents;
    }

    function addCapital(string memory capital, string memory country) public {
        require(bytes(europeanCapitals[country]).length != 0, "country is not a European country");
        for(uint i = 0; i < continentsMap["Europe"].length; i++) {
            if(hashCompareWithLengthCheck(continentsMap["Europe"][i].country,country)) {
                continentsMap["Europe"][i].capital = capital;
            }
        }
    }

    function getCapital(string memory country) public view returns(string memory) {
        require(bytes(europeanCapitals[country]).length != 0, "country is not a European country");
        for(uint i = 0; i < continentsMap["Europe"].length; i++) {
            if(hashCompareWithLengthCheck(continentsMap["Europe"][i].country,country)) {
                return continentsMap["Europe"][i].capital;
            }
        }
    }

    function deleteCapital(string memory capital, string memory country) public {
        require(bytes(europeanCapitals[country]).length != 0, "country is not a European country");
        for(uint i = 0; i < continentsMap["Europe"].length; i++) {
            if(hashCompareWithLengthCheck(continentsMap["Europe"][i].country,country)) {
                require(hashCompareWithLengthCheck(continentsMap["Europe"][i].capital,capital), "Given capital is not the capital of the given country.");
                delete continentsMap["Europe"][i].capital;
            }
        }
    }

    // function addCapitalOld(string memory capital, string memory country) public {
    //     require(bytes(europeanCapitals[country]).length != 0, "country is not a European country");
    //     Country[] memory eCountries = continentsMap["Europe"];
    //     bool found = false;
    //     uint index = 0;
    //     for(uint i = 0; i < eCountries.length; i++) {
    //         if(hashCompareWithLengthCheck(eCountries[i].country,country)) {
    //             found = true;
    //             index = i;
    //             countryRec.country = eCountries[i].country;
    //             countryRec.capital = capital;
    //             countryRec.population = eCountries[i].population;
    //         }
    //     }
    //     if(found) {
    //         //delete eCountries[index]; // delete the old record from the array.
    //         //eCountries.push(countryRec); // push the new record on to the array.  this does not maintain the previous order.
    //         eCountries[index] = countryRec;
    //         continentsMap["Europe"] = eCountries; // Set the mapping for Europe to be the update array.
    //     }
    // }

    // Stolen from https://fravoll.github.io/solidity-patterns/string_equality_comparison.html
    // This code has not been professionally audited, therefore I cannot make any promises about
    // safety or correctness. Use at own risk.
    function hashCompareWithLengthCheck(string memory a, string memory b) internal pure returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }

    function strConcat(string memory _a, string memory _b) internal pure returns (string memory){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ab = new string(_ba.length + _bb.length);
        bytes memory bab = bytes(ab);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
        return string(bab);
    }
}