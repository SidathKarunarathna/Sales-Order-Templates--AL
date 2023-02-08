tableextension 50101 "Sales header Ext" extends "Sales Header"
{
    fields
    {
        field(50100; NotRefreshed; Boolean)
        {
            Caption = 'Refreshed';
            DataClassification = ToBeClassified;
        }
    }
}
