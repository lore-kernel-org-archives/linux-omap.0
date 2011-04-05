From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap: introduce OMAP MCOP board file
Date: Tue,  5 Apr 2011 12:32:50 +0300
Message-ID: <1301995970-23699-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40526 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563Ab1DEJcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 05:32:55 -0400
Received: by mail-ew0-f41.google.com with SMTP id 9so49541ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 02:32:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Michael Fillinger <m-fillinger@ti.com>, Felipe Balbi <balbi@ti.com>

From: Michael Fillinger <m-fillinger@ti.com>

MCOP is an FPGA-based Silicon Validation platform
which is used to test particular IPs inside OMAP
before we have a real ASIC.

Signed-off-by: Michael Fillinger <m-fillinger@ti.com>

[ balbi@ti.com : few cleanups here an there and also
	removal of some unnecessary code. ]

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Kconfig                  |    7 +++
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-mcop.c             |   60 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 4 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-mcop.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1a2cf62..6f5699f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -116,6 +116,13 @@ config MACH_OMAP_H4
 	select OMAP_PACKAGE_ZAF
 	select OMAP_DEBUG_DEVICES
 
+config MACH_OMAP_MCOP
+	bool "OMAP MCOP Board"
+	depends on ARCH_OMAP2420
+	default y
+#	select OMAP_PACKAGE_ZAF
+#	select OMAP_DEBUG_DEVICES
+
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
 	depends on ARCH_OMAP2420
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1c0c2b0..6db99c4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -153,6 +153,7 @@ endif
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
+obj-$(CONFIG_MACH_OMAP_MCOP)		+= board-mcop.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
diff --git a/arch/arm/mach-omap2/board-mcop.c b/arch/arm/mach-omap2/board-mcop.c
new file mode 100644
index 0000000..b9fe1a4
--- /dev/null
+++ b/arch/arm/mach-omap2/board-mcop.c
@@ -0,0 +1,60 @@
+/*
+ * board-mcop.c - OMAP pre-Silicon Validation Platform
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
+ * Author: Michael Fillinger <m-fillinger@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/common.h>
+#include <plat/irqs.h>
+
+#include <mach/hardware.h>
+
+static void __init omap_mcop_init_irq(void)
+{
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
+	omap_init_irq();
+}
+
+static void __init omap_mcop_init(void)
+{
+	omap_serial_init();
+}
+
+static void __init omap_mcop_map_io(void)
+{
+	omap2_set_globals_242x();
+	omap242x_map_common_io();
+}
+
+MACHINE_START(OMAP_MCOP, "OMAP MCOP Board")
+	/* Maintainer: Michael Fillinger <m-fillinger@ti.com> */
+
+	/*
+	 * REVISIT What values to put here so that it works
+	 * on all versions of MCOP
+	 *
+	 * .phys_io	= 0x48000000,
+	 * .io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
+	 */
+
+	.boot_params	= 0x80000100,
+	.map_io		= omap_mcop_map_io,
+	.reserve	= omap_reserve,
+	.init_irq	= omap_mcop_init_irq,
+	.init_machine	= omap_mcop_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index ad98b85..dbedd6e 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -129,6 +129,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP2(1, omap_2430sdp);
 		DEBUG_LL_OMAP2(1, omap_apollon);
 		DEBUG_LL_OMAP2(1, omap_h4);
+		DEBUG_LL_OMAP2(1, omapmcop);
 
 		/* omap2 based boards using UART3 */
 		DEBUG_LL_OMAP2(3, nokia_n800);
-- 
1.7.4.1.343.ga91df

