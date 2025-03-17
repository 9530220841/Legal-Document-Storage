// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract LegalDocumentStorage {

    // Struct to hold document information
    struct Document {
        string title;
        string description;
        uint256 timestamp;
        address owner;
        bytes32 documentHash;
    }

    // Mapping to store documents by their unique identifier
    mapping(uint256 => Document) public documents;

    // Counter for document IDs
    uint256 public documentCount;

    // Event to emit when a document is uploaded
    event DocumentUploaded(uint256 documentId, string title, address indexed owner, uint256 timestamp);

    // Function to upload a document
    function uploadDocument(string memory _title, string memory _description, bytes32 _documentHash) public {
        documentCount++;
        documents[documentCount] = Document({
            title: _title,
            description: _description,
            timestamp: block.timestamp,
            owner: msg.sender,
            documentHash: _documentHash
        });

        emit DocumentUploaded(documentCount, _title, msg.sender, block.timestamp);
    }

    // Function to get document details by ID
    function getDocument(uint256 _documentId) public view returns (string memory title, string memory description, uint256 timestamp, address owner, bytes32 documentHash) {
        Document memory doc = documents[_documentId];
        return (doc.title, doc.description, doc.timestamp, doc.owner, doc.documentHash);
    }

    // Function to verify if the document exists by its hash
    function verifyDocument(bytes32 _documentHash) public view returns (bool) {
        for (uint256 i = 1; i <= documentCount; i++) {
            if (documents[i].documentHash == _documentHash) {
                return true;
            }
        }
        return false;
    }
}
