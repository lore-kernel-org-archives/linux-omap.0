From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Wed, 19 May 2010 22:08:07 +0530
Message-ID: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54752 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab0ESQiP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 12:38:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
to avoid the emif clk getting cut as part of reset un-used clock
routine which prevents boot.

Since omap4 "omap2_clk_init()" calls "clk_enable_init_clocks()"
which increases the usecount on all ENABLE_ON_INIT clocks, it
prevents "omap2_clk_disable_unused()" from disabling the clock.

The real fix is to have driver for EMIF and do clock get/enable
as part of it. The EMIF driver is planned to be done HWMOD way
so till that available to keep omap3_defconfig booting on OMAP4430,
this patch is necessary.
(Will updated the auto-gen script for 44xx accordingly)

The fix was suggested by Paul Walmsley

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
With this patch and Tony's below sram fix, omap3_defconfig
boots on OMAP4430 as it is. Boot tested with 2.6.34 maniline kernel
on OMAP4430, OMAP3430 with omap3_defconfig and regular defconfig

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27363.html

 arch/arm/mach-omap2/clock44xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

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

