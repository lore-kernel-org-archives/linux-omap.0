From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/9] ARM: DRA7: hwmod: add DMM hwmod description
Date: Fri, 13 Feb 2015 17:11:19 +0200
Message-ID: <1423840286-18377-3-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51204 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbbBMPM3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 10:12:29 -0500
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DMM hwmod entries for DRA7. This is identical to DMM on OMAP5.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index ffd6604cd546..47664bab5b57 100644
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
@@ -2312,6 +2333,14 @@ static struct omap_hwmod dra7xx_wd_timer2_hwmod = {
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
@@ -3264,6 +3293,7 @@ static struct omap_hwmod_ocp_if dra7xx_l4_wkup__wd_timer2 = {
 };
 
 static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
+	&dra7xx_l3_main_1__dmm,
 	&dra7xx_l3_main_2__l3_instr,
 	&dra7xx_l4_cfg__l3_main_1,
 	&dra7xx_mpu__l3_main_1,
-- 
2.3.0

