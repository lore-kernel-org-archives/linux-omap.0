From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 08/12] ARM: OMAP4: hwmod data: add SL2IF hardreset line
Date: Sun, 10 Jun 2012 18:46:17 -0600
Message-ID: <20120611004614.20034.50895.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2FKAwL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:11 -0400
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>

On boot, the sl2if module can't be enabled.  The following message is
logged:

omap_hwmod: sl2if: cannot be enabled for reset (3)

This is probably because the SL2IF is still being held in hardreset.
The SL2IF's hardreset line is shared with one of the IVAHD's hardreset
lines; see for example Table 3-536 "RM_IVAHD_RSTCTRL" in the OMAP4430
TRM Rev. AA (SWPU231AA).  To work around this, add the SL2IF's
hardreset line to the hwmod data.  This is correct from a hardware
perspective and also will prevent the hwmod from attempting to enable
the SL2IF during reset.  The driver for this IP block will need to
handle its integration until the appropriate way to handle the IVAHD
integration can be elucidated.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7700d6d..037424f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2597,15 +2597,22 @@ static struct omap_hwmod_class omap44xx_sl2if_hwmod_class = {
 	.name	= "sl2if",
 };
 
+static struct omap_hwmod_rst_info omap44xx_sl2if_resets[] = {
+	{ .name = "logic", .rst_shift = 2 },
+};
+
 /* sl2if */
 static struct omap_hwmod omap44xx_sl2if_hwmod = {
 	.name		= "sl2if",
 	.class		= &omap44xx_sl2if_hwmod_class,
 	.clkdm_name	= "ivahd_clkdm",
+	.rst_lines	= omap44xx_sl2if_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_sl2if_resets),
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_IVAHD_SL2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_IVAHD_SL2_CONTEXT_OFFSET,
+			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},


