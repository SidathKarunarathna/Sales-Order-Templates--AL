table 50102 "Sales Order Templates"
{
    Caption = 'Sales Order Templates';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Template Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(4; "Posted No.Series"; Code[20])
        {
            Caption = 'Posted No.Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
        }
        field(6; "Sell-to-Customer-No."; Code[20])
        {
            Caption = 'Sell-to-Customer-No.';
            DataClassification = ToBeClassified;
            TableRelation=Customer;
        }
    }
    keys
    {
        key(PK; "Template Code")
        {
            Clustered = true;
        }
    }
}
