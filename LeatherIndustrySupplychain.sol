pragma solidity >=0.4.22 < 0.8.6;

contract AnimalDelivery{
    
    uint256 public startDate;
    uint256 public day;
    uint256 public amount;
    uint256 public deposit;
    uint256 OrderedNumber;
    string OrderedBreed;
    uint256 DeliveredNumber;
    string DeliveredBreed;
    address  slaughterhouse;
    address  breeder;
    address judger;
    
    enum status {ordered, notStarted, paied, started, ended, suspended, failed}
    status currentStatus;
    
    constructor( address  _slaughterhouse, address  _breeder, address _judger, uint256  _day, uint256 _deposit)public{
        slaughterhouse=_slaughterhouse;
        breeder= _breeder;
        judger= _judger;
        day= _day;
        deposit= _deposit;
        currentStatus= status.notStarted;
    }
    
    function Order(uint256 _number, string memory _breed) public returns(uint256, string memory){
        require(msg.sender== slaughterhouse);
        require(currentStatus== status.notStarted);
        OrderedNumber= _number;
        OrderedBreed= _breed;
        currentStatus= status.ordered;
        return(OrderedNumber,OrderedBreed);
    }
    
    function CheckOrder(uint256 price) public returns (uint256){
        require(msg.sender== breeder);
        require(currentStatus == status.ordered);
        amount= price*OrderedNumber;
        return amount;
    }
    
    function Pay() public payable returns(string memory){
        require(currentStatus== status.ordered);
        require(msg.sender== slaughterhouse);
        require(msg.value== amount);
        startDate= block.timestamp;
        currentStatus= status.paied;
        return "Success";
    }
    
    function Deposit() public payable returns(string memory){
        require(msg.sender==breeder);
        require(msg.value==deposit);
        require(currentStatus== status.paied);
        currentStatus= status.started;
        return "Success";
    }
    
    function Confirm (bool verify ) public returns(string memory){
        require(msg.sender==slaughterhouse);
        require(currentStatus== status.started);
        if(verify==true){
            currentStatus= status.ended;
            return "Ended Successfully";
        }else{
            if(block.timestamp>(day*84600)+startDate){
                currentStatus=status.suspended;
                return "Suspended";
            }else{
                return "Deadline Is Not Finished";
            }
        }
    }
    
    function judgement(bool verify) public returns (string memory){
        require(currentStatus==status.suspended);
        require(msg.sender==judger);
        if(verify==true){
            currentStatus=status.ended;
            return "Confirmed";
        }else{
            currentStatus= status.failed;
            return "Rejected";
        }
    }
    
    function WithdrawBreeder() public payable returns(string memory){
        require(msg.sender==breeder);
        require(currentStatus==status.ended);
        breeder.transfer(amount+deposit);
        return "Success";
    }
    
     function WithdrawSlaughterhouse() public payable returns(string memory){
        require(msg.sender==slaughterhouse);
        require(currentStatus==status.failed);
        slaughterhouse.transfer(amount+deposit);
        return "Success";
    }
}


