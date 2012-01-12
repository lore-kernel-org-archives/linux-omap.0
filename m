From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
Date: Thu, 12 Jan 2012 10:42:57 -0800
Message-ID: <20120112184256.GA2287@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59518 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab2ALSnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 13:43:01 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
(Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
into devel-stable) merged generic ioremap changes.

Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
(ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
added a workaround for omap4.

In order for the errata to work, we now need the following
patch or else we'll get:

kernel BUG at mm/vmalloc.c:1134!

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -132,6 +132,7 @@ void omap3_map_io(void);
 void am33xx_map_io(void);
 void omap4_map_io(void);
 void ti81xx_map_io(void);
+int omap_barriers_init(void);
 
 /**
  * omap_test_timeout - busy-loop, testing a condition
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -306,7 +306,12 @@ void __init omapam33xx_map_common_io(void)
 #ifdef CONFIG_ARCH_OMAP4
 void __init omap44xx_map_common_io(void)
 {
+	int res;
+
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
+	res = omap_barriers_init();
+	if (res)
+		pr_err("Barriers broken\n");
 }
 #endif
 
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -51,7 +51,7 @@ void omap_bus_sync(void)
 	}
 }
 
-static int __init omap_barriers_init(void)
+int __init omap_barriers_init(void)
 {
 	struct map_desc dram_io_desc[1];
 	phys_addr_t paddr;
@@ -81,7 +81,11 @@ static int __init omap_barriers_init(void)
 
 	return 0;
 }
-core_initcall(omap_barriers_init);
+#else
+int __init omap_barriers_init(void)
+{
+	return 0;
+}
 #endif
 
 void __init gic_init_irq(void)
