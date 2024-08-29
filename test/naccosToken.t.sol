// SPDX-License-Identifier:MIT
import {Test, console} from "forge-std/Test.sol";
import "../src/NACOSSToken.sol";
pragma solidity ^0.8.24;

contract nacossTokenTest is Test {
    NACOSSTOKEN token;
    function setUp() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token = new NACOSSTOKEN();
    }

    function testTotalSupply() public {
        uint totalSupply = token.totalSupply();
        assertEq(totalSupply, 100000000);
    }

    function testTokenBio() public {
        string memory symbol = token.symbol();
        string memory name_ = token.name();
        uint8 _decimals_ = token.decimals();
        assertEq(symbol, "NCST");
        assertEq(name_, "NACOSS TOKEN");
        assertEq(_decimals_, 2);
    }
    function testOwner() public {
        address _owner_ = token.owner_();
        uint balance = token.balanceOf(
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
        );
        assertEq(balance, 100000000);
        assertEq(_owner_, 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    }

    function testTransfer() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token.transfer(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 500000);
        assertEq(
            token.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266),
            99500000
        );
        assertEq(
            token.balanceOf(0x70997970C51812dc3A010C7d01b50e0d17dc79C8),
            500000
        );
    }

    function testApproval() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token.approve(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC, 1000);
        vm.prank(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
        token.transferFrom(
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            0x70997970C51812dc3A010C7d01b50e0d17dc79C8,
            1000
        );
        uint remaining = token.allowance(
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        );
        assertEq(remaining, 100);
    }
}
