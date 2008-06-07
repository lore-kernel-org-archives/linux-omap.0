From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/16] ARM: OMAP2: Add missing SSI L4 interface clock
Date: Fri,  6 Jun 2008 19:12:32 -0700
Message-ID: <1212804762-18413-5-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
 <1212804762-18413-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49332 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbYFGCMx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:12:53 -0400
In-Reply-To: <1212804762-18413-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

This patch adds a missing OMAP24xx clock, the SSI L4 interface clock,
as "ssi_l4_ick".

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 242a19d..00ca071 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1290,6 +1290,20 @@ static struct clk ssi_ssr_sst_fck = {
 	.set_rate	= &omap2_clksel_set_rate
 };
 
+/*
+ * Presumably this is the same as SSI_ICLK.
+ * TRM contradicts itself on what clockdomain SSI_ICLK is in
+ */
+static struct clk ssi_l4_ick = {
+	.name		= "ssi_l4_ick",
+	.parent		= &l4_ck,
+	.clkdm_name	= "core_l4_clkdm",
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
 
 /*
  * GFX clock domain
@@ -2688,6 +2702,7 @@ static struct clk *onchip_24xx_clks[] __initdata = {
 	&usb_l4_ick,
 	/* L4 domain clocks */
 	&l4_ck,			/* used as both core_l4 and wu_l4 */
+	&ssi_l4_ick,
 	/* virtual meta-group clock */
 	&virt_prcm_set,
 	/* general l4 interface ck, multi-parent functional clk */
