From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] omap4: Fix multi-omap boot with reset un-used
 clocks
Date: Wed, 19 May 2010 17:10:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005191708320.27473@utopia.booyaka.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50021 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0ESXKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 19:10:36 -0400
In-Reply-To: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, 19 May 2010, Santosh Shilimkar wrote:

> This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
> to avoid the emif clk getting cut as part of reset un-used clock
> routine which prevents boot.
> 
> Since omap4 "omap2_clk_init()" calls "clk_enable_init_clocks()"
> which increases the usecount on all ENABLE_ON_INIT clocks, it
> prevents "omap2_clk_disable_unused()" from disabling the clock.
> 
> The real fix is to have driver for EMIF and do clock get/enable
> as part of it. The EMIF driver is planned to be done HWMOD way
> so till that available to keep omap3_defconfig booting on OMAP4430,
> this patch is necessary.
> (Will updated the auto-gen script for 44xx accordingly)
> 
> The fix was suggested by Paul Walmsley
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, I've added Nishanth's Tested-by: and fixed the patch changelog; 
the following patch is now queued for 2.6.35-rc, unless there are any 
further comments.


- Paul

>From 3f3de7c0419784153564c63b4a2d3c3c95808e3e Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 19 May 2010 22:08:07 +0530
Subject: [PATCH] OMAP4: clock: Fix multi-omap boot with reset un-used clocks

This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
to avoid the emif clk getting cut as part of reset un-used clock
routine which prevents boot.

Since "omap4xxx_clk_init()" calls "clk_enable_init_clocks()"
which increases the usecount on all ENABLE_ON_INIT clocks, it
prevents "omap2_clk_disable_unused()" from disabling the clock.

The real fix is to have driver for EMIF and do clock get/enable
as part of it. The EMIF driver is planned to be done HWMOD way
so till that available to keep omap3_defconfig booting on OMAP4430,
this patch is necessary.
(Will updated the auto-gen script for 44xx accordingly)

The fix was suggested by Paul Walmsley

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
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
1.7.1.rc2

