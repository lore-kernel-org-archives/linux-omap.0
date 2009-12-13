From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: [PATCH v2 1/2] OMAP: convert boards to use physmap-flash
Date: Mon, 14 Dec 2009 00:55:19 +0100
Message-ID: <20091213235519.GA6651@localhost.localdomain>
References: <20091208192111.GA32268@localhost.localdomain> <20091208192421.GB32268@localhost.localdomain> <20091211221209.GE24013@atomide.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:38638 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569AbZLMWz2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Dec 2009 17:55:28 -0500
Content-Disposition: inline
In-Reply-To: <20091211221209.GE24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Convert OMAP based boards to use physmap-flash. Refreshed against today's
Linux omap kernel tree

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- /dev/null	2009-12-08 14:04:43.543715066 +0100
+++ linux-omap-2.6/arch/arm/plat-omap/include/plat/flash.h	2009-12-08 18:53:34.000000000 +0100
@@ -0,0 +1,16 @@
+/*
+ * Flash support for OMAP1
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP_FLASH_H
+#define __OMAP_FLASH_H
+
+#include <linux/mtd/map.h>
+
+extern void omap1_set_vpp(struct map_info *map, int enable);
+
+#endif
--- /dev/null	2009-12-08 14:04:43.543715066 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/flash.c	2009-12-08 18:45:16.000000000 +0100
@@ -0,0 +1,33 @@
+/*
+ * Flash support for OMAP1
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+
+#include <plat/io.h>
+#include <plat/tc.h>
+
+void omap1_set_vpp(struct map_info *map, int enable)
+{
+	static int count;
+	u32 l;
+
+	if (enable) {
+		if (count++ == 0) {
+			l = omap_readl(EMIFS_CONFIG);
+			l |= OMAP_EMIFS_CONFIG_WP;
+			omap_writel(l, EMIFS_CONFIG);
+		}
+	} else {
+		if (count && (--count == 0)) {
+			l = omap_readl(EMIFS_CONFIG);
+			l &= ~OMAP_EMIFS_CONFIG_WP;
+			omap_writel(l, EMIFS_CONFIG);
+		}
+	}
+}
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 9ce17f1..3378486 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := io.o id.o sram.o irq.o mux.o serial.o devices.o
+obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
 obj-y += clock.o clock_data.o opp_data.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 7e70c3c..096f2ed 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -18,18 +18,19 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
 #include <mach/gpio.h>
 #include <plat/mux.h>
+#include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/keypad.h>
 #include <plat/common.h>
@@ -150,9 +151,9 @@ static struct mtd_partition nor_partitions[] = {
 	},
 };
 
-static struct flash_platform_data nor_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data nor_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= nor_partitions,
 	.nr_parts	= ARRAY_SIZE(nor_partitions),
 };
@@ -164,7 +165,7 @@ static struct resource nor_resource = {
 };
 
 static struct platform_device nor_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &nor_data,
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index fa7cece..d1100e4 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
@@ -35,7 +36,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <plat/mux.h>
@@ -45,6 +45,7 @@
 #include <plat/usb.h>
 #include <plat/keypad.h>
 #include <plat/common.h>
+#include <plat/flash.h>
 
 #include "board-h2.h"
 
@@ -121,9 +122,9 @@ static struct mtd_partition h2_nor_partitions[] = {
 	}
 };
 
-static struct flash_platform_data h2_nor_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data h2_nor_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= h2_nor_partitions,
 	.nr_parts	= ARRAY_SIZE(h2_nor_partitions),
 };
@@ -134,7 +135,7 @@ static struct resource h2_nor_resource = {
 };
 
 static struct platform_device h2_nor_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &h2_nor_data,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 6a7f9c3..a53ab82 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c/tps65010.h>
@@ -37,7 +38,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <mach/irqs.h>
@@ -47,6 +47,7 @@
 #include <plat/keypad.h>
 #include <plat/dma.h>
 #include <plat/common.h>
+#include <plat/flash.h>
 
 #include "board-h3.h"
 
@@ -126,9 +127,9 @@ static struct mtd_partition nor_partitions[] = {
 	}
 };
 
-static struct flash_platform_data nor_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data nor_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= nor_partitions,
 	.nr_parts	= ARRAY_SIZE(nor_partitions),
 };
@@ -139,7 +140,7 @@ static struct resource nor_resource = {
 };
 
 static struct platform_device nor_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &nor_data,
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2133b00..5d12fd3 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -22,16 +22,17 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <plat/mux.h>
+#include <plat/flash.h>
 #include <plat/fpga.h>
 #include <mach/gpio.h>
 #include <plat/tc.h>
@@ -94,9 +95,9 @@ static struct mtd_partition innovator_partitions[] = {
 	}
 };
 
-static struct flash_platform_data innovator_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data innovator_flash_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= innovator_partitions,
 	.nr_parts	= ARRAY_SIZE(innovator_partitions),
 };
@@ -108,7 +109,7 @@ static struct resource innovator_flash_resource = {
 };
 
 static struct platform_device innovator_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &innovator_flash_data,
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index ccea4f4..80d8620 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -37,6 +37,7 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <linux/i2c/tps65010.h>
 
@@ -46,8 +47,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
+#include <plat/flash.h>
 #include <plat/usb.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
@@ -94,9 +95,9 @@ static struct mtd_partition osk_partitions[] = {
 	}
 };
 
-static struct flash_platform_data osk_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data osk_flash_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= osk_partitions,
 	.nr_parts	= ARRAY_SIZE(osk_partitions),
 };
@@ -107,7 +108,7 @@ static struct resource osk_flash_resource = {
 };
 
 static struct platform_device osk5912_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &osk_flash_data,
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 9fe8872..569b4c9 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/apm-emulation.h>
@@ -31,9 +32,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
 #include <mach/gpio.h>
+#include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/tc.h>
@@ -126,9 +127,9 @@ static struct mtd_partition palmte_rom_partitions[] = {
 	},
 };
 
-static struct flash_platform_data palmte_rom_data = {
-	.map_name	= "map_rom",
+static struct physmap_flash_data palmte_rom_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= palmte_rom_partitions,
 	.nr_parts	= ARRAY_SIZE(palmte_rom_partitions),
 };
@@ -140,7 +141,7 @@ static struct resource palmte_rom_resource = {
 };
 
 static struct platform_device palmte_rom_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= -1,
 	.dev		= {
 		.platform_data	= &palmte_rom_data,
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index af068e3..6ad49a2 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -21,16 +21,17 @@
 #include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/leds.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
 #include <plat/led.h>
 #include <mach/gpio.h>
+#include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/dma.h>
@@ -104,9 +105,9 @@ static struct mtd_partition palmtt_partitions[] = {
 	}
 };
 
-static struct flash_platform_data palmtt_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data palmtt_flash_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= palmtt_partitions,
 	.nr_parts	= ARRAY_SIZE(palmtt_partitions),
 };
@@ -118,7 +119,7 @@ static struct resource palmtt_flash_resource = {
 };
 
 static struct platform_device palmtt_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &palmtt_flash_data,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index c7a3b6f..6641de9 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -25,14 +25,15 @@
 #include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
 #include <mach/gpio.h>
+#include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/dma.h>
@@ -126,10 +127,9 @@ static struct mtd_partition palmz71_rom_partitions[] = {
 	},
 };
 
-static struct flash_platform_data palmz71_rom_data = {
-	.map_name	= "map_rom",
-	.name		= "onboardrom",
+static struct physmap_flash_data palmz71_rom_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= palmz71_rom_partitions,
 	.nr_parts	= ARRAY_SIZE(palmz71_rom_partitions),
 };
@@ -141,7 +141,7 @@ static struct resource palmz71_rom_resource = {
 };
 
 static struct platform_device palmz71_rom_device = {
-	.name	= "omapflash",
+	.name	= "physmap-flash",
 	.id	= -1,
 	.dev = {
 		.platform_data = &palmz71_rom_data,
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 1387a4f..e854d57 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -18,19 +18,20 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <plat/tc.h>
 #include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
+#include <plat/flash.h>
 #include <plat/keypad.h>
 #include <plat/common.h>
 #include <plat/board.h>
@@ -117,9 +118,9 @@ static struct mtd_partition nor_partitions[] = {
 	},
 };
 
-static struct flash_platform_data nor_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data nor_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= nor_partitions,
 	.nr_parts	= ARRAY_SIZE(nor_partitions),
 };
@@ -131,7 +132,7 @@ static struct resource nor_resource = {
 };
 
 static struct platform_device nor_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &nor_data,
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 7a97fac..2fb1e5f 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -22,6 +22,7 @@
 #include <linux/notifier.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/types.h>
 #include <linux/i2c.h>
 #include <linux/errno.h>
@@ -29,10 +30,10 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
+#include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/irda.h>
@@ -287,9 +288,9 @@ static struct mtd_partition sx1_partitions[] = {
 	}
 };
 
-static struct flash_platform_data sx1_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data sx1_flash_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 	.parts		= sx1_partitions,
 	.nr_parts	= ARRAY_SIZE(sx1_partitions),
 };
@@ -310,7 +311,7 @@ static struct resource sx1_old_flash_resource[] = {
 };
 
 static struct platform_device sx1_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &sx1_flash_data,
@@ -327,7 +328,7 @@ static struct resource sx1_new_flash_resource = {
 };
 
 static struct platform_device sx1_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &sx1_flash_data,
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 1691835..87b9436 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/mtd/physmap.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
@@ -27,11 +28,11 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <plat/common.h>
 #include <mach/gpio.h>
+#include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
 #include <plat/usb.h>
@@ -86,9 +87,9 @@ static int __init ext_uart_init(void)
 }
 arch_initcall(ext_uart_init);
 
-static struct flash_platform_data voiceblue_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data voiceblue_flash_data = {
 	.width		= 2,
+	.set_vpp	= omap1_set_vpp,
 };
 
 static struct resource voiceblue_flash_resource = {
@@ -98,7 +99,7 @@ static struct resource voiceblue_flash_resource = {
 };
 
 static struct platform_device voiceblue_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &voiceblue_flash_data,
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index db9374b..c04bfe7 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/delay.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/err.h>
@@ -28,7 +29,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
 #include <mach/gpio.h>
 #include <plat/mux.h>
@@ -74,8 +74,7 @@ static struct mtd_partition sdp2430_partitions[] = {
 	}
 };
 
-static struct flash_platform_data sdp2430_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data sdp2430_flash_data = {
 	.width		= 2,
 	.parts		= sdp2430_partitions,
 	.nr_parts	= ARRAY_SIZE(sdp2430_partitions),
@@ -88,7 +87,7 @@ static struct resource sdp2430_flash_resource = {
 };
 
 static struct platform_device sdp2430_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev = {
 		.platform_data	= &sdp2430_flash_data,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index cfb7f12..ffb0051 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/i2c.h>
@@ -29,7 +30,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/flash.h>
 
 #include <plat/control.h>
 #include <mach/gpio.h>
@@ -115,8 +115,7 @@ static struct mtd_partition h4_partitions[] = {
 	}
 };
 
-static struct flash_platform_data h4_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data h4_flash_data = {
 	.width		= 2,
 	.parts		= h4_partitions,
 	.nr_parts	= ARRAY_SIZE(h4_partitions),
@@ -127,7 +126,7 @@ static struct resource h4_flash_resource = {
 };
 
 static struct platform_device h4_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &h4_flash_data,

