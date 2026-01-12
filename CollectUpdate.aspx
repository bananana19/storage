<%@ Page Title="Collect Update" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CollectUpdate.aspx.cs" Inherits="try1.CollectUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .status-collected {
            color: #2ecc71;
            font-weight: bold;
        }

        .status-scheduled {
            color: #f39c12;
            font-weight: bold;
        }

        .action-panel {
            background: #f4f7f6;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2 class="mt-3">Medicine Collection Management</h2>

        <div class="action-panel">
            <h4>Schedule New Collection</h4>
            <div class="row">
                <div class="col-md-3">
                    Prescription:
                    <asp:DropDownList ID="ddlPrescription" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    Projected Depletion Date:
                    <asp:TextBox ID="txtDepletionDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <br />
                    <asp:Button ID="btnSchedule" runat="server" Text="Create Schedule" CssClass="btn btn-primary" OnClick="btnSchedule_Click" />
                </div>
            </div>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Blue"></asp:Label>
        </div>

        <h3>Current Schedules</h3>
        <asp:GridView ID="gvCollections" runat="server" CssClass="table table-hover" AutoGenerateColumns="False"
            DataKeyNames="CollectionID" OnRowCommand="gvCollections_RowCommand">
            <Columns>
                <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                <asp:BoundField DataField="MedicineDisplay" HeaderText="Medicine" />
                <asp:BoundField DataField="ProjectedDepletionDate" HeaderText="Depletion Date" DataFormatString="{0:MMM dd, yyyy}" />
                <asp:BoundField DataField="ReminderDate" HeaderText="Reminder Date" DataFormatString="{0:MMM dd, yyyy}" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'
                            CssClass='<%# Eval("Status").ToString() == "Collected" ? "status-collected" : "status-scheduled" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnMark" runat="server" CommandName="UpdateStatus" CommandArgument='<%# Eval("CollectionID") %>'
                            Text="Mark Collected" CssClass="btn btn-sm btn-success" Visible='<%# Eval("Status").ToString() != "Collected" %>' />
                        &nbsp;
               
                        <asp:LinkButton ID="btnDel" runat="server" CommandName="DeleteRecord" CommandArgument='<%# Eval("CollectionID") %>'
                            Text="Delete" CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Delete this record?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <asp:Button ID="btn_return" runat="server" OnClick="btn_return_Click" Text="Return to Home" Width="141px" />
    </div>
</asp:Content>
