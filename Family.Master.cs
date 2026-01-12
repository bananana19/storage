using System;
using System.Web;

namespace try1
{
    public partial class Family : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Basic Security: If they aren't logged in, don't show the nav, send them away
            if (Session["UserName"] == null)
            {
                Response.Redirect("Loginfamily.aspx");
                return;
            }

            // 2. Display the logged-in user's name
            litName.Text = Session["UserName"].ToString();

            // 3. Dynamic Link Routing
            // We append the PatientID so the destination pages know whose data to show
            if (Session["PatientID"] != null)
            {
                string pId = Session["PatientID"].ToString();

                lnkMeds.NavigateUrl = "~/PatientDetails.aspx?id=" + pId;
                lnkBilling.NavigateUrl = "~/Billing.aspx?id=" + pId;
                lnkDelivery.NavigateUrl = "~/DeliveryStatus.aspx?id=" + pId;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Loginfamily.aspx");
        }
    }
}
