// SPDX-License-Identifier:MIT
pragma solidity >=0.8.26;

import "./../src/EBT.sol";
import {Test, console} from "forge-std/Test.sol";

contract EtherBillTokenTest is Test {
    Token token;
    function setUp() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token = new Token();
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token.mint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 1000);
    }
    function testDeployer() public view {
        address _deployer = token.owner();
        assertEq(_deployer, 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    }
    function testGetRoleId() public view {
        bytes32 _role_id = token.ROLE_ID();
        assertEq(
            _role_id,
            0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775
        );
    }

    function testGrantPermission() public {
        bool isAdmin = token.roles(
            0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775,
            0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        );
        assertFalse(isAdmin);
        bytes32 ROLE = 0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775;
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token.grantPermission(ROLE, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        bool isAdmin_ = token.roles(
            0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775,
            0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        );
        assertTrue(isAdmin_);
    }

    function testTotalSupply() public view {
        uint256 _total_s = token.totalSupply();
        assertEq(_total_s, 1000);
    }
    function testApproval() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token.approve(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC, 1000);
        uint256 allowed = token.allowance(
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        );
        assertEq(allowed, 1000);
    }

    function testTransfer() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token.transfer(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC, 100);
        uint256 token_balance = token.balanceOf(
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        );
        assertEq(token_balance, 100);
        assertEq(
            token.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266),
            900
        );
    }

    function testTransferFrom() public {
        vm.prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        token.approve(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC, 1000);
        vm.prank(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
        token.transferFrom(
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC,
            1000
        );
        assertEq(
            token.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266),
            0
        );
        assertEq(
            token.balanceOf(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC),
            1000
        );
        assertEq(
            token.allowance(
                0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
                0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
            ),
            0
        );
    }
}