contract BuyAnimalsSkin{
    
    uint256 public startDate;
    uint256 public day;
    uint256 public amount;
    uint256 public deposit;
    uint256 OrderedNumber;
    string OrderedBreed;
    uint256 DeliveredNumber;
    string DeliveredBreed;
    address  tannery;
    address  slaughterhouse;
    address judger;
    
    enum status {ordered, notStarted, paied, started, ended, suspended, failed}
    status currentStatus;
    
    constructor( address  _tannery, address  _slaughterhouse, address _judger, uint256  _day, uint256 _deposit)public{
        tannery= _tannery;
        slaughterhouse=_slaughterhouse;
        judger= _judger;
        day= _day;
        deposit= _deposit;
        currentStatus= status.notStarted;
    }
    
    function Order(uint256 _number, string memory _breed) public returns(uint256, string memory){
        require(msg.sender== tannery);
        require(currentStatus== status.notStarted);
        OrderedNumber= _number;
        OrderedBreed= _breed;
        currentStatus= status.ordered;
        return(OrderedNumber,OrderedBreed);
    }
    
    function CheckOrder(uint256 price) public returns (uint256){
        require(msg.sender== slaughterhouse);
        require(currentStatus == status.ordered);
        amount= price*OrderedNumber;
        return amount;
    }
    
    function Pay() public payable returns(string memory){
        require(currentStatus== status.ordered);
        require(msg.sender== tannery);
        require(msg.value== amount);
        startDate= block.timestamp;
        currentStatus= status.paied;
        return "Success";
    }
    
    function Deposit() public payable returns(string memory){
        require(msg.sender==slaughterhouse);
        require(msg.value==deposit);
        require(currentStatus== status.paied);
        currentStatus= status.started;
        return "Success";
    }
    
    function Confirm (bool verify ) public returns(string memory){
        require(msg.sender==tannery);
        require(currentStatus== status.started);
        if(verify==true){
            currentStatus= status.ended;
            return "Ended Successfully";
        }else{
            if(block.timestamp>(day*84600)+startDate){
                currentStatus=status.suspended;
                return "Suspended";
            }else{
                return "Deadline Is Not Finished";
            }
        }
    }
    
    function judgement(bool verify) public returns (string memory){
        require(currentStatus==status.suspended);
        require(msg.sender==judger);
        if(verify==true){
            currentStatus=status.ended;
            return "Confirmed";
        }else{
            currentStatus= status.failed;
            return "Rejected";
        }
    }
    
    function WithdrawSlaughterhouse() public payable returns(string memory){
        require(msg.sender==slaughterhouse);
        require(currentStatus==status.ended);
        slaughterhouse.transfer(amount+deposit);
        return "Success";
    }
    
     function WithdrawTannery() public payable returns(string memory){
        require(msg.sender==tannery);
        require(currentStatus==status.failed);
        tannery.transfer(amount+deposit);
        return "Success";
    }
}



contract BuyProseccedLeather{
    
    uint256 public startDate;
    uint256 public day;
    uint256 public amount;
    uint256 public deposit;
    uint256 OrderedNumber;
    string OrderedBreed;
    uint256 DeliveredNumber;
    string DeliveredBreed;
    address  manufacturer;
    address  tannery;
    address judger;
    
    enum status {ordered, notStarted, paied, started, ended, suspended, failed}
    status currentStatus;
    
    constructor( address  _manufacturer, address  _tannery, address _judger, uint256  _day, uint256 _deposit)public{
        manufacturer= _manufacturer;
        tannery=_tannery;
        judger= _judger;
        day= _day;
        deposit= _deposit;
        currentStatus= status.notStarted;
    }
    
    function Order(uint256 _number, string memory _breed) public returns(uint256, string memory){
        require(msg.sender== manufacturer);
        require(currentStatus== status.notStarted);
        OrderedNumber= _number;
        OrderedBreed= _breed;
        currentStatus= status.ordered;
        return(OrderedNumber,OrderedBreed);
    }
    
    function CheckOrder(uint256 price) public returns (uint256){
        require(msg.sender== tannery);
        require(currentStatus == status.ordered);
        amount= price*OrderedNumber;
        return amount;
    }
    
    function Pay() public payable returns(string memory){
        require(currentStatus== status.ordered);
        require(msg.sender== manufacturer);
        require(msg.value== amount);
        startDate= block.timestamp;
        currentStatus= status.paied;
        return "Success";
    }
    
    function Deposit() public payable returns(string memory){
        require(msg.sender==tannery);
        require(msg.value==deposit);
        require(currentStatus== status.paied);
        currentStatus= status.started;
        return "Success";
    }
    
    function Confirm (bool verify ) public returns(string memory){
        require(msg.sender==manufacturer);
        require(currentStatus== status.started);
        if(verify==true){
            currentStatus= status.ended;
            return "Ended Successfully";
        }else{
            if(block.timestamp>(day*84600)+startDate){
                currentStatus=status.suspended;
                return "Suspended";
            }else{
                return "Deadline Is Not Finished";
            }
        }
    }
    
    function judgement(bool verify) public returns (string memory){
        require(currentStatus==status.suspended);
        require(msg.sender==judger);
        if(verify==true){
            currentStatus=status.ended;
            return "Confirmed";
        }else{
            currentStatus= status.failed;
            return "Rejected";
        }
    }
    
    function WithdrawTannery() public payable returns(string memory){
        require(msg.sender==tannery);
        require(currentStatus==status.ended);
        tannery.transfer(amount+deposit);
        return "Success";
    }
    
     function WithdrawManufacturer() public payable returns(string memory){
        require(msg.sender==manufacturer);
        require(currentStatus==status.failed);
        manufacturer.transfer(amount+deposit);
        return "Success";
    }
}


