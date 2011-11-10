From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V4 2/3] arm:omap:am33xx: Add AM335XEVM machine support
Date: Thu, 10 Nov 2011 23:10:36 +0530
Message-ID: <1320946837-32507-3-git-send-email-hvaibhav@ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59131 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab1KJRlb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 12:41:31 -0500
In-Reply-To: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch adds minimal support for AM335X EVM.
The approach taken here is to add AM335X EVM support
to AM3517EVM, considering the fact that with device tree
developement we will get rid of board-*.c.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Kconfig              |    5 +++++
 arch/arm/mach-omap2/Makefile             |    1 +
 arch/arm/mach-omap2/board-am3517evm.c    |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/io.c                 |    7 +++++++
 arch/arm/mach-omap2/timer.c              |    2 ++
 arch/arm/plat-omap/include/plat/common.h |    2 ++
 6 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index c3d530b..2ef39c2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -326,6 +326,11 @@ config MACH_TI8168EVM
 	depends on SOC_OMAPTI816X
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
index 14cd2fd..b33a85f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -233,6 +233,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o

 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
+obj-$(CONFIG_MACH_AM335XEVM)		+= board-am3517evm.o

 # Platform specific device init code

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index f7df8d3..090457f 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -516,3 +516,24 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.init_machine	= am3517_evm_init,
 	.timer		= &omap3_timer,
 MACHINE_END
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
+	.init_irq	= ti816x_init_irq,
+	.timer		= &omap3_am33xx_timer,
+	.init_machine	= am335x_evm_init,
+MACHINE_END
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 74e84c6..6f03cc1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -477,6 +477,13 @@ void __init omap4430_init_early(void)
 }
 #endif

+void __init am33xx_init_early(void)
+{
+	omap2_set_globals_am33xx();
+	omap_common_init_early();
+	omap3xxx_clk_init();
+}
+
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 037b0d7..7b29197 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -333,6 +333,8 @@ OMAP_SYS_TIMER(3)
 OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
 			2, OMAP3_MPU_SOURCE)
 OMAP_SYS_TIMER(3_secure)
+OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER(3_am33xx)
 #endif

 #ifdef CONFIG_ARCH_OMAP4
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index b83818d..87bd3e2 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -38,6 +38,7 @@ extern struct sys_timer omap1_timer;
 extern struct sys_timer omap2_timer;
 extern struct sys_timer omap3_timer;
 extern struct sys_timer omap3_secure_timer;
+extern struct sys_timer omap3_am33xx_timer;
 extern struct sys_timer omap4_timer;
 extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
@@ -54,6 +55,7 @@ void omap3_init_early(void);	/* Do not use this one */
 void am35xx_init_early(void);
 void ti816x_init_early(void);
 void omap4430_init_early(void);
+void am33xx_init_early(void);

 void omap_sram_init(void);

--
1.7.0.4

