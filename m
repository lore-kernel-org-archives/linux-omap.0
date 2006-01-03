From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: Pending patches mostly pushed, please check
Date: Tue, 3 Jan 2006 21:41:35 +0100
Message-ID: <20060103204135.GA11610@orphique>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
	<20060103191356.GR6034@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060103191356.GR6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 03, 2006 at 11:13:56AM -0800, Tony Lindgren wrote:
> Hi all,
> 
> I've pushed bunch of patches listed. Please check the status of
> your patches below.
> 
> Also reply to this thread if you know if a patch that you think
> should be pushed and has not been pushed yet. 

Umm, here is one more :-)

Remove support for board Netstar. I hope it helped to sort out various
needs to drivers and now when nearly everything [1] was converted to
platform device there is no more need to bother you with updates to
board file :-). I'll maintain it as separate patch (using PTXdist).
Thanks for all the fish :-)

Best regards,
	ladis

[1] Oh, it seems USB host driver still contains those
    machine_is_omap_xxx. Will fix that later...

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index a8d2d9a..f17b4ac 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -69,12 +69,6 @@ config MACH_VOICEBLUE
 	  Support for Voiceblue GSM/VoIP gateway. Say Y here if you have
 	  such a board.
 
-config MACH_NETSTAR
-	bool "NetStar"
-	depends on ARCH_OMAP1 && ARCH_OMAP15XX
-	help
-	  Support for NetStar PBX. Say Y here if you have such a board.
-
 config MACH_OMAP_PALMTE
 	bool "Palm Tungsten E"
 	depends on ARCH_OMAP1 && ARCH_OMAP15XX
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 856fedf..fe6598d 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= boar
 obj-$(CONFIG_MACH_OMAP_OSK)		+= board-osk.o
 obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
-obj-$(CONFIG_MACH_NETSTAR)		+= board-netstar.o
 obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board-palmte.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index cc31113..f4c4e8e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -50,10 +50,10 @@ config MTD_NAND_SPIA
 	  If you had to ask, you don't have one. Say 'N'.
 
 config MTD_NAND_OMAP
-        tristate "NAND Flash device on OMAP H3/H2/P2 or NETSTAR boards"
-	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_NETSTAR || MACH_OMAP_PERSEUS2)
-        help
-          Support for NAND flash on Texas Instruments H3/H2/P2/NETSTAR platforms.
+	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
+	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)
+	help
+	  Support for NAND flash on Texas Instruments H3/H2/P2 platforms.
 
 config MTD_NAND_TOTO
 	tristate "NAND Flash device on TOTO board"
diff --git a/include/asm-arm/arch-omap/hardware.h b/include/asm-arm/arch-omap/hardware.h
index 5406b87..ecf5bae 100644
--- a/include/asm-arm/arch-omap/hardware.h
+++ b/include/asm-arm/arch-omap/hardware.h
@@ -314,10 +314,6 @@
 #include "board-voiceblue.h"
 #endif
 
