From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/5] OMAP1 clock: convert armwdt_ck to use the fixed divisor
	recalc function
Date: Mon, 11 Jan 2010 17:46:29 -0700
Message-ID: <20100112004628.24684.49978.stgit@localhost.localdomain>
References: <20100112004326.24684.91321.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55147 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab0ALArb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:47:31 -0500
In-Reply-To: <20100112004326.24684.91321.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The armwdt_ck clock uses a fixed divisor, so it can use the OMAP clock
fixed divisor recalculation code, rather than a custom function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c      |    6 ------
 arch/arm/mach-omap1/clock_data.c |    3 ++-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 2ba9ab9..5b735b2 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -52,12 +52,6 @@ const struct clkops clkops_dummy = {
 	.disable	= clk_omap1_dummy_disable,
 };
 
-/* XXX can be replaced with a fixed_divisor_recalc */
-unsigned long omap1_watchdog_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 14;
-}
-
 unsigned long omap1_uart_recalc(struct clk *clk)
 {
 	unsigned int val = __raw_readl(clk->enable_reg);
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 65e7b5b..edefb34 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -149,7 +149,8 @@ static struct arm_idlect1_clk armwdt_ck = {
 		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_WDTCK,
-		.recalc		= &omap1_watchdog_recalc,
+		.fixed_div	= 14,
+		.recalc		= &omap_fixed_divisor_recalc,
 	},
 	.idlect_shift	= 0,
 };


