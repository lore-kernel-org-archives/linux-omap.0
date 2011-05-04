From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from "omapdss_dsi1" to "omapdss_dsi"
Date: Wed,  4 May 2011 13:08:16 +0530
Message-ID: <1304494704-7285-2-git-send-email-archit@ti.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51256 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab1EDHde (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 03:33:34 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p447XYIh027840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 02:33:34 -0500
In-Reply-To: <1304494704-7285-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, there are 2 differently named platform devices generated for the 2
DSS DSI modules. In order to use the same driver, the dsi devices should be 2
instances of the same platform device.

Change the platform device name from "omapdss_dsi1" to omapdss_dsi". Propagate
this change across all omap board files which need to use this new name. Don't
create a DSI2 platform device instance for now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
 arch/arm/mach-omap2/board-overo.c            |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/display.c                |    5 ++---
 drivers/video/omap2/dss/dsi.c                |   18 +++++++++---------
 12 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..9da362b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -401,7 +401,7 @@ static struct regulator_consumer_supply sdp3430_vdda_dac_supplies[] = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 570e83f..eafadb4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -375,7 +375,7 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 };
 static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 65f9fde..81f9c64 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -279,7 +279,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 34cf982..279a553 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -487,7 +487,7 @@ static struct omap_dss_board_info igep2_dss_data = {
 
 static struct regulator_consumer_supply igep2_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_init_data igep2_vpll2 = {
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 33007fd..8197d0d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -236,7 +236,7 @@ static struct regulator_consumer_supply beagle_vdac_supply =
 
 static struct regulator_consumer_supply beagle_vdvi_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static void __init beagle_display_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5a1a916..e5b74f8 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -562,7 +562,7 @@ static struct regulator_init_data omap3_evm_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_init_data omap3_evm_vpll2 = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 07dba88..3554892 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -347,7 +347,7 @@ static struct regulator_consumer_supply pandora_vdda_dac_supply =
 static struct regulator_consumer_supply pandora_vdds_supplies[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_consumer_supply pandora_vcc_lcd_supply =
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a6e0b91..c369e8e 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -459,7 +459,7 @@ static struct regulator_init_data omap3_stalker_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply omap3_stalker_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_init_data omap3_stalker_vpll2 = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 59ca333..e281c7e 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -380,7 +380,7 @@ static struct regulator_consumer_supply overo_vdda_dac_supply =
 
 static struct regulator_consumer_supply overo_vdds_dsi_supply[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct mtd_partition overo_nand_partitions[] = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 8dee754..6f75d7a 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -228,7 +228,7 @@ static struct omap2_hsmmc_info mmc[] = {
 
 static struct regulator_consumer_supply zoom_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_consumer_supply zoom_vdda_dac_supply =
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index fa83eb3..f0e9cbf 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -74,7 +74,7 @@ static const struct omap_dss_hwmod_data omap3_dss_hwmod_data[] __initdata = {
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
-	{ "dss_dsi1", "omapdss_dsi1", -1 },
+	{ "dss_dsi1", "omapdss_dsi", 0 },
 };
 
 static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
@@ -82,8 +82,7 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
-	{ "dss_dsi1", "omapdss_dsi1", -1 },
-	{ "dss_dsi2", "omapdss_dsi2", -1 },
+	{ "dss_dsi1", "omapdss_dsi", 0 },
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 3d1dec3..6c528b7 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4128,8 +4128,8 @@ static void dsi_exit(void)
 	DSSDBG("omap_dsi_exit\n");
 }
 
-/* DSI1 HW IP initialisation */
-static int omap_dsi1hw_probe(struct platform_device *pdev)
+/* DSI HW IP initialisation */
+static int omap_dsihw_probe(struct platform_device *pdev)
 {
 	int r;
 	dsi.pdev = pdev;
@@ -4142,28 +4142,28 @@ err_dsi:
 	return r;
 }
 
-static int omap_dsi1hw_remove(struct platform_device *pdev)
+static int omap_dsihw_remove(struct platform_device *pdev)
 {
 	dsi_exit();
 	WARN_ON(dsi.scp_clk_refcount > 0);
 	return 0;
 }
 
-static struct platform_driver omap_dsi1hw_driver = {
-	.probe          = omap_dsi1hw_probe,
-	.remove         = omap_dsi1hw_remove,
+static struct platform_driver omap_dsihw_driver = {
+	.probe          = omap_dsihw_probe,
+	.remove         = omap_dsihw_remove,
 	.driver         = {
-		.name   = "omapdss_dsi1",
+		.name   = "omapdss_dsi",
 		.owner  = THIS_MODULE,
 	},
 };
 
 int dsi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsi1hw_driver);
+	return platform_driver_register(&omap_dsihw_driver);
 }
 
 void dsi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dsi1hw_driver);
+	return platform_driver_unregister(&omap_dsihw_driver);
 }
-- 
1.7.1

