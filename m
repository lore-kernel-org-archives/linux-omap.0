From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 4/8] ARM: OMAP5: hwmod data: Add mailbox data
Date: Tue, 6 Aug 2013 16:40:28 -0500
Message-ID: <1375825228-18191-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43728 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab3HFVrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 17:47:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

Add the hwmod data for the mailbox IP in OMAP5 SoC.
This is needed to be able to enable the OMAP mailbox
support for OMAP5.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index f37ae96..e4f85da 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -741,6 +741,39 @@ static struct omap_hwmod omap54xx_kbd_hwmod = {
 };
 
 /*
+ * 'mailbox' class
+ * mailbox module allowing communication between the on-chip processors using a
+ * queued mailbox-interrupt mechanism.
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_mailbox_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap54xx_mailbox_hwmod_class = {
+	.name	= "mailbox",
+	.sysc	= &omap54xx_mailbox_sysc,
+};
+
+/* mailbox */
+static struct omap_hwmod omap54xx_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap54xx_mailbox_hwmod_class,
+	.clkdm_name	= "l4cfg_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_L4CFG_MAILBOX_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'mcbsp' class
  * multi channel buffered serial port controller
  */
@@ -1807,6 +1840,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_wkup__kbd = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_cfg -> mailbox */
+static struct omap_hwmod_ocp_if omap54xx_l4_cfg__mailbox = {
+	.master		= &omap54xx_l4_cfg_hwmod,
+	.slave		= &omap54xx_mailbox_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_abe -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap54xx_l4_abe__mcbsp1 = {
 	.master		= &omap54xx_l4_abe_hwmod,
@@ -2107,6 +2148,7 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_per__i2c4,
 	&omap54xx_l4_per__i2c5,
 	&omap54xx_l4_wkup__kbd,
+	&omap54xx_l4_cfg__mailbox,
 	&omap54xx_l4_abe__mcbsp1,
 	&omap54xx_l4_abe__mcbsp2,
 	&omap54xx_l4_abe__mcbsp3,
-- 
1.8.3.3

