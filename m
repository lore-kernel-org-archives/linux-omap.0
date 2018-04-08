From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/3] ARM: dra762: hwmod: Add MCAN support
Date: Sun, 8 Apr 2018 15:29:00 +0530
Message-ID: <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, faiz_abbas@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Add MCAN hwmod data and register it for dra762 silicons.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 62352d1..a2cd7f8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1356,6 +1356,29 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
 };
 
 /*
+ * 'mcan' class
+ *
+ */
+static struct omap_hwmod_class dra76x_mcan_hwmod_class = {
+	.name	= "mcan",
+};
+
+/* mcan */
+static struct omap_hwmod dra76x_mcan_hwmod = {
+	.name		= "mcan",
+	.class		= &dra76x_mcan_hwmod_class,
+	.clkdm_name	= "wkupaon_clkdm",
+	.main_clk	= "mcan_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_WKUPAON_ADC_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_WKUPAON_ADC_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'mcspi' class
  *
  */
@@ -3818,6 +3841,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss2 = {
 	.user		= OCP_USER_MPU,
 };
 
+/* l3_main_1 -> mcan */
+static struct omap_hwmod_ocp_if dra76x_l3_main_1__mcan = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra76x_mcan_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__dmm,
 	&dra7xx_l3_main_2__l3_instr,
@@ -3958,6 +3989,7 @@ static struct omap_hwmod_ocp_if *dra7xx_gp_hwmod_ocp_ifs[] __initdata = {
 /* SoC variant specific hwmod links */
 static struct omap_hwmod_ocp_if *dra76x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
+	&dra76x_l3_main_1__mcan,
 	NULL,
 };
 
-- 
2.7.4
