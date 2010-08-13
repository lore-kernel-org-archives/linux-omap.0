From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] omap: Fix sev instruction usage for multi-omap
Date: Fri, 13 Aug 2010 11:02:06 +0300
Message-ID: <20100813080206.18750.89549.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64325 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab0HMICJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 04:02:09 -0400
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we get the following error with omap3_defconfig and CONFIG_SMP:

Error: selected processor does not support `sev'

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile          |    1 +
 arch/arm/mach-omap2/omap-smp.c        |    3 +--
 arch/arm/plat-omap/include/plat/smp.h |    7 -------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 63b2d88..88d3a1e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
 
+AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a
 AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a
 
 # Functions loaded to SRAM
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index af3c20c..9e9f70e 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -102,8 +102,7 @@ static void __init wakeup_secondary(void)
 	 * Send a 'sev' to wake the secondary core from WFE.
 	 * Drain the outstanding writes to memory
 	 */
-	dsb();
-	set_event();
+	dsb_sev();
 	mb();
 }
 
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index 6a3ff65..5177a9c 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -19,13 +19,6 @@
 
 #include <asm/hardware/gic.h>
 
-/*
- * set_event() is used to wake up secondary core from wfe using sev. ROM
- * code puts the second core into wfe(standby).
- *
- */
-#define set_event()	__asm__ __volatile__ ("sev" : : : "memory")
-
 /* Needed for secondary core boot */
 extern void omap_secondary_startup(void);
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);

