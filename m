From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: [PATCH 3/4] ADDING OMAP3 BEAGLE support
Date: Sat, 19 Apr 2008 08:39:04 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0018C8F14@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:34421 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917AbYDSDNP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 23:13:15 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: discussion@beagleboard.org


Adding support for OMAP3 Beagle Board

Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
---
 arch/arm/mach-omap2/Kconfig                   |    4 +
 arch/arm/mach-omap2/Makefile                  |    1
 arch/arm/mach-omap2/board-omap3beagle.c       |   79 ++++++++++++++++++++++++++
 include/asm-arm/arch-omap/board-omap3beagle.h |   53 +++++++++++++++++
 include/asm-arm/arch-omap/hardware.h          |    4 +
 5 files changed, 141 insertions(+)

Index: my_branch/arch/arm/mach-omap2/Kconfig
===================================================================
--- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-19 07:50:28.000000000 +0530
+++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-19 07:50:28.000000000 +0530
@@ -109,3 +109,7 @@
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+config MACH_OMAP3_BEAGLE
+	bool "OMAP3 BEAGLE board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX

Index: my_branch/arch/arm/mach-omap2/Makefile
===================================================================
--- my_branch.orig/arch/arm/mach-omap2/Makefile	2008-04-19 07:50:28.000000000 +0530
+++ my_branch/arch/arm/mach-omap2/Makefile	2008-04-19 07:50:28.000000000 +0530
@@ -35,6 +35,7 @@
 					   board-3430sdp-usb.o \
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
+obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o

Index: my_branch/arch/arm/mach-omap2/board-omap3beagle.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ my_branch/arch/arm/mach-omap2/board-omap3beagle.c	2008-04-19 07:52:27.000000000 +0530
@@ -0,0 +1,79 @@
+/*
+ * linux/arch/arm/mach-omap2/board-omap3beagle.c
+ *
+ * Copyright (C) 2008 Texas Instruments
+ *
+ * Modified from mach-omap2/board-3430sdp.c
+ *
+ * Initial code: Syed Mohammed Khasim
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/board.h>
+#include <asm/arch/common.h>
+
+static struct omap_uart_config omap3_beagle_uart_config __initdata = {
+	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static int __init omap3_beagle_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}
+
+static void __init omap3_beagle_init_irq(void)
+{
+	omap2_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
+	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
+};
+
+static void __init omap3_beagle_init(void)
+{
+	omap_board_config = omap3_beagle_config;
+	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
+	omap_serial_init();
+}
+
+arch_initcall(omap3_beagle_i2c_init);
+
+static void __init omap3_beagle_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
+	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap3_beagle_map_io,
+	.init_irq	= omap3_beagle_init_irq,
+	.init_machine	= omap3_beagle_init,
+	.timer		= &omap_timer,
+MACHINE_END

Index: my_branch/include/asm-arm/arch-omap/board-omap3beagle.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ my_branch/include/asm-arm/arch-omap/board-omap3beagle.h	2008-04-19 07:53:04.000000000 +0530
@@ -0,0 +1,53 @@
+/*
+ * linux/include/asm-arm/arch-omap/board-omap3beagle.h
+ *
+ * Hardware definitions for TI OMAP3 BEAGLE.
+ *
+ * Initial creation by Syed Mohammed Khasim <khasim@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OMAP3_BEAGLE_H
+#define __ASM_ARCH_OMAP3_BEAGLE_H
+
+#ifdef CONFIG_TWL4030_CORE
+
+#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
+
+/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
+#define	IH_TWL4030_BASE		IH_BOARD_BASE
+#define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
+#define IH_TWL4030_PWRBASE	(IH_TWL4030_END)
+#define IH_TWL4030_PWRBASE_END	(IH_TWL4030_PWRBASE+8)
+
+#ifdef CONFIG_TWL4030_GPIO
+/* TWL4030 GPIO Interrupts */
+#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
+#define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
+#define NR_IRQS			(IH_TWL4030_GPIO_END)
+#else
+#define NR_IRQS			(IH_TWL4030_PWRBASE_END)
+#endif /* CONFIG_I2C_TWL4030_GPIO */
+
+#endif /* End of support for TWL4030 */
+#endif /* __ASM_ARCH_OMAP3_BEAGLE_H */
+

Index: my_branch/include/asm-arm/arch-omap/hardware.h
===================================================================
--- my_branch.orig/include/asm-arm/arch-omap/hardware.h	2008-04-19 07:50:28.000000000 +0530
+++ my_branch/include/asm-arm/arch-omap/hardware.h	2008-04-19 07:50:28.000000000 +0530
@@ -339,6 +339,10 @@
 #include "board-omap3evm.h"
 #endif
 
+#ifdef CONFIG_MACH_OMAP3_BEAGLE
+#include "board-omap3beagle.h"
+#endif
+
 #ifdef CONFIG_MACH_OMAP_APOLLON
 #include "board-apollon.h"
 #endif
