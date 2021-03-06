import "dao-users/test/MockUserDatabase.sol";
import "dao-stl/src/assertions/DaoTest.sol";
import "dao-votes/src/currency/PublicMintingBallot.sol";
import "./MockPublicCurrency.sol";

contract PublicMintingBallotTest is DaoTest {

    uint    constant TEST_ID                    = 1;
    uint    constant TEST_ID_2                  = 2;
    uint    constant TEST_DURATION              = 1 days;
    uint8   constant TEST_QUORUM                = 0;
    uint    constant TEST_NUM_ELIGIBLE_VOTERS   = 1;
    uint16  constant MPC_RETURN                 = 0x333;
    address constant TEST_ADDRESS               = 0x12345;

    function testCreate() {
        var mdb = new MockUserDatabase(0, true, 0);
        var mpc = new MockPublicCurrency();
        var pmb = PublicMintingBallot(mpc.createBallot(TEST_ID, mdb, this, block.timestamp,
            TEST_DURATION, TEST_QUORUM, TEST_NUM_ELIGIBLE_VOTERS, this, 1));

        pmb.receiver().assertEqual(this, "receiver returned wrong address");
        pmb.amount().assertEqual(1, "amount returned wrong number");
    }

    function testExecute() {
        var mdb = new MockUserDatabase(block.timestamp, true, 0);
        var mpc = new MockPublicCurrency();
        var pmb = PublicMintingBallot(mpc.createBallot(TEST_ID, mdb, this, block.timestamp,
            TEST_DURATION, TEST_QUORUM, TEST_NUM_ELIGIBLE_VOTERS, this, 1));
        mpc.vote(this, 1, block.timestamp);

        var (receiver, amount) = mpc.getData();
        receiver.assertEqual(this, "getData returns the wrong receiver");
        amount.assertEqual(1, "getData returns the wrong amount");
    }

}