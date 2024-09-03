// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract GameItem is ERC721URIStorage {
    using Strings for uint256;

    address dev = 0x;
    uint256 private constant MAX = 678;

    uint256 public totalMinted;
    
    constructor() ERC721("My Token","MT"){

    }

    function mint(uint256 amount) public payable {
        require(start == true, "SALE has not Started!");
        require(totalMinted + amount <= MAX_ENTRIES, "Amount Exceed!");

        if ((block.timestamp - startTime) <= 25200) {
            require(
                whitelisted[msg.sender] == true || ogmember[msg.sender] == true,
                "You are not a WhiteListed Person or OG Member!"
            );
            require(
                balanceOf(msg.sender) + amount <= MAX_BUYABLE,
                "In PRESALE Stage, you can buy ONLY 3 Zillas!"
            );
        }
        if (ogmember[msg.sender]) price = OG_PRICE * amount;
        else price = SALE_PRICE * amount;

        // Payment value must be larger than the 'price'
        require(msg.value >= price, "MT : INCORRECT PRICE!");
        payable(admin1).transfer(((msg.value) * 98) / 100);
        payable(dev).transfer(((msg.value) * 2) / 100);
        for (uint8 i = 1; i <= amount; i++)
            _safeMint(msg.sender, (totalMinted + i));

        totalMinted += amount;
    }

    function upgrade()

    function setBaseURI(string memory _tokenURI) public onlyAdmin {
        _baseTokenURI = _tokenURI;
    }

    modifier onlyAdmin {
        require(msg.sender == admin)
    }




}