contract BuyLeatherProducts{
    
    uint256 public startDate;
    uint256 public day;
    uint256 public amount;
    uint256 public deposit;
    uint256 OrderedNumber;
    string OrderedBreed;
    uint256 DeliveredNumber;
    string DeliveredBreed;
    address  distributer;
    address  manufacturer;
    address judger;
    
    enum status {ordered, notStarted, paied, started, ended, suspended, failed}
    status currentStatus;
    
    constructor( address  _distributer, address  _manufacturer, address _judger, uint256  _day, uint256 _deposit)public{
        distributer= _distributer;
        manufacturer=_manufacturer;
        judger= _judger;
        day= _day;
        deposit= _deposit;
        currentStatus= status.notStarted;
    }
    
    function Order(uint256 _number, string memory _breed) public returns(uint256, string memory){
        require(msg.sender== distributer);
        require(currentStatus== status.notStarted);
        OrderedNumber= _number;
        OrderedBreed= _breed;
        currentStatus= status.ordered;
        return(OrderedNumber,OrderedBreed);
    }
    
    function CheckOrder(uint256 price) public returns (uint256){
        require(msg.sender== manufacturer);
        require(currentStatus == status.ordered);
        amount= price*OrderedNumber;
        return amount;
    }
    
    function Pay() public payable returns(string memory){
        require(currentStatus== status.ordered);
        require(msg.sender== distributer);
        require(msg.value== amount);
        startDate= block.timestamp;
        currentStatus= status.paied;
        return "Success";
    }
    
    function Deposit() public payable returns(string memory){
        require(msg.sender==manufacturer);
        require(msg.value==deposit);
        require(currentStatus== status.paied);
        currentStatus= status.started;
        return "Success";
    }
    
    function Confirm (bool verify ) public returns(string memory){
        require(msg.sender==distributer);
        require(currentStatus== status.started);
        if(verify==true){
            currentStatus= status.ended;
            return "Ended Successfully";
        }else{
            if(block.timestamp>(day*84600)+startDate){
                currentStatus=status.suspended;
                return "Suspended";
            }else{
                return "Deadline Is Not Finished";
            }
        }
    }
    
    function judgement(bool verify) public returns (string memory){
        require(currentStatus==status.suspended);
        require(msg.sender==judger);
        if(verify==true){
            currentStatus=status.ended;
            return "Confirmed";
        }else{
            currentStatus= status.failed;
            return "Rejected";
        }
    }
    
    function WithdrawManufacturer() public payable returns(string memory){
        require(msg.sender==manufacturer);
        require(currentStatus==status.ended);
        manufacturer.transfer(amount+deposit);
        return "Success";
    }
    
     function WithdrawDistributer() public payable returns(string memory){
        require(msg.sender==distributer);
        require(currentStatus==status.failed);
        distributer.transfer(amount+deposit);
        return "Success";
    }
}