-#ifdef CONFIG_MACH_NETSTAR
-#include "board-netstar.h"
-#endif
-
 #endif /* !__ASSEMBLER__ */
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
--- a/include/asm-arm/arch-omap/board-netstar.h	2006-01-03 21:23:00.000000000 +0100
+++ b/include/asm-arm/arch-omap/board-netstar.h	2006-01-03 15:00:45.568894352 +0100
@@ -1,19 +0,0 @@
-/*
- * Copyright (C) 2004 2N Telekomunikace, Ladislav Michl <michl@2n.cz>
- *
- * Hardware definitions for OMAP5910 based NetStar board.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_NETSTAR_H
-#define __ASM_ARCH_NETSTAR_H
-
-#include <asm/arch/tc.h>
-
-#define OMAP_NAND_FLASH_START1		OMAP_CS1_PHYS + (1 << 23)
-#define OMAP_NAND_FLASH_START2		OMAP_CS1_PHYS + (2 << 23)
-
-#endif /*  __ASM_ARCH_NETSTAR_H */
--- a/arch/arm/mach-omap1/board-netstar.c	2006-01-03 21:22:43.000000000 +0100
+++ b/arch/arm/mach-omap1/board-netstar.c	2006-01-03 15:00:45.568894352 +0100
@@ -1,160 +0,0 @@
-/*
- * Modified from board-generic.c
- *
- * Copyright (C) 2004 2N Telekomunikace, Ladislav Michl <michl@2n.cz>
- *
- * Code for Netstar OMAP board.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <asm/arch/gpio.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/usb.h>
-#include <asm/arch/common.h>
-
-extern void __init omap_init_time(void);
-extern int omap_gpio_init(void);
-
-static struct resource netstar_smc91x_resources[] = {
-	[0] = {
-		.start	= OMAP_CS1_PHYS + 0x300,
-		.end	= OMAP_CS1_PHYS + 0x300 + 16,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= OMAP_GPIO_IRQ(8),
-		.end	= OMAP_GPIO_IRQ(8),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device netstar_smc91x_device = {
-	.name		= "smc91x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(netstar_smc91x_resources),
-	.resource	= netstar_smc91x_resources,
-};
-
-static struct platform_device *netstar_devices[] __initdata = {
-	&netstar_smc91x_device,
-};
-
-static struct omap_uart_config netstar_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
-static struct omap_board_config_kernel netstar_config[] = {
-	{ OMAP_TAG_UART,	&netstar_uart_config },
-};
-
-static void __init netstar_init_irq(void)
-{
-	omap_init_irq();
-	omap_gpio_init();
-}
-
-static void __init netstar_init(void)
-{
-	/* green LED */
-	omap_request_gpio(4);
-	omap_set_gpio_direction(4, 0);
-	/* smc91x reset */
-	omap_request_gpio(7);
-	omap_set_gpio_direction(7, 0);
-	omap_set_gpio_dataout(7, 1);
-	udelay(2);	/* wait at least 100ns */
-	omap_set_gpio_dataout(7, 0);
-	mdelay(50);	/* 50ms until PHY ready */
-	/* smc91x interrupt pin */
-	omap_request_gpio(8);
-
-	omap_request_gpio(12);
-	omap_request_gpio(13);
-	omap_request_gpio(14);
-	omap_request_gpio(15);
-	set_irq_type(OMAP_GPIO_IRQ(12), IRQT_FALLING);
-	set_irq_type(OMAP_GPIO_IRQ(13), IRQT_FALLING);
-	set_irq_type(OMAP_GPIO_IRQ(14), IRQT_FALLING);
-	set_irq_type(OMAP_GPIO_IRQ(15), IRQT_FALLING);
-
-	platform_add_devices(netstar_devices, ARRAY_SIZE(netstar_devices));
-
-	/* Switch on green LED */
-	omap_set_gpio_dataout(4, 0);
-	/* Switch off red LED */
-	omap_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
-	omap_writeb(0x80, OMAP_LPG1_LCR);
-
-	omap_board_config = netstar_config;
-	omap_board_config_size = ARRAY_SIZE(netstar_config);
-	omap_serial_init();
-}
-
-static void __init netstar_map_io(void)
-{
-	omap_map_common_io();
-}
-
-#define MACHINE_PANICED		1
-#define MACHINE_REBOOTING	2
-#define MACHINE_REBOOT		4
-static unsigned long machine_state;
-
-static int panic_event(struct notifier_block *this, unsigned long event,
-	 void *ptr)
-{
-	if (test_and_set_bit(MACHINE_PANICED, &machine_state))
-		return NOTIFY_DONE;
-
-	/* Switch off green LED */
-	omap_set_gpio_dataout(4, 1);
-	/* Flash red LED */
-	omap_writeb(0x78, OMAP_LPG1_LCR);
-	omap_writeb(0x01, OMAP_LPG1_PMR);	/* Enable clock */
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block panic_block = {
-	.notifier_call	= panic_event,
-};
-
-static int __init netstar_late_init(void)
-{
-	/* TODO: Setup front panel switch here */
-
-	/* Setup panic notifier */
-	notifier_chain_register(&panic_notifier_list, &panic_block);
-
-	return 0;
-}
-
-postcore_initcall(netstar_late_init);
-
-MACHINE_START(NETSTAR, "NetStar OMAP5910")
-	/* Maintainer: Ladislav Michl <michl@2n.cz> */
-	.phys_ram	= 0x10000000,
-	.phys_io	= 0xfff00000,
-	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
-	.boot_params	= 0x10000100,
-	.map_io		= netstar_map_io,
-	.init_irq	= netstar_init_irq,
-	.init_machine	= netstar_init,
-	.timer		= &omap_timer,
-MACHINE_END
