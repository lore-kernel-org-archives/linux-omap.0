From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH Resend 1/3] ARM: OMAP: Add support for USB on OMAP34XX
Date: Fri, 14 Dec 2007 19:32:42 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A088050666B6@dbde01.ent.ti.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

Added support for USB on OMAP34XX.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 arch/arm/mach-omap2/Makefile              |    3 -
 arch/arm/mach-omap2/board-3430sdp-usb.c   |   77 =
++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-3430sdp.c       |    1=20
 include/asm-arm/arch-omap/board-3430sdp.h |    4 +
 4 files changed, 84 insertions(+), 1 deletion(-)

Index: linux-omap-dec10/arch/arm/mach-omap2/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/arch/arm/mach-omap2/Makefile	2007-12-14 =
19:06:41.769920533 +0530
+++ linux-omap-dec10/arch/arm/mach-omap2/Makefile	2007-12-14 =
19:06:46.574767639 +0530
@@ -26,7 +26,8 @@
 					   board-2430sdp-flash.o \
 					   board-2430sdp-usb.o
 obj-$(CONFIG_MACH_OMAP_2430OSK)		+=3D board-2430osk.o
-obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o
+obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o \
+					   board-3430sdp-usb.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
Index: linux-omap-dec10/arch/arm/mach-omap2/board-3430sdp-usb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-dec10/arch/arm/mach-omap2/board-3430sdp-usb.c	2007-12-14 =
19:07:25.650524215 +0530
@@ -0,0 +1,77 @@
+/*
+ * linux/arch/arm/mach-omap2/board-3430sdp-usb.c
+ *
+ * This file will contain the board specific details for the
+ * MENTOR USB OTG and Synopsys EHCI host controllers on OMAP3430
+ *
+ * Copyright (C) 2007 Texas Instruments
+ * Author: Vikram Pandita
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/usb/musb.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/usb.h>
+
+#ifdef CONFIG_USB_MUSB_SOC
+static struct resource musb_resources[] =3D {
+	[0] =3D {
+		.start	=3D OMAP34XX_HSUSB_OTG_BASE,
+		.end	=3D OMAP34XX_HSUSB_OTG_BASE + SZ_8K,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[1] =3D {	/* general IRQ */
+		.start	=3D INT_243X_HS_USB_MC,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+	[2] =3D {	/* DMA IRQ */
+		.start	=3D INT_243X_HS_USB_DMA,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct musb_hdrc_platform_data musb_plat =3D {
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode		=3D MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode		=3D MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode		=3D MUSB_PERIPHERAL,
+#endif
+	.multipoint	=3D 1,
+	.clock 		=3D NULL,
+	.set_clock	=3D NULL,
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
+#endif
+
+void __init sdp3430_usb_init(void)
+{
+#ifdef CONFIG_USB_MUSB_SOC
+	if (platform_device_register(&musb_device) < 0) {
+		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+		return;
+	}
+#endif
+}
Index: linux-omap-dec10/arch/arm/mach-omap2/board-3430sdp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-12-14 =
19:06:41.769920533 +0530
+++ linux-omap-dec10/arch/arm/mach-omap2/board-3430sdp.c	2007-12-14 =
19:06:46.574767639 +0530
@@ -316,6 +316,7 @@
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
+	sdp3430_usb_init();
 }
=20
 static void __init omap_3430sdp_map_io(void)
Index: linux-omap-dec10/include/asm-arm/arch-omap/board-3430sdp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-dec10.orig/include/asm-arm/arch-omap/board-3430sdp.h	=
2007-12-14 19:06:41.769920533 +0530
+++ linux-omap-dec10/include/asm-arm/arch-omap/board-3430sdp.h	=
2007-12-14 19:06:46.575767607 +0530
@@ -29,6 +29,10 @@
 #ifndef __ASM_ARCH_OMAP_3430SDP_H
 #define __ASM_ARCH_OMAP_3430SDP_H
=20
+#include <linux/init.h>
+
+extern void __init sdp3430_usb_init(void);
+
 #define DEBUG_BASE			0x08000000  /* debug board */
=20
 /* Placeholder for 3430SDP specific defines */
