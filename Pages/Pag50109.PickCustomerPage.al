page 50109 "Pick Customer Page"
{
    Caption = 'Pick Customer Page';
    PageType = StandardDialog;
    
    layout
    {
        area(content)
        {
            
                field(CustomerNO; CustomerNO)
                {
                    TableRelation=Customer;
                    Caption='Customer No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
            
        }
    }
    procedure GetCustomerNo():Code[20]
    begin
        exit( CustomerNO);
    end;
    var
     CustomerNO: Code[20];
}
