From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH A 03/10] OMAP24xx clock: add missing SSI L4 interface clock
Date: Tue, 27 Jan 2009 19:12:54 -0700
Message-ID: <20090128021250.7244.77061.stgit@localhost.localdomain>
References: <20090128020447.7244.80496.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60071 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZA1UWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:22:46 -0500
In-Reply-To: <20090128020447.7244.80496.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

This patch adds a missing OMAP24xx clock, the SSI L4 interface clock,
as "ssi_l4_ick".

linux-omap source commit is ace129d39b3107d330d4cf6934385d13521f2fec.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index ad6d98d..f8bed57 100644
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
@@ -2685,6 +2699,7 @@ static struct clk *onchip_24xx_clks[] __initdata = {
 	&usb_l4_ick,
 	/* L4 domain clocks */
 	&l4_ck,			/* used as both core_l4 and wu_l4 */
+	&ssi_l4_ick,
 	/* virtual meta-group clock */
 	&virt_prcm_set,
 	/* general l4 interface ck, multi-parent functional clk */


