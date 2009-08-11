From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] OMAP2/3: Add support for flash on SDP boards
Date: Tue, 11 Aug 2009 12:53:15 +0300
Message-ID: <20090811095315.32577.89520.stgit@localhost>
References: <20090811094348.32577.81307.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090811094348.32577.81307.stgit@localhost>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add support for flash on SDP boards. Currently only onenand
is supported.

Only tested on 3430SDP, somebody please test on 2430SDP and
check the chip select for 2430SDP.

Also note that in the earlier 2430SDP code the kernel partition
was set to only 1MB instead of 2MB on 3430SDP. If people want
the old partition sizes back on 2430SDP, please provide a patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/board-2430sdp.c   |    2 +
 arch/arm/mach-omap2/board-3430sdp.c   |    2 +
 arch/arm/mach-omap2/board-sdp-flash.c |   78 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-sdp.h       |    9 ++++
 5 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/board-sdp.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 735bae5..2a2361e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
@@ -61,6 +62,7 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
+					   board-sdp-flash.o \
 					   mmc-twl4030.o
 
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 03f0887..bea6f06 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -39,6 +39,7 @@
 #include <mach/gpmc-smc91x.h>
 
 #include "mmc-twl4030.h"
+#include "board-sdp.h"
 
 #define SDP2430_CS0_BASE	0x04000000
 #define SECONDARY_LCD_GPIO		147
@@ -210,6 +211,7 @@ static void __init omap_2430sdp_init(void)
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
+	sdp_flash_init();
 
 	/* Turn off secondary LCD backlight */
 	ret = gpio_request(SECONDARY_LCD_GPIO, "Secondary LCD backlight");
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 3f5c316..f5c8fa7 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -43,6 +43,7 @@
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
+#include "board-sdp.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -494,6 +495,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init(&sdp3430_uart_config);
 	usb_musb_init();
 	board_smc91x_init();
+	sdp_flash_init();
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
new file mode 100644
index 0000000..1496d89
--- /dev/null
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -0,0 +1,78 @@
+/*
+ * linux/arch/arm/mach-omap2/board-sdp-flash.c
+ *
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include <mach/onenand.h>
+
+/* REVISIT: Add support for other flash memory types */
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition board_onenand_partitions[] = {
+	{
+		.name		= "X-Loader-OneNAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE	 /* force read-only */
+	},
+	{
+		.name		= "U-Boot-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE	 /* force read-only */
+	},
+	{
+		.name		= "U-Boot Environment-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 1 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 16 * (64 * 2048),
+	},
+	{
+		.name		= "File System-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.cs		= 2,	/* REVISIT: Is this the same for 2430 SDP? */
+	.parts		= board_onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(board_onenand_partitions),
+	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static void __init board_onenand_init(void)
+{
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#else
+
+static inline void board_onenand_init(void)
+{
+}
+
+#endif	/* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
+
+void __init sdp_flash_init(void)
+{
+	board_onenand_init();
+}
diff --git a/arch/arm/mach-omap2/board-sdp.h b/arch/arm/mach-omap2/board-sdp.h
new file mode 100644
index 0000000..ad72189
--- /dev/null
+++ b/arch/arm/mach-omap2/board-sdp.h
@@ -0,0 +1,9 @@
+/*
+ *  arch/arm/plat-omap/include/mach/board-sdp.h
+ *
+ *  Information structures for SDP-specific board config data
+ *
+ *  Copyright (C) 2009 Nokia Corporation
+ */
+
+extern void sdp_flash_init(void);


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
