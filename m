From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 10/9] OMAP4: HWMOD: differentiate 4430 and 4460 bandgap
Date: Wed, 25 May 2011 20:41:25 -0700
Message-ID: <1306381285-17764-1-git-send-email-nm@ti.com>
References: <[RFC][PATCH 0/9] OMAP4: Add 4460 base support>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:53222 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751948Ab1EZDlc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 23:41:32 -0400
Received: by gwj20 with SMTP id 20so165529gwj.26
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 20:41:30 -0700 (PDT)
In-Reply-To: <[RFC][PATCH 0/9] OMAP4: Add 4460 base support>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

OMAP4430 and 4460 have slightly different functional clocks.
we need to map this back into hwmod database as well to ensure
sanity.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Depends on the series posted earlier for http://marc.info/?l=linux-omap&m=130637503008641&w=2
missed tracking this down after a last min update :(
Boot tested on both SDP4430 and SDP4460

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   30 ++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 27319c4..9ac9cac 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -762,11 +762,11 @@ static struct omap_hwmod_class omap44xx_bandgap_hwmod_class = {
 };
 
 /* bandgap */
-static struct omap_hwmod_opt_clk bandgap_opt_clks[] = {
+static struct omap_hwmod_opt_clk bandgap443x_opt_clks[] = {
 	{ .role = "fclk", .clk = "bandgap_fclk" },
 };
 
-static struct omap_hwmod omap44xx_bandgap_hwmod = {
+static struct omap_hwmod omap443x_bandgap_hwmod = {
 	.name		= "bandgap",
 	.class		= &omap44xx_bandgap_hwmod_class,
 	.prcm		= {
@@ -774,9 +774,26 @@ static struct omap_hwmod omap44xx_bandgap_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
 		},
 	},
-	.opt_clks	= bandgap_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(bandgap_opt_clks),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
+	.opt_clks	= bandgap443x_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(bandgap443x_opt_clks),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+static struct omap_hwmod_opt_clk bandgap446x_opt_clks[] = {
+	{ .role = "fclk", .clk = "bandgap_ts_fclk" },
+};
+
+static struct omap_hwmod omap446x_bandgap_hwmod = {
+	.name		= "bandgap",
+	.class		= &omap44xx_bandgap_hwmod_class,
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+		},
+	},
+	.opt_clks	= bandgap446x_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(bandgap446x_opt_clks),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4460),
 };
 
 /*
@@ -5074,7 +5091,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 /*	&omap44xx_aess_hwmod, */
 
 	/* bandgap class */
-	&omap44xx_bandgap_hwmod,
+	&omap443x_bandgap_hwmod,
+	&omap446x_bandgap_hwmod,
 
 	/* counter class */
 /*	&omap44xx_counter_32k_hwmod, */
-- 
1.7.1

