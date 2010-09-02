From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-omap
Date: Thu, 2 Sep 2010 09:23:37 -0700
Message-ID: <20100902162337.GP11597@atomide.com>
References: <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54644 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0IBQXt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 12:23:49 -0400
Content-Disposition: inline
In-Reply-To: <20100902161659.GJ11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

>From c04a57fc3b41d886f56ccdc27cf9758de0c95202 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 17 Aug 2010 13:33:23 +0300
Subject: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-omap

Fix SMP on UP interrupt handling for multi-omap

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-smp.c |   13 +++++++++----
 arch/arm/mach-omap2/timer-gp.c |    7 +++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 9e9f70e..a8bb49c 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -22,6 +22,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/localtimer.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -114,11 +115,15 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores;
 
-	/* Never released */
-	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
-	BUG_ON(!scu_base);
+	if (smp_on_up()) {
+		ncores = 1;
+	} else {
+		/* Never released */
+		scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
+		BUG_ON(!scu_base);
 
-	ncores = get_core_count();
+		ncores = get_core_count();
+	}
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..badf5f2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -37,6 +37,7 @@
 #include <linux/clockchips.h>
 
 #include <asm/mach/time.h>
+#include <asm/smp_plat.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
 
@@ -228,8 +229,10 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
-	BUG_ON(!twd_base);
+	if (smp_on_up()) {
+		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
+		BUG_ON(!twd_base);
+	}
 #endif
 	omap_dm_timer_init();
 
-- 
1.7.1

