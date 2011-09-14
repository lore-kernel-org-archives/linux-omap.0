From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] OMAP2+: id: remove OMAP_REVBITS_* macros
Date: Wed, 14 Sep 2011 07:10:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109140708590.27954@utopia.booyaka.com>
References: <20110913212638.26161.62284.stgit@dusk> <20110913212806.26161.37867.stgit@dusk> <4E709D13.1080908@compulab.co.il> <alpine.DEB.2.00.1109140628520.27954@utopia.booyaka.com> <4E70A337.6090400@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46210 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab1INNKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 09:10:36 -0400
In-Reply-To: <4E70A337.6090400@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, premi@ti.com, linux-arm-kernel@lists.infradead.org

Hi Igor,

On Wed, 14 Sep 2011, Igor Grinberg wrote:

> I've applied those manually on top of v3.1-rc3:
> 
> --------------cut--------------------
> [    0.000000] Linux version 3.1.0-rc3-00006-ga942f6de (grinberg@grinberg-linux) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #1 SMP Wed Sep 14 15:35:32 IDT 2011
> [    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=10c53c7f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> [    0.000000] Machine: Compulab CM-T3517
> [    0.000000] Reserving 8388608 bytes SDRAM for VRAM
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] OMAP3430/3530 ES1.0 (l2cache iva sgx neon isp )
> ----------cut----------------------------
>                ^^^^^^^^^^^^^^^^^^^
> 
> While U-Boot says:
> 
> ------------cut---------------------
> U-Boot 2009.11-cm-t3517-1 (Dec 10 2010 - 23:25:02)
> 
> AM35xx-GP ES1.0, L3-165MHz
> ------------cut---------------------
> 
> Do I miss something, that should be in your tree?
> Pulling it in right now, should be available shortly...

Could you try this patch on top of the ones that you are testing?

thanks for the testing help,


- Paul


>From c99fe1a11cbf81e1803686db3bb408aa97264b52 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 14 Sep 2011 07:04:31 -0600
Subject: [PATCH] test patch for Igor

---
 arch/arm/mach-omap2/clock3xxx_data.c |    8 ++++----
 arch/arm/mach-omap2/id.c             |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index b9b8446..078a40a 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3472,12 +3472,12 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = 0;
 
-	if (cpu_is_omap3517()) {
-		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3517;
-	} else if (cpu_is_omap3505()) {
+	if (cpu_is_omap3505()) {
 		cpu_mask = RATE_IN_34XX;
 		cpu_clkflg = CK_3505;
+	} else if (cpu_is_omap3517()) {
+		cpu_mask = RATE_IN_34XX;
+		cpu_clkflg = CK_3517;
 	} else if (cpu_is_omap3630()) {
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
 		cpu_clkflg = CK_36XX;
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 307e186..ed1d439 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -463,7 +463,7 @@ static void __init omap3_cpuinfo(const char *cpu_rev)
 	 */
 	if (cpu_is_omap3630()) {
 		cpu_name = "OMAP3630";
-	} else if (cpu_is_omap3505()) {
+	} else if (cpu_is_omap3517()) {
 		/* AM35xx devices */
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
-- 
1.7.5.4