contract DealWithDistributers{
    
    uint256 public startDate;
    uint256 public day;
    uint256 public amount;
    uint256 public deposit;
    uint256 OrderedNumber;
    string OrderedBreed;
    uint256 DeliveredNumber;
    string DeliveredBreed;
    address  retailer;
    address  distributer;
    address judger;
    
    enum status {ordered, notStarted, paied, started, ended, suspended, failed}
    status currentStatus;
    
    constructor( address  _retailer, address  _distributer, address _judger, uint256  _day, uint256 _deposit)public{
        retailer= _retailer;
        distributer=_distributer;
        judger= _judger;
        day= _day;
        deposit= _deposit;
        currentStatus= status.notStarted;
    }
    
    function Order(uint256 _number, string memory _breed) public returns(uint256, string memory){
        require(msg.sender== retailer);
        require(currentStatus== status.notStarted);
        OrderedNumber= _number;
        OrderedBreed= _breed;
        currentStatus= status.ordered;
        return(OrderedNumber,OrderedBreed);
    }
    
    function CheckOrder(uint256 price) public returns (uint256){
        require(msg.sender== distributer);
        require(currentStatus == status.ordered);
        amount= price*OrderedNumber;
        return amount;
    }
    
    function Pay() public payable returns(string memory){
        require(currentStatus== status.ordered);
        require(msg.sender== retailer);
        require(msg.value== amount);
        startDate= block.timestamp;
        currentStatus= status.paied;
        return "Success";
    }
    
    function Deposit() public payable returns(string memory){
        require(msg.sender==distributer);
        require(msg.value==deposit);
        require(currentStatus== status.paied);
        currentStatus= status.started;
        return "Success";
    }
    
    function Confirm (bool verify ) public returns(string memory){
        require(msg.sender==retailer);
        require(currentStatus== status.started);
        if(verify==true){
            currentStatus= status.ended;
            return "Ended Successfully";
        }else{
            if(block.timestamp>(day*84600)+startDate){
                currentStatus=status.suspended;
                return "Suspended";
            }else{
                return "Deadline Is Not Finished";
            }
        }
    }
    
    function judgement(bool verify) public returns (string memory){
        require(currentStatus==status.suspended);
        require(msg.sender==judger);
        if(verify==true){
            currentStatus=status.ended;
            return "Confirmed";
        }else{
            currentStatus= status.failed;
            return "Rejected";
        }
    }
    
    function WithdrawDistributer() public payable returns(string memory){
        require(msg.sender==distributer);
        require(currentStatus==status.ended);
        distributer.transfer(amount+deposit);
        return "Success";
    }
    
     function WithdrawRetailer() public payable returns(string memory){
        require(msg.sender==retailer);
        require(currentStatus==status.failed);
        retailer.transfer(amount+deposit);
        return "Success";
    }
}




contract SellToCustomer{
    
    uint256 public startDate;
    uint256 public day;
    uint256 public amount;
    uint256 public deposit;
    uint256 OrderedNumber;
    string OrderedBreed;
    uint256 DeliveredNumber;
    string DeliveredBreed;
    address  customer;
    address  retailer;
    address judger;
    
    enum status {ordered, notStarted, paied, started, ended, suspended, failed}
    status currentStatus;
    
    constructor( address  _customer, address  _retailer, address _judger, uint256  _day, uint256 _deposit)public{
        customer= _customer;
        retailer=_retailer;
        judger= _judger;
        day= _day;
        deposit= _deposit;
        currentStatus= status.notStarted;
    }
    
    function Order(uint256 _number, string memory _breed) public returns(uint256, string memory){
        require(msg.sender== customer);
        require(currentStatus== status.notStarted);
        OrderedNumber= _number;
        OrderedBreed= _breed;
        currentStatus= status.ordered;
        return(OrderedNumber,OrderedBreed);
    }
    
    function CheckOrder(uint256 price) public returns (uint256){
        require(msg.sender== retailer);
        require(currentStatus == status.ordered);
        amount= price*OrderedNumber;
        return amount;
    }
    
    function Pay() public payable returns(string memory){
        require(currentStatus== status.ordered);
        require(msg.sender== customer);
        require(msg.value== amount);
        startDate= block.timestamp;
        currentStatus= status.paied;
        return "Success";
    }
    
    function Deposit() public payable returns(string memory){
        require(msg.sender==retailer);
        require(msg.value==deposit);
        require(currentStatus== status.paied);
        currentStatus= status.started;
        return "Success";
    }
    
    function Confirm (bool verify ) public returns(string memory){
        require(msg.sender==customer);
        require(currentStatus== status.started);
        if(verify==true){
            currentStatus= status.ended;
            return "Ended Successfully";
        }else{
            if(block.timestamp>(day*84600)+startDate){
                currentStatus=status.suspended;
                return "Suspended";
            }else{
                return "Deadline Is Not Finished";
            }
        }
    }
    
    function judgement(bool verify) public returns (string memory){
        require(currentStatus==status.suspended);
        require(msg.sender==judger);
        if(verify==true){
            currentStatus=status.ended;
            return "Confirmed";
        }else{
            currentStatus= status.failed;
            return "Rejected";
        }
    }
    
    function WithdrawRetailer() public payable returns(string memory){
        require(msg.sender==retailer);
        require(currentStatus==status.ended);
        retailer.transfer(amount+deposit);
        return "Success";
    }
    
     function WithdrawCustomer() public payable returns(string memory){
        require(msg.sender==customer);
        require(currentStatus==status.failed);
        customer.transfer(amount+deposit);
        return "Success";
    }
}