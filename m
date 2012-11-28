From: Andy Green <andy.green@linaro.org>
Subject: [try#1 PATCH 6/7] omap4 panda add smsc95xx clock dependent on root
 hub
Date: Wed, 28 Nov 2012 13:00:00 +0000
Message-ID: <20121128130000.29569.82202.stgit@build.warmcat.com>
References: <20121128124744.29569.52739.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:59189 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999Ab2K1NAE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 08:00:04 -0500
In-Reply-To: <20121128124744.29569.52739.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rogerq@ti.com, keshava_mgowda@ti.com, balbi@ti.com, stern@rowland.harvard.edu

This patch makes the ULPI PHY clock control also be a device_asset
of the ehci-omap.0 device, along with the [HUB + ETH] smsc95xx chip
power regulator.

Without clock control, the PHY clock is running all the time from
boot whether USB is in use or not, and during suspend distorting
power measurements there.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 arch/arm/mach-omap2/board-omap4panda.c |   25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 52add03..97489c7 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -150,6 +150,12 @@ static struct device_asset assets_ehci_omap0[] = {
 		.pre_probe = regulator_asset_default_preprobe,
 		.post_remove = regulator_asset_default_postremove,
 	},
+	{
+		.name = "auxclk3_ck",
+		.data = (void *)19200000,
+		.pre_probe = clk_asset_default_preprobe,
+		.post_remove = clk_asset_default_postremove,
+	},
 	{ }
 };
 
@@ -164,23 +170,6 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.assets = assets_ehci_omap0,
 };
 
-static void __init omap4_ehci_init(void)
-{
-	int ret;
-	struct clk *phy_ref_clk;
-
-	/* FREF_CLK3 provides the 19.2 MHz reference clock to the PHY */
-	phy_ref_clk = clk_get(NULL, "auxclk3_ck");
-	if (IS_ERR(phy_ref_clk)) {
-		pr_err("Cannot request auxclk3\n");
-		return;
-	}
-	clk_set_rate(phy_ref_clk, 19200000);
-	clk_prepare_enable(phy_ref_clk);
-
-	usbhs_init(&usbhs_bdata);
-}
-
 /*
  * hub_nreset also resets the ULPI PHY and is required after powering SMSC chip
  *	ULPI PHY is always powered... need to do reset once for both once
@@ -567,7 +556,7 @@ static void __init omap4_panda_init(void)
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap4_twl6030_hsmmc_init(mmc);
-	omap4_ehci_init();
+	usbhs_init(&usbhs_bdata);
 	usb_musb_init(&musb_board_data);
 	omap4_panda_display_init();
 }

