From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Wed, 25 May 2011 18:56:50 -0700
Message-ID: <1306375016-707-4-git-send-email-nm@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50361 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757276Ab1EZB5Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:57:16 -0400
Received: by gxk26 with SMTP id 26so142003gxk.18
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:57:15 -0700 (PDT)
In-Reply-To: <1306375016-707-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Moiz Sonasath <m-sonasath@ti.com>, Nishanth Menon <nm@ti.com>

From: Moiz Sonasath <m-sonasath@ti.com>

For OMAP4460, GPIO-7 of bank1 is used for controling
the TPS modes, hence GPIO1 should not be reset
during init as reset will cause the TPS voltage to
drop to 0.9 V.

Originally from:
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=52ae4f0de03b17c064d9ce90a580230f1a596ec1

[nm@ti.com: upstream version]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 2f51a5a..27319c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1745,7 +1745,7 @@ static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
 };
 
-static struct omap_hwmod omap44xx_gpio1_hwmod = {
+static struct omap_hwmod omap443x_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio1_irqs,
@@ -1761,7 +1761,27 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+static struct omap_hwmod omap446x_gpio1_hwmod = {
+	.name		= "gpio1",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.flags          = HWMOD_INIT_NO_RESET,
+	.mpu_irqs	= omap44xx_gpio1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
+	.main_clk	= "gpio1_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4460),
 };
 
 /* gpio2 */
@@ -5079,7 +5099,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_dss_venc_hwmod,
 
 	/* gpio class */
-	&omap44xx_gpio1_hwmod,
+	&omap443x_gpio1_hwmod,
+	&omap446x_gpio1_hwmod,
 	&omap44xx_gpio2_hwmod,
 	&omap44xx_gpio3_hwmod,
 	&omap44xx_gpio4_hwmod,
-- 
1.7.1

