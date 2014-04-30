From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM: omap5: hwmod_data: Add AESS related data
Date: Wed, 30 Apr 2014 14:43:28 +0300
Message-ID: <1398858208-1346-2-git-send-email-peter.ujfalusi@ti.com>
References: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757213AbaD3Ln4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 07:43:56 -0400
In-Reply-To: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

Add the needed hwmod entries which is needed for AESS (Audio Engine
SubSystem) and ABE.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index e829664e6a6c..3e20c025b5a4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -146,6 +146,7 @@ static struct omap_hwmod omap54xx_l4_abe_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_L4_ABE_CLKCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_ABE_AESS_CONTEXT_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
@@ -211,6 +212,42 @@ static struct omap_hwmod omap54xx_mpu_private_hwmod = {
 };
 
 /*
+ * 'aess' class
+ * audio engine sub system
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_aess_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART |
+			   MSTANDBY_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap54xx_aess_hwmod_class = {
+	.name	= "aess",
+	.sysc	= &omap54xx_aess_sysc,
+	.enable_preprogram = omap_hwmod_aess_preprogram,
+};
+
+/* aess */
+static struct omap_hwmod omap54xx_aess_hwmod = {
+	.name		= "aess",
+	.class		= &omap54xx_aess_hwmod_class,
+	.clkdm_name	= "abe_clkdm",
+	.main_clk	= "aess_fclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_ABE_AESS_CLKCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_ABE_AESS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'counter' class
  * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
  */
@@ -1892,6 +1929,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__l3_main_3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* aess -> l4_abe */
+static struct omap_hwmod_ocp_if __maybe_unused omap54xx_aess__l4_abe = {
+	.master		= &omap54xx_aess_hwmod,
+	.slave		= &omap54xx_l4_abe_hwmod,
+	.clk		= "abe_iclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> l4_abe */
 static struct omap_hwmod_ocp_if omap54xx_l3_main_1__l4_abe = {
 	.master		= &omap54xx_l3_main_1_hwmod,
@@ -1966,6 +2011,22 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__dma_system = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_abe -> aess */
+static struct omap_hwmod_ocp_if __maybe_unused omap54xx_l4_abe__aess = {
+	.master		= &omap54xx_l4_abe_hwmod,
+	.slave		= &omap54xx_aess_hwmod,
+	.clk		= "abe_iclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4_abe -> aess (dma) */
+static struct omap_hwmod_ocp_if __maybe_unused omap54xx_l4_abe__aess_dma = {
+	.master		= &omap54xx_l4_abe_hwmod,
+	.slave		= &omap54xx_aess_hwmod,
+	.clk		= "abe_iclk",
+	.user		= OCP_USER_SDMA,
+};
+
 /* l4_abe -> dmic */
 static struct omap_hwmod_ocp_if omap54xx_l4_abe__dmic = {
 	.master		= &omap54xx_l4_abe_hwmod,
@@ -2417,6 +2478,9 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l3_main_1__l3_main_3,
 	&omap54xx_l3_main_2__l3_main_3,
 	&omap54xx_l4_cfg__l3_main_3,
+	&omap54xx_l4_abe__aess,
+	&omap54xx_l4_abe__aess_dma,
+	&omap54xx_aess__l4_abe,
 	&omap54xx_l3_main_1__l4_abe,
 	&omap54xx_mpu__l4_abe,
 	&omap54xx_l3_main_1__l4_cfg,
-- 
1.9.2

