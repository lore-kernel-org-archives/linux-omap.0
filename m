From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/11] usb: ehci-omap: don't hard-code TLL channel count
Date: Mon, 22 Nov 2010 00:10:05 +0530
Message-ID: <1290364814-4417-3-git-send-email-gadiyar@ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290364814-4417-2-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Make the TLL channel count a parameter instead of a hardcoded
value. This allows us to be flexible with future OMAP revisions
which could have a different number of channels.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index d042bde..d60efdc 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -191,13 +191,14 @@ struct ehci_hcd_omap {
 
 /*-------------------------------------------------------------------------*/
 
-static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
+static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask,
+				u8 tll_channel_count)
 {
 	unsigned reg;
 	int i;
 
 	/* Program the 3 TLL channels upfront */
-	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+	for (i = 0; i < tll_channel_count; i++) {
 		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
 
 		/* Disable AutoIdle, BitStuffing and use SDR Mode */
@@ -217,7 +218,7 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 	ehci_omap_writel(omap->tll_base, OMAP_TLL_SHARED_CONF, reg);
 
 	/* Enable channels now */
-	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+	for (i = 0; i < tll_channel_count; i++) {
 		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
 
 		/* Enable only the reg that is needed */
@@ -438,7 +439,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 			tll_ch_mask |= OMAP_TLL_CHANNEL_3_EN_MASK;
 
 		/* Enable UTMI mode for required TLL channels */
-		omap_usb_utmi_init(omap, tll_ch_mask);
+		omap_usb_utmi_init(omap, tll_ch_mask, OMAP_TLL_CHANNEL_COUNT);
 	}
 
 	if (omap->phy_reset) {
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
