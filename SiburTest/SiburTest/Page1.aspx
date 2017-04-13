<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page1.aspx.cs" Inherits="SiburTest.Page1" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
    <asp:SqlDataSource ID="StuffSource" runat="server" ConnectionString="<%$ connectionStrings:SiburConnection %>"
        SelectCommand="
        SELECT 0 Id, NULL FirstName, NULL LastName
        UNION ALL
        SELECT Id, FirstName, LastName FROM EmployeeSet"
        UpdateCommand="
        IF @Id > 0
            UPDATE EmployeeSet SET FirstName = @FirstName, LastName = @LastName WHERE Id = @Id
        ELSE
            INSERT INTO EmployeeSet (FirstName, LastName) VALUES (@FirstName, @LastName)"
        InsertCommand="INSERT INTO EmployeeSet (FirstName, LastName) VALUES (@FirstName, @LastName)"
        DeleteCommand="DELETE FROM EmployeeSet WHERE Id = @Id">
        <InsertParameters>
            <asp:FormParameter Name="FirstName" FormField="txtFirstName" />
            <asp:FormParameter Name="LastName" FormField="txtLastName" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="grid" runat="server" DataSourceID="StuffSource" AutoGenerateColumns="False" DataKeyNames="Id"
        OnRowDataBound="grid_RowDataBound"
        ShowHeaderWhenEmpty="True" 
        OnRowEditing="grid_RowEditing" OnRowCancelingEdit="grid_RowCancelingEdit">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton runat="server" Text="Создать" Visible='<%# Convert.ToInt32(Eval("Id")) == 0 %>'
                        ID="btnNew" CommandName="Edit" CommandArgument="<%# Container.DataItemIndex %>"/>
                    <asp:LinkButton runat="server" Text="Правка" Visible='<%# Convert.ToInt32(Eval("Id")) > 0 %>'
                        ID="btnEdit" CommandName="Edit"/>
                    <asp:LinkButton runat="server" Text="Удалить" Visible='<%# Convert.ToInt32(Eval("Id")) > 0 %>'
                        ID="btnDelete" CommandName="Delete" />
                    <asp:LinkButton runat="server" Text="Сохранить" Visible='<%# Convert.ToInt32(Eval("Id")) > 0 %>'
                        ID="btnUpdate" CommandName="Update" />
                    <asp:LinkButton runat="server" Text="Отмена" Visible='<%# Convert.ToInt32(Eval("Id")) > 0 %>'
                        ID="btnCancel" CommandName="Cancel" CommandArgument="<%# Container.DataItemIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
            <asp:TemplateField HeaderText="Имя">
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%#Eval("FirstName") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%#Bind("FirstName") %>' Id="txtFN"/><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFN" ErrorMessage="Значение не должно быть пустым" 
                        Font-Bold="true" ForeColor="Red"/>
                </EditItemTemplate>
            </asp:TemplateField>
           <asp:TemplateField HeaderText="Фамилия">
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%#Eval("LastName") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%#Bind("LastName") %>' Id="txtLN"/><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLN" ErrorMessage="Значение не должно быть пустым" 
                        Font-Bold="true" ForeColor="Red"/>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>
    
</asp:Content>
