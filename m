From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 04/17] OMAP2,3 DSS2 Change driver name to omap_display
Date: Mon,  3 Jan 2011 18:20:56 +0530
Message-ID: <1294059069-26737-5-git-send-email-svadivu@ti.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48368 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503Ab1ACMvZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 07:51:25 -0500
In-Reply-To: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Change the driver name from omapdss to omap_display as the driver takes care of
the display devices ie number of panels, type of panels available in the
platform.  Change the device name in the board files and 2420,2430,3xxx clock
files from omapdss to omap_display to match the driver name.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c        |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    6 +++---
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    6 +++---
 arch/arm/mach-omap2/board-omap3evm.c         |    4 ++--
 arch/arm/mach-omap2/board-omap3pandora.c     |    8 ++++----
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++--
 arch/arm/mach-omap2/board-rx51-video.c       |    2 +-
 arch/arm/mach-omap2/clock2420_data.c         |    8 ++++----
 arch/arm/mach-omap2/clock2430_data.c         |    8 ++++----
 arch/arm/mach-omap2/clock3xxx_data.c         |   14 +++++++-------
 drivers/video/omap2/dss/core.c               |    2 +-
 15 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 3b39ef1..10a399e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -302,7 +302,7 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 };
 
 static struct platform_device sdp3430_dss_device = {
-	.name		= "omapdss",
+	.name		= "omap_display",
 	.id		= -1,
 	.dev		= {
 		.platform_data = &sdp3430_dss_data,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index bc15626..2b37dcf 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -368,7 +368,7 @@ static struct omap_dss_board_info am3517_evm_dss_data = {
 };
 
 static struct platform_device am3517_evm_dss_device = {
-	.name		= "omapdss",
+	.name		= "omap_display",
 	.id		= -1,
 	.dev		= {
 		.platform_data	= &am3517_evm_dss_data,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 486a3de..f0293a3 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -391,7 +391,7 @@ static struct omap_dss_board_info cm_t35_dss_data = {
 };
 
 static struct platform_device cm_t35_dss_device = {
-	.name		= "omapdss",
+	.name		= "omap_display",
 	.id		= -1,
 	.dev		= {
 		.platform_data = &cm_t35_dss_data,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 451e7ff..f948435 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -189,7 +189,7 @@ static struct omap_dss_board_info devkit8000_dss_data = {
 };
 
 static struct platform_device devkit8000_dss_device = {
-	.name		= "omapdss",
+	.name		= "omap_display",
 	.id		= -1,
 	.dev		= {
 		.platform_data = &devkit8000_dss_data,
@@ -197,7 +197,7 @@ static struct platform_device devkit8000_dss_device = {
 };
 
 static struct regulator_consumer_supply devkit8000_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_1),
@@ -272,7 +272,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 };
 
 static struct regulator_consumer_supply devkit8000_vpll1_supply =
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data devkit8000_vmmc1 = {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0afa301..46985eb 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -479,7 +479,7 @@ static struct omap_dss_board_info igep2_dss_data = {
 };
 
 static struct platform_device igep2_dss_device = {
-	.name	= "omapdss",
+	.name	= "omap_display",
 	.id	= -1,
 	.dev	= {
 		.platform_data = &igep2_dss_data,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6c12760..ebfddb8 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -223,7 +223,7 @@ static struct omap_dss_board_info beagle_dss_data = {
 };
 
 static struct platform_device beagle_dss_device = {
-	.name          = "omapdss",
+	.name          = "omap_display",
 	.id            = -1,
 	.dev            = {
 		.platform_data = &beagle_dss_data,
@@ -231,10 +231,10 @@ static struct platform_device beagle_dss_device = {
 };
 
 static struct regulator_consumer_supply beagle_vdac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 static struct regulator_consumer_supply beagle_vdvi_supply =
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display");
 
 static void __init beagle_display_init(void)
 {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3de8d9b..2851984 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -323,7 +323,7 @@ static struct omap_dss_board_info omap3_evm_dss_data = {
 };
 
 static struct platform_device omap3_evm_dss_device = {
-	.name		= "omapdss",
+	.name		= "omap_display",
 	.id		= -1,
 	.dev		= {
 		.platform_data = &omap3_evm_dss_data,
@@ -516,7 +516,7 @@ static struct regulator_init_data omap3_evm_vdac = {
 
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply omap3_evm_vpll2_supply =
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display");
 
 static struct regulator_init_data omap3_evm_vpll2 = {
 	.constraints = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index d457b59..5d69320 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -254,7 +254,7 @@ static struct omap_dss_board_info pandora_dss_data = {
 };
 
 static struct platform_device pandora_dss_device = {
-	.name		= "omapdss",
+	.name		= "omap_display",
 	.id		= -1,
 	.dev		= {
 		.platform_data = &pandora_dss_data,
@@ -350,11 +350,11 @@ static struct regulator_consumer_supply pandora_vmmc3_supply =
 	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.2");
 
 static struct regulator_consumer_supply pandora_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 static struct regulator_consumer_supply pandora_vdds_supplies[] = {
-	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_sdi", "omap_display"),
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display"),
 };
 
 static struct regulator_consumer_supply pandora_vcc_lcd_supply =
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 9df9d93..7f080d6 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -230,7 +230,7 @@ static struct omap_dss_board_info omap3_stalker_dss_data = {
 };
 
 static struct platform_device omap3_stalker_dss_device = {
-	.name	= "omapdss",
+	.name	= "omap_display",
 	.id	= -1,
 	.dev	= {
 		.platform_data	= &omap3_stalker_dss_data,
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e75e240..7aedafd 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -360,11 +360,11 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 };
 
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
-	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_sdi", "omap_display"),
 };
 
 static struct regulator_consumer_supply rx51_vdac_supply[] = {
-	REGULATOR_SUPPLY("vdda_dac", "omapdss"),
+	REGULATOR_SUPPLY("vdda_dac", "omap_display"),
 };
 
 static struct regulator_init_data rx51_vaux1 = {
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index acd6700..8140d05 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -67,7 +67,7 @@ static struct omap_dss_board_info rx51_dss_board_info = {
 };
 
 struct platform_device rx51_display_device = {
-	.name	= "omapdss",
+	.name	= "omap_display",
 	.id	= -1,
 	.dev	= {
 		.platform_data = &rx51_dss_board_info,
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index ed1295f..a220820 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1786,10 +1786,10 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_242X),
 	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
 	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_242X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_242X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_242X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_242X),
+	CLK("omap_display",	"ick",		&dss_ick,	CK_242X),
+	CLK("omap_display",	"dss1_fck",	&dss1_fck,	CK_242X),
+	CLK("omap_display",	"dss2_fck",	&dss2_fck,	CK_242X),
+	CLK("omap_display",	"tv_fck",	&dss_54m_fck,	CK_242X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_242X),
 	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 38341a7..78f7712 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1890,10 +1890,10 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
 	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
 	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_243X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X),
+	CLK("omap_display",	"ick",		&dss_ick,	CK_243X),
+	CLK("omap_display",	"dss1_fck",	&dss1_fck,	CK_243X),
+	CLK("omap_display",	"dss2_fck",	&dss2_fck,	CK_243X),
+	CLK("omap_display",	"tv_fck",	&dss_54m_fck,	CK_243X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X),
 	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 9ab817e..8c9e4c4 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3355,13 +3355,13 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_34XX | CK_36XX),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
-	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
-	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
-	CLK("omapdss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("omap_display",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
+	CLK("omap_display",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("omap_display",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
+	CLK("omap_display",	"video_fck",	&dss_96m_fck,	CK_3XXX),
+	CLK("omap_display",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
+	CLK("omap_display",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
+	CLK("omap_display",	"ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_34XX | CK_36XX),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_34XX | CK_36XX),
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8e89f60..48d20d8 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -715,7 +715,7 @@ static struct platform_driver omap_dss_driver = {
 	.suspend	= omap_dss_suspend,
 	.resume		= omap_dss_resume,
 	.driver         = {
-		.name   = "omapdss",
+		.name   = "omap_display",
 		.owner  = THIS_MODULE,
 	},
 };
-- 
1.6.3.3

