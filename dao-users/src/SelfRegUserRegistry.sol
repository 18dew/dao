import "./AbstractUserRegistry.sol";

/*
    Contract: SelfRegUserRegistry

    User registry contract. Depends on a 'UserDatabase' contract.
    Users can register themselves.

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
contract SelfRegUserRegistry is AbstractUserRegistry {

    /*
        Constructor: AdminRegUserRegistry

        Params:
            dbAddress (address) - The address to the user database.
            admin (address) - The address of the admin account.
    */
    function SelfRegUserRegistry(address dbAddress, address admin)
        AbstractUserRegistry(dbAddress, admin) {}

    /*
        Function: registerSelf

        Register the sender account as a new user.

        Params:
            nickname (bytes32) - The nickname.
            dataHash (bytes32) - Hash of the file containing (optional) user data.

        Returns:
            error (uint16) An error code.
    */
    function registerSelf(bytes32 nickname, bytes32 dataHash) returns (uint16 error) {
        if (nickname == 0)
            error = NULL_PARAM_NOT_ALLOWED;
        else
            error = _userDatabase.registerUser(msg.sender, nickname, block.timestamp, dataHash);

        RegisterUser(msg.sender, nickname, dataHash, error);
    }

}