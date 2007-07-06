From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 7/11] Board file for 3430 SDP
Date: Thu, 5 Jul 2007 23:40:03 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470142E61E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mach-omap2/board-3430sdp.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/board-3430sdp.c =
val_3430_GIT/arch/arm/mach-omap2/board-3430sdp.c
--- linux-omap/arch/arm/mach-omap2/board-3430sdp.c	1969-12-31 =
18:00:00.000000000 -0600
+++ val_3430_GIT/arch/arm/mach-omap2/board-3430sdp.c	2007-07-05 =
18:39:30.000000000 -0500
@@ -0,0 +1,193 @@
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
+#include <asm/arch/board.h>
+#include <asm/arch/common.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/gpmc.h>
+
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#define	SDP3430_FLASH_CS	0
+#define	SDP3430_SMC91X_CS	3
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
+	},
+	[1] =3D {
+		.start		=3D OMAP_GPIO_IRQ(OMAP34XX_ETHR_GPIO_IRQ),
+		.end	=3D 0,
+		.flags		=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdp3430_smc91x_device =3D {
+	.name		=3D "smc91x",
+	.id		=3D -1,
+	.num_resources	=3D ARRAY_SIZE(sdp3430_smc91x_resources),
+	.resource	=3D sdp3430_smc91x_resources,
+};
+
+static struct platform_device *sdp3430_devices[] __initdata =3D {
+	&sdp3430_smc91x_device,
+	&sdp3430_flash_device,
+};
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
+
+	if (omap_request_gpio(OMAP34XX_ETHR_GPIO_IRQ) < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
+			OMAP34XX_ETHR_GPIO_IRQ);
+		return;
+	}
+	omap_set_gpio_direction(OMAP34XX_ETHR_GPIO_IRQ, 1);
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
+static struct omap_board_config_kernel sdp3430_config[] =3D {
+	{ OMAP_TAG_UART,	&sdp3430_uart_config },
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
