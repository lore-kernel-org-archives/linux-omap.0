From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 2/5] usb: ehci: don't hard-code TLL channel count.
Date: Wed, 18 Aug 2010 08:25:42 +0530
Message-ID: <1282100145-27485-3-git-send-email-keshava_mgowda@ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab0HROzX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 10:55:23 -0400
In-Reply-To: <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Make TLL channel count a parameter instead of a hardcoded value.
This allows us to be flexible with future OMAP revisions which
could have a different number of channels.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/host/ehci-omap.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/usb/host/ehci-omap.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
+++ linux-2.6/drivers/usb/host/ehci-omap.c
@@ -191,13 +191,14 @@ struct ehci_hcd_omap {
 
 /*-------------------------------------------------------------------------*/
 
-static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
+static void omap_usb_utmi_init(struct ehci_hcd_omap *omap,
+				u8 tll_channel_mask, u8 tll_channel_count)
 {
 	unsigned reg;
 	int i;
 
 	/* Program the 3 TLL channels upfront */
-	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+	for (i = 0; i < tll_channel_count; i++) {
 		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
 
 		/* Disable AutoIdle, BitStuffing and use SDR Mode */
@@ -217,7 +218,7 @@ static void omap_usb_utmi_init(struct eh
 	ehci_omap_writel(omap->tll_base, OMAP_TLL_SHARED_CONF, reg);
 
 	/* Enable channels now */
-	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+	for (i = 0; i < tll_channel_count; i++) {
 		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
 
 		/* Enable only the reg that is needed */
@@ -438,7 +439,7 @@ static int omap_start_ehc(struct ehci_hc
 			tll_ch_mask |= OMAP_TLL_CHANNEL_3_EN_MASK;
 
 		/* Enable UTMI mode for required TLL channels */
-		omap_usb_utmi_init(omap, tll_ch_mask);
+		omap_usb_utmi_init(omap, tll_ch_mask, OMAP_TLL_CHANNEL_COUNT);
 	}
 
 	if (omap->phy_reset) {
