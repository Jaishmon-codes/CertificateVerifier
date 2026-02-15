// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CertificateVerifier {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    struct Certificate {
        string name;
        string course;
        string ipfsHash;
        bool valid;
    }

    mapping(string => Certificate) private certificates;

    function issueCertificate(
        string memory _id,
        string memory _name,
        string memory _course,
        string memory _ipfs
    ) public onlyOwner {

        certificates[_id] = Certificate(
            _name,
            _course,
            _ipfs,
            true
        );
    }

    function verifyCertificate(string memory _id)
        public
        view
        returns (string memory, string memory, string memory, bool)
    {
        Certificate memory cert = certificates[_id];

        return (
            cert.name,
            cert.course,
            cert.ipfsHash,
            cert.valid
        );
    }

    function revokeCertificate(string memory _id)
        public onlyOwner
    {
        certificates[_id].valid = false;
    }
}
