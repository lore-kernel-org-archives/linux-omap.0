From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Tue, 15 Sep 2015 17:10:06 +0300
Message-ID: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

McASP3 is used by default on DRA7x based boards for audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Paul,

this patch is part of my earlier series and as Tony suggested I'll resend the
hwmod patch for you to review since I missed you from the TO in the series.

The original series:
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg119319.html

Regards,
Peter

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 562247bced49..c38b7fa30c27 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1298,6 +1298,38 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 };
 
 /*
+ * 'mcasp' class
+ *
+ */
+static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc = {
+	.sysc_offs	= 0x0004,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dra7xx_mcasp_hwmod_class = {
+	.name	= "mcasp",
+	.sysc	= &dra7xx_mcasp_sysc,
+};
+
+/* mcasp3 */
+static struct omap_hwmod dra7xx_mcasp3_hwmod = {
+	.name		= "mcasp3",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp3_ahclkx_mux",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'mmc' class
  *
  */
@@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per2 -> mcasp3 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp3_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space dra7xx_elm_addrs[] = {
 	{
 		.pa_start	= 0x48078000,
@@ -3338,6 +3378,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
 	&dra7xx_l4_per2__cpgmac0,
+	&dra7xx_l4_per2__mcasp3,
 	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__dss,
-- 
2.5.0
