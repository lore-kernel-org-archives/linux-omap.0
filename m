From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 5/12] OMAP3430 support in mach-omap2 folder
Date: Thu, 31 May 2007 12:58:25 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701063213@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Adding OMAP 3430 support to arch/arm/mach-omap2

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 Kconfig         |   14 ++
 Makefile        |    6 -
 board-3430sdp.c |  301
 clock.h         |    1
 gpmc.c          |    8 -
 id.c            |   23 ++--
 irq.c           |   20 ++-
 7 files changed, 350 insertions(+), 23 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/Kconfig =
val_3430_GIT/arch/arm/mach-omap2/Kconfig
--- linux-omap/arch/arm/mach-omap2/Kconfig	2007-04-02 02:29:57.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/Kconfig	2007-05-28 =
12:47:12.000000000 -0500
@@ -5,6 +5,10 @@ config ARCH_OMAP24XX
 	bool "OMAP24xx Based System"
 	depends on ARCH_OMAP2
=20
+config ARCH_OMAP34XX
+	bool "OMAP34xx Based System"
+	depends on ARCH_OMAP3
+
 config ARCH_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP24XX
@@ -15,8 +19,12 @@ config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP24XX
=20
+config ARCH_OMAP3430
+	bool "OMAP3430 support"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2
+	depends on ARCH_OMAP2 || ARCH_OMAP3
=20
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
@@ -37,6 +45,10 @@ config MACH_OMAP_H4
 	select OMAP_DEBUG_DEVICES
 	select GPIOEXPANDER_OMAP
=20
+
+config MACH_OMAP_3430SDP
+	bool "OMAP 3430 SDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 config MACH_OMAP_H4_TUSB
 	bool "TUSB 6010 EVM board"
 	depends on MACH_OMAP_H4
diff -purN linux-omap/arch/arm/mach-omap2/Makefile =
val_3430_GIT/arch/arm/mach-omap2/Makefile
--- linux-omap/arch/arm/mach-omap2/Makefile	2007-05-16 =
14:32:40.000000000 -0500
+++ val_3430_GIT/arch/arm/mach-omap2/Makefile	2007-05-25 =
23:53:23.000000000 -0500
@@ -3,9 +3,12 @@
 #
=20
 # Common support
-obj-y :=3D irq.o id.o io.o sram-fn.o memory.o prcm.o clock.o mux.o =
devices.o \
+obj-y :=3D irq.o id.o io.o sram-fn.o memory.o prcm.o mux.o devices.o \
 	 serial.o gpmc.o
=20
+obj-$(CONFIG_ARCH_OMAP24XX) +=3D clock.o
+obj-$(CONFIG_ARCH_OMAP34XX) +=3D clock_34xx.o
+
 obj-$(CONFIG_OMAP_MPU_TIMER)		+=3D timer-gp.o
=20
 # Power Management
@@ -23,6 +26,7 @@ obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o \
 					   board-2430sdp-flash.o \
 					   board-2430sdp-usb.o
+obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+=3D board-n800.o board-n800-flash.o \
diff -purN linux-omap/arch/arm/mach-omap2/board-3430sdp.c =
val_3430_GIT/arch/arm/mach-omap2/board-3430sdp.c
--- linux-omap/arch/arm/mach-omap2/board-3430sdp.c	1969-12-31 =
18:00:00.000000000 -0600
+++ val_3430_GIT/arch/arm/mach-omap2/board-3430sdp.c	2007-05-29 =
12:53:11.000000000 -0500
@@ -0,0 +1,301 @@
+/*
+ * linux/arch/arm/mach-omap2/board-3430sdp.c
+ *
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Modified from mach-omap2/board-generic.c
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
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/input.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/flash.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/usb.h>
+#include <asm/arch/board.h>
+#include <asm/arch/common.h>
+#include <asm/arch/keypad.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/gpmc.h>
+
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#define	SDP3430_FLASH_CS	0
+#define	SDP3430_SMC91X_CS	3
+
+#ifdef CONFIG_USB_MUSB_HDRC
+#include <linux/usb_musb.h>
+#endif
+
+static struct mtd_partition sdp3430_partitions[] =3D {
+	/* bootloader (U-Boot, etc) in first sector */
+	{
+		  .name		=3D "bootloader",
+		  .offset		=3D 0,
+		  .size		=3D SZ_256K,
+		  .mask_flags	=3D MTD_WRITEABLE, /* force read-only */
+	},
+	/* bootloader params in the next sector */
+	{
+		  .name		=3D "params",
+		  .offset		=3D MTDPART_OFS_APPEND,
+		  .size		=3D SZ_128K,
+		  .mask_flags	=3D 0,
+	},
+	/* kernel */
+	{
+		  .name		=3D "kernel",
+		  .offset		=3D MTDPART_OFS_APPEND,
+		  .size		=3D SZ_2M,
+		  .mask_flags	=3D 0
+	},
+	/* file system */
+	{
+		  .name		=3D "filesystem",
+		  .offset		=3D MTDPART_OFS_APPEND,
+		  .size		=3D MTDPART_SIZ_FULL,
+		  .mask_flags	=3D 0
+	}
+};
+
+static struct flash_platform_data sdp3430_flash_data =3D {
+	.map_name	=3D "cfi_probe",
+	.width		=3D 2,
+	.parts		=3D sdp3430_partitions,
+	.nr_parts	=3D ARRAY_SIZE(sdp3430_partitions),
+};
+
+static struct resource sdp3430_flash_resource =3D {
+	.start		=3D FLASH_BASE,
+	.end		=3D FLASH_BASE + SZ_64M - 1,
+	.flags		=3D IORESOURCE_MEM,
+};
+
+static struct platform_device sdp3430_flash_device =3D {
+	.name		=3D "omapflash",
+	.id		=3D 0,
+	.dev		=3D {
+		.platform_data	=3D &sdp3430_flash_data,
+	},
+	.num_resources	=3D 1,
+	.resource	=3D &sdp3430_flash_resource,
+};
+
+static struct resource sdp3430_smc91x_resources[] =3D {
+	[0] =3D {
+		.start	=3D OMAP34XX_ETHR_START,
+		.end	=3D OMAP34XX_ETHR_START + SZ_4K,
+		.flags		=3D IORESOURCE_MEM,
+		  },
+	[1] =3D {
+		.start		=3D OMAP_GPIO_IRQ(OMAP34XX_ETHR_GPIO_IRQ),
+		.end	=3D 0,
+		.flags		=3D IORESOURCE_IRQ,
+		  },
+};
+
+static struct platform_device sdp3430_smc91x_device =3D {
+	.name		=3D "smc91x",
+	.id		=3D -1,
+	.num_resources	=3D ARRAY_SIZE(sdp3430_smc91x_resources),
+	.resource	=3D sdp3430_smc91x_resources,
+};
+
+#ifdef CONFIG_USB_MUSB_HDRC
+static struct resource musb_resources[] =3D {
+	[0] =3D {
+		 .start	=3D OMAP343X_HS_BASE,
+		 .end	=3D OMAP343X_HS_BASE + SZ_8K,
+		 .flags	=3D IORESOURCE_MEM,
+		  },
+	[1] =3D {	/* general IRQ */
+		 .start	=3D INT_HS_USB_MC_NINT,
+		 .flags	=3D IORESOURCE_IRQ,
+		  },
+	[2] =3D {		/* DMA IRQ */
+		 .start	=3D INT_HS_USB_DMA_NINT,
+		 .flags	=3D IORESOURCE_IRQ,
+		  },
+};
+
+static struct musb_hdrc_platform_data musb_plat =3D {
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode		=3D MUSB_OTG,
+#elif CONFIG_USB_MUSB_HDRC_HCD
+	.mode		=3D MUSB_HOST,
+#elif CONFIG_USB_GADGET_MUSB_HDRC
+	.mode		=3D MUSB_PERIPHERAL,
+#endif
+	.multipoint	=3D 1,
+};
+
+static u64 musb_dmamask =3D ~(u32)0;
+
+static struct platform_device musb_device =3D {
+	.name		=3D "musb_hdrc",
+	.id		=3D 0,
+	.dev =3D {
+		.dma_mask		=3D &musb_dmamask,
+		.coherent_dma_mask	=3D 0xffffffff,
+		.platform_data		=3D &musb_plat,
+	},
+	.num_resources	=3D ARRAY_SIZE(musb_resources),
+	.resource	=3D musb_resources,
+};
+#endif /* CONFIG_USB_MUSB_HDRC */
+static struct platform_device *sdp3430_devices[] __initdata =3D {
+	&sdp3430_smc91x_device,
+	&sdp3430_flash_device,
+#ifdef CONFIG_USB_MUSB_HDRC
+	&musb_device,
+#endif
+};
+#if 	defined(CONFIG_USB_OMAP24XX_FS_PORT0)
+static struct omap_usb_config fsusb_otg0_config __initdata =3D {
+	/* usb0 has a Mini-AB port and external isp1301 transceiver */
+	.otg		=3D 1,
+
+#ifdef	CONFIG_USB_GADGET_OMAP
+	.hmc_mode	=3D 0x0,	// 0:dev/otg 1:disabled 2:disabled
+
+#elif	defined(CONFIG_USB_OHCI_HCD) || =
defined(CONFIG_USB_OHCI_HCD_MODULE)
+	.hmc_mode	=3D 0x1,	// 0:host|otg 1:host 2:host
+#endif
+
+	.pins[0]	=3D 3,
+};
+
+#elif	defined(CONFIG_USB_OMAP24XX_FS_PORT1)
+static struct omap_usb_config fsusb_host1_config __initdata =3D {
+	.register_host	=3D 1,
+	.hmc_mode	=3D 0x1,	// 0:host|otg 1:host 2:host
+	.pins[1]	=3D 3,
+};
+#endif
+
+static inline void __init sdp3430_init_smc91x(void)
+{
+	int eth_cs;
+	unsigned long cs_mem_base;
+	unsigned int rate;
+	struct clk *l3ck;
+
+	eth_cs	=3D SDP3430_SMC91X_CS;
+
+	l3ck =3D clk_get(NULL, "core_l3_ck");
+	if (IS_ERR(l3ck))
+		rate =3D 100000000;
+	else
+		rate =3D clk_get_rate(l3ck);
+
+	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
+		return;
+	}
+
+	sdp3430_smc91x_resources[0].start =3D cs_mem_base + 0x0;
+	sdp3430_smc91x_resources[0].end   =3D cs_mem_base + 0xf;
+	udelay(100);
+	if (omap_request_gpio(OMAP34XX_ETHR_GPIO_IRQ) < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
+			OMAP34XX_ETHR_GPIO_IRQ);
+		return;
+	}
+	omap_set_gpio_direction(OMAP34XX_ETHR_GPIO_IRQ, 1);
+}
+
+static void __init sdp3430_init_flash(void)
+{
+	unsigned long base;
+
+	if (gpmc_cs_request(SDP3430_FLASH_CS, SZ_64M, &base) < 0) {
+		printk("Can't request GPMC CS for flash\n");
+		return;
+	}
+	sdp3430_flash_resource.start	=3D base;
+	sdp3430_flash_resource.end	=3D base + SZ_64M - 1;
+}
+
+static void __init omap_3430sdp_init_irq(void)
+{
+	omap2_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+	sdp3430_init_smc91x();
+}
+
+static struct omap_uart_config sdp3430_uart_config __initdata =3D {
+	.enabled_uarts	=3D ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static struct omap_mmc_config sdp3430_mmc_config __initdata =3D {
+	.mmc [0] =3D {
+		.enabled	=3D 1,
+		.wire4		=3D -1,
+		.wp_pin		=3D -1,
+		.power_pin	=3D -1,
+		.switch_pin	=3D 0,
+	},
+	.mmc [1] =3D {
+		.enabled	=3D 1,
+		.wire4		=3D -1,
+		.wp_pin		=3D -1,
+		.power_pin	=3D -1,
+		.switch_pin	=3D 1,
+	},
+};
+
+static struct omap_board_config_kernel sdp3430_config[] =3D {
+	{ OMAP_TAG_UART,	&sdp3430_uart_config },
+	{ OMAP_TAG_MMC,	&sdp3430_mmc_config },
+#if	defined(CONFIG_USB_OMAP24XX_FS_PORT0)
+	{ OMAP_TAG_USB,	&fsusb_otg0_config },
+#elif	defined(CONFIG_USB_OMAP24XX_FS_PORT1)
+	{ OMAP_TAG_USB,	&fsusb_host1_config },
+#endif
+};
+
+static void __init omap_3430sdp_init(void)
+{
+	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
+	omap_board_config =3D sdp3430_config;
+	omap_board_config_size =3D ARRAY_SIZE(sdp3430_config);
+	omap_serial_init();
+}
+
+static void __init omap_3430sdp_map_io(void)
+{
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP_SDP3430, "OMAP3430 sdp3430 board")
+	/* Maintainer: Syed Khasim - Texas Instruments Inc */
+	.phys_io	=3D 0x48000000,
+	.io_pg_offst	=3D ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	=3D 0x80000100,
+	.map_io		=3D omap_3430sdp_map_io,
+	.init_irq	=3D omap_3430sdp_init_irq,
+	.init_machine	=3D omap_3430sdp_init,
+	.timer		=3D &omap_timer,
+MACHINE_END
diff -purN linux-omap/arch/arm/mach-omap2/clock.h =
val_3430_GIT/arch/arm/mach-omap2/clock.h
--- linux-omap/arch/arm/mach-omap2/clock.h	2007-05-25 15:52:23.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/clock.h	2007-05-28 =
12:47:13.000000000 -0500
@@ -39,6 +39,7 @@ static u32 omap2_clksel_get_divisor(stru
=20
 #define RATE_IN_242X	(1 << 0)
 #define RATE_IN_243X	(1 << 1)
+#define RATE_IN_343X	(1 << 2)
=20
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are =
mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
diff -purN linux-omap/arch/arm/mach-omap2/gpmc.c =
val_3430_GIT/arch/arm/mach-omap2/gpmc.c
--- linux-omap/arch/arm/mach-omap2/gpmc.c	2007-05-16 14:32:40.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/gpmc.c	2007-05-29 =
14:27:19.000000000 -0500
@@ -22,12 +22,10 @@
=20
 #undef DEBUG
=20
-#ifdef CONFIG_ARCH_OMAP2420
+#if defined(CONFIG_ARCH_OMAP2420)
 #define GPMC_BASE		0x6800a000
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-#define GPMC_BASE		0x6E000000
+#elif defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#define GPMC_BASE		0x6e000000
 #endif
=20
 #define GPMC_REVISION		0x00
diff -purN linux-omap/arch/arm/mach-omap2/id.c =
val_3430_GIT/arch/arm/mach-omap2/id.c
--- linux-omap/arch/arm/mach-omap2/id.c	2006-11-20 21:54:01.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/id.c	2007-05-30 17:44:54.000000000 =
-0500
@@ -18,11 +18,11 @@
 #include <asm/io.h>
=20
 #if defined(CONFIG_ARCH_OMAP2420)
-#define OMAP24XX_TAP_BASE	io_p2v(0x48014000)
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2430)
-#define OMAP24XX_TAP_BASE	io_p2v(0x4900A000)
+#define TAP_BASE	io_p2v(0x48014000)
+#elif defined(CONFIG_ARCH_OMAP2430)
+#define TAP_BASE	io_p2v(0x4900A000)
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define TAP_BASE	io_p2v(0x54004000)
 #endif
=20
 #define OMAP_TAP_IDCODE		0x0204
@@ -58,7 +58,7 @@ static struct omap_id omap_ids[] __initd
=20
 static u32 __init read_tap_reg(int reg)
 {
-	return __raw_readl(OMAP24XX_TAP_BASE + reg);
+	return __raw_readl(TAP_BASE + reg);
 }
=20
 void __init omap2_check_revision(void)
@@ -118,9 +118,16 @@ void __init omap2_check_revision(void)
=20
 	system_rev |=3D rev << 8;
=20
-	/* Add the cpu class info (24xx) */
-	system_rev |=3D 0x24;
+	/* REVISIT:
+	 * OMAP 3430 ES 1.0 does't populate IDCODE registers
+	 * Following lines have to be revisited for next version
+	 */
=20
+#ifndef CONFIG_ARCH_OMAP3
+	system_rev |=3D 0x24;
+#else
+	system_rev |=3D 0x34;
+#endif
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
 		printk("%x", (system_rev >> 8) & 0x0f);
diff -purN linux-omap/arch/arm/mach-omap2/irq.c =
val_3430_GIT/arch/arm/mach-omap2/irq.c
--- linux-omap/arch/arm/mach-omap2/irq.c	2007-01-08 18:55:58.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-05-29 20:21:42.000000000 =
-0500
@@ -37,11 +37,9 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] =3D {
 	{
 		/* MPU INTC */
-		.base_reg	=3D IO_ADDRESS(OMAP24XX_IC_BASE),
+		.base_reg	=3D 0,
 		.nr_irqs	=3D 96,
-	}, {
-		/* XXX: DSP INTC */
-	}
+	},
 };
=20
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
@@ -118,10 +116,16 @@ void __init omap_init_irq(void)
 	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank =3D irq_banks + i;
=20
-		/* XXX */
-		if (!bank->base_reg)
-			continue;
-
+#ifdef CONFIG_ARCH_OMAP24XX
+		if (cpu_is_omap24xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP24XX_IC_BASE);
+		}
+#endif
+#ifdef CONFIG_ARCH_OMAP34XX
+		if (cpu_is_omap34xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP34XX_IC_BASE);
+		}
+#endif
 		omap_irq_bank_init_one(bank);
=20
 		nr_irqs +=3D bank->nr_irqs;
