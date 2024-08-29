import {Script, console} from "forge-std/Script.sol";
import "../src/NACOSSToken.sol";
pragma solidity ^0.8.24;

contract NacossScript is Script {
    NACOSSTOKEN token;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        token = new NACOSSTOKEN();
        vm.stopBroadcast();
    }
}
