From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usb: otg: isp1301_omap: fix potential NULL pointer dereference
Date: Mon, 8 Oct 2012 08:46:09 +0800
Message-ID: <CAPgLHd-21EJ3CMaFVzckj8=iZdBXW=rthttTnseNrfoH+aCcAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

The dereference should be moved below the NULL test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/usb/otg/isp1301_omap.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index ceee211..3a1f8e2 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -1279,9 +1279,13 @@ static int isp1301_otg_enable(struct isp1301 *isp)
 static int
 isp1301_set_host(struct usb_otg *otg, struct usb_bus *host)
 {
-	struct isp1301	*isp = container_of(otg->phy, struct isp1301, phy);
+	struct isp1301 *isp;
 
-	if (!otg || isp != the_transceiver)
+	if (!otg)
+		return -ENODEV;
+
+	isp = container_of(otg->phy, struct isp1301, phy);
+	if (isp != the_transceiver)
 		return -ENODEV;
 
 	if (!host) {
@@ -1335,9 +1339,13 @@ isp1301_set_host(struct usb_otg *otg, struct usb_bus *host)
 static int
 isp1301_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
 {
-	struct isp1301	*isp = container_of(otg->phy, struct isp1301, phy);
+	struct isp1301 *isp;
+
+	if (!otg)
+		return -ENODEV;
 
-	if (!otg || isp != the_transceiver)
+	isp = container_of(otg->phy, struct isp1301, phy);
+	if (isp != the_transceiver)
 		return -ENODEV;
 
 	if (!gadget) {
@@ -1415,11 +1423,14 @@ isp1301_set_power(struct usb_phy *dev, unsigned mA)
 static int
 isp1301_start_srp(struct usb_otg *otg)
 {
-	struct isp1301	*isp = container_of(otg->phy, struct isp1301, phy);
+	struct isp1301	*isp;
 	u32		otg_ctrl;
 
-	if (!otg || isp != the_transceiver
-			|| isp->phy.state != OTG_STATE_B_IDLE)
+	if (!otg)
+		return -ENODEV;
+
+	isp = container_of(otg->phy, struct isp1301, phy);
+	if (isp != the_transceiver || isp->phy.state != OTG_STATE_B_IDLE)
 		return -ENODEV;
 
 	otg_ctrl = omap_readl(OTG_CTRL);
@@ -1443,10 +1454,13 @@ static int
 isp1301_start_hnp(struct usb_otg *otg)
 {
 #ifdef	CONFIG_USB_OTG
-	struct isp1301	*isp = container_of(otg->phy, struct isp1301, phy);
+	struct isp1301 *isp;
 	u32 l;
 
-	if (!otg || isp != the_transceiver)
+	if (!otg)
+		return -ENODEV;
+	isp = container_of(otg->phy, struct isp1301, phy);
+	if (isp != the_transceiver)
 		return -ENODEV;
 	if (otg->default_a && (otg->host == NULL || !otg->host->b_hnp_enable))
 		return -ENOTCONN;

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
