From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
Date: Wed, 2 May 2012 03:23:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
References: <hvaibhav@ti.com> <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53309 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab2EBJXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 05:23:25 -0400
In-Reply-To: <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Hi

On Fri, 2 Dec 2011, hvaibhav@ti.com wrote:

> From: Afzal Mohammed <afzal@ti.com>
> 
> This patch adds minimal support for AM335X EVM.
> The approach taken here is to add AM335X EVM support
> to AM3517EVM, considering the fact that with device tree
> developement we will get rid of board-*.c.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

I realize people may not necessarily like this, but I think that the 
AM33xx EVM needs its own board file.  This is because it really has 
nothing to do with the AM3517EVM.  Also, the AM3517EVM depends on 
CONFIG_ARCH_OMAP3, but the AM33xx EVM should not: it should depend on 
either CONFIG_ARCH_OMAPAM33XX, or CONFIG_ARCH_OMAP4.

So the following modification of this patch opts for the former Kconfig 
option, CONFIG_ARCH_OMAPAM33XX.  It also adds a new, minimal board file 
for the AM33xx EVM.  

If, on the other hand, people want to use CONFIG_ARCH_OMAP4 instead for 
the AM33xx, then we could potentially add the new machine record into 
board-omap4panda.c.  Although even then, if political considerations were 
set aside, the best technical decision would probably be to create a 
separate board file, since the boards don't have much in common.


- Paul

From: Afzal Mohammed <afzal@ti.com>
Date: Fri, 2 Dec 2011 12:13:23 +0530
Subject: [PATCH] ARM: OMAP: AM33xx: Add AM335XEVM machine support

This patch adds minimal support for AM335X EVM.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: created new board file for AM33xx; moved am33xx_init_early()
 outside of CONFIG_ARCH_OMAP3; modified commit message]
---
 arch/arm/mach-omap2/Kconfig           |    5 ++++
 arch/arm/mach-omap2/Makefile          |    1 +
 arch/arm/mach-omap2/board-am335xevm.c |   46 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/common.h          |    2 ++
 arch/arm/mach-omap2/io.c              |    8 ++++++
 arch/arm/mach-omap2/timer.c           |    2 ++
 6 files changed, 64 insertions(+)
 create mode 100644 arch/arm/mach-omap2/board-am335xevm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5ae756a..d5aa936 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -335,6 +335,11 @@ config MACH_TI8148EVM
 	depends on SOC_OMAPTI81XX
 	default y
 
+config MACH_AM335XEVM
+	bool "AM335X Evaluation Module"
+	depends on SOC_OMAPAM33XX
+	default y
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	default y
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c538b3e..d3c33df 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -241,6 +241,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
+obj-$(CONFIG_MACH_AM335XEVM)		+= board-am335xevm.o
 
 # Platform specific device init code
 
diff --git a/arch/arm/mach-omap2/board-am335xevm.c b/arch/arm/mach-omap2/board-am335xevm.c
new file mode 100644
index 0000000..324752e
--- /dev/null
+++ b/arch/arm/mach-omap2/board-am335xevm.c
@@ -0,0 +1,46 @@
+/*
+ * board-am335xevm.c - support the TI AM335x EVM board
+ *
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/board.h>
+#include "common.h"
+
+static struct omap_board_config_kernel am335x_evm_config[] __initdata = {
+};
+
+static void __init am335x_evm_init(void)
+{
+	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
+	omap_board_config = am335x_evm_config;
+	omap_board_config_size = ARRAY_SIZE(am335x_evm_config);
+}
+
+MACHINE_START(AM335XEVM, "am335xevm")
+	/* Maintainer: Texas Instruments */
+	.atag_offset	= 0x100,
+	.map_io		= am33xx_map_io,
+	.init_early	= am33xx_init_early,
+	.init_irq	= ti81xx_init_irq,
+	.timer		= &omap3_am33xx_timer,
+	.init_machine	= am335x_evm_init,
+MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 57da7f4..dae39a3 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -83,6 +83,7 @@ extern void omap2_init_common_infrastructure(void);
 extern struct sys_timer omap2_timer;
 extern struct sys_timer omap3_timer;
 extern struct sys_timer omap3_secure_timer;
+extern struct sys_timer omap3_am33xx_timer;
 extern struct sys_timer omap4_timer;
 
 void omap2420_init_early(void);
@@ -94,6 +95,7 @@ void omap3_init_early(void);	/* Do not use this one */
 void am35xx_init_early(void);
 void ti81xx_init_early(void);
 void omap4430_init_early(void);
+void am33xx_init_early(void);
 void omap_prcm_restart(char, const char *);
 
 /*
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 065bd76..056db56 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -466,6 +466,14 @@ void __init ti81xx_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap3xxx_clk_init();
 }
+#endif /* CONFIG_ARCH_OMAP3 */
+
+#ifdef CONFIG_SOC_OMAPAM33XX
+void __init am33xx_init_early(void)
+{
+	omap2_set_globals_am33xx();
+	omap_common_init_early();
+}
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c512bac..b2f747b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -321,6 +321,8 @@ OMAP_SYS_TIMER(3)
 OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
 			2, OMAP3_MPU_SOURCE)
 OMAP_SYS_TIMER(3_secure)
+OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER(3_am33xx)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-- 
1.7.10

