From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Move omap2_check_revision and omap_sram_init out of
 map_io
Date: Mon, 14 Feb 2011 15:52:39 -0800
Message-ID: <20110214235238.GU20795@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
 <20110214234520.GT20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37024 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab1BNXwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 18:52:54 -0500
Content-Disposition: inline
In-Reply-To: <20110214234520.GT20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

With the early init changes we just want to map IO in map_io.
Both omap2_check_revision and omap_sram_init can be moved to
happen later in omap2_init_common_infrastructure.

Note that now we can now remove _omap2_map_common_io and remove
the extra flushes too as devicemaps_init will take care of it.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

This is on top of the other early init related patches:

omap: hwmod: Populate _mpu_rt_va later on in omap_hwmod_late_init
omap2+: Fix omap_serial_early_init to work with init_early hook
omap2+: Make omap_hwmod_late_init into core_initcall
ARM: OMAP2: use early init hook

--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -228,25 +228,11 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif
 
-static void __init _omap2_map_common_io(void)
-{
-	/* Normally devicemaps_init() would flush caches and tlb after
-	 * mdesc->map_io(), but we must also do it here because of the CPU
-	 * revision check below.
-	 */
-	local_flush_tlb_all();
-	flush_cache_all();
-
-	omap2_check_revision();
-	omap_sram_init();
-}
-
 #ifdef CONFIG_ARCH_OMAP2420
 void __init omap242x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -255,7 +241,6 @@ void __init omap243x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -263,7 +248,6 @@ void __init omap243x_map_common_io(void)
 void __init omap34xx_map_common_io(void)
 {
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -271,7 +255,6 @@ void __init omap34xx_map_common_io(void)
 void __init omap44xx_map_common_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -335,6 +318,9 @@ void __init omap2_init_common_infrastructure(void)
 {
 	u8 postsetup_state;
 
+	omap2_check_revision();
+	omap_sram_init();
+
 	if (cpu_is_omap242x()) {
 		omap2xxx_powerdomains_init();
 		omap2_clockdomains_init();
