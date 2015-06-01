From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv4 04/10] ARM: DRA7: hwmod: add DMM hwmod description
Date: Mon, 1 Jun 2015 09:23:12 +0300
Message-ID: <1433139798-23450-5-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758771AbbFAGYC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:24:02 -0400
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DMM hwmod entries for DRA7. This is identical to DMM on OMAP5.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 817dbd87ce67..f6b94854fafc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -49,6 +49,27 @@
  */
 
 /*
+ * 'dmm' class
+ * instance(s): dmm
+ */
+static struct omap_hwmod_class dra7xx_dmm_hwmod_class = {
+	.name	= "dmm",
+};
+
+/* dmm */
+static struct omap_hwmod dra7xx_dmm_hwmod = {
+	.name		= "dmm",
+	.class		= &dra7xx_dmm_hwmod_class,
+	.clkdm_name	= "emif_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_EMIF_DMM_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_EMIF_DMM_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'l3' class
  * instance(s): l3_instr, l3_main_1, l3_main_2
  */
@@ -2322,6 +2343,14 @@ static struct omap_hwmod dra7xx_wd_timer2_hwmod = {
  * Interfaces
  */
 
+/* l3_main_1 -> dmm */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__dmm = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_dmm_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> l3_instr */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_2__l3_instr = {
 	.master		= &dra7xx_l3_main_2_hwmod,
@@ -3290,6 +3319,7 @@ static struct omap_hwmod_ocp_if dra7xx_l4_wkup__wd_timer2 = {
 };
 
 static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
+	&dra7xx_l3_main_1__dmm,
 	&dra7xx_l3_main_2__l3_instr,
 	&dra7xx_l4_cfg__l3_main_1,
 	&dra7xx_mpu__l3_main_1,
-- 
2.1.4

