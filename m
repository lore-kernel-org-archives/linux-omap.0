From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: Fix multi-omap boot with reset un-used clocks
Date: Wed, 19 May 2010 17:29:05 +0530
Message-ID: <1274270345-28769-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56074 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab0ESL7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 07:59:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

As part of the "CONFIG_OMAP_RESET_CLOCKS" routine, all the clock
are cut which are not acquired/enabled during the boot.

Because of this on OMAP4, memory controller clocks (emif) getting
disabled which prevents further boot

This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
and adds a check in the reset un-used clock routine to skip
such clock nodes. Will updated the auto-gen script for 44xx
accordingly

The real fix is to have driver for EMIF and do clock get/enable
part of it. The EMIF driver is planned to be done HWMOD way so
till that point to keep omap3_defconfig booting on OMAP4430,
this patch is necessary. Also the cpu_is_44xx() check is added 
to avoid any impact on the other OMAPs using "ENABLE_ON_INIT" flag

The flag usage was suggested by Paul Walmsley

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
With this patch and Tony's below sram fix, omap3_defconfig
boots on OMAP4430 as it is. Tested with 2.6.34 maniline kernel
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27363.html

 arch/arm/mach-omap2/clock.c          |    4 ++++
 arch/arm/mach-omap2/clock44xx_data.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index a6d0b34..67b531b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -380,6 +380,10 @@ void omap2_clk_disable_unused(struct clk *clk)
 {
 	u32 regval32, v;
 
+	/* FIXME: Remove this when EMIF driver is ready */
+	if (cpu_is_omap44xx() && (clk->flags & ENABLE_ON_INIT))
+		return;
+
 	v = (clk->flags & INVERT_ENABLE) ? (1 << clk->enable_bit) : 0;
 
 	regval32 = __raw_readl(clk->enable_reg);
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index a5c0c9c..a1b4cae 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1369,6 +1369,7 @@ static struct clk emif1_ick = {
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "l3_emif_clkdm",
 	.parent		= &ddrphy_ck,
 	.recalc		= &followparent_recalc,
@@ -1379,6 +1380,7 @@ static struct clk emif2_ick = {
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "l3_emif_clkdm",
 	.parent		= &ddrphy_ck,
 	.recalc		= &followparent_recalc,
-- 
1.6.0.4

