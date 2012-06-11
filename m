From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 9/9] ARM: OMAP2+: board omap3beagle: use gpmc driver
Date: Mon, 11 Jun 2012 20:30:05 +0530
Message-ID: <674253dbe5614c74133579033296125b725d6994.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52412 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754909Ab2FKPPp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:15:45 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5aa8f28..0fe70ed 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -77,6 +77,12 @@ enum {
 
 static u8 omap3_beagle_version;
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 /*
  * Board-specific configuration
  * Defaults to BeagleBoard-xMC
@@ -499,6 +505,8 @@ static void __init beagle_opp_init(void)
 
 static void __init omap3_beagle_init(void)
 {
+	struct omap_nand_platform_data *nand_data;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 
@@ -524,9 +532,13 @@ static void __init omap3_beagle_init(void)
 
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
-	board_nand_init(omap3beagle_nand_partitions,
+	nand_data = board_nand_update(omap3beagle_nand_partitions,
 		ARRAY_SIZE(omap3beagle_nand_partitions), NAND_CS,
-		NAND_BUSWIDTH_16, NULL);
+		NAND_BUSWIDTH_16, nand_default_timings);
+	*gpmc_device_data = gpmc_nand_update(nand_data);
+	if (!*gpmc_device_data)
+		pr_err("error: unable to initilaize gpmc nand\n");
+	omap_gpmc_init(&gpmc_data);
 
 	/* Ensure msecure is mux'd to be able to set the RTC. */
 	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
-- 
1.7.10.2

