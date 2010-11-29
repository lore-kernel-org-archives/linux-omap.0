From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v2 2/8] usb: ehci-omap: don't hard-code TLL channel count
Date: Mon, 29 Nov 2010 22:55:31 +0530
Message-ID: <1291051537-23743-3-git-send-email-gadiyar@ti.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53353 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab0K2RZt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 12:25:49 -0500
In-Reply-To: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

From: Keshava Munegowda <keshava_mgowda@ti.com>

Make the TLL channel count a parameter instead of a hardcoded
value. This allows us to be flexible with future OMAP revisions
which could have a different number of channels.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
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

