From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 07 Jun 2012 00:13:09 -0600
Message-ID: <20120607061308.25532.19767.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60878 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760019Ab2FGGVh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:21:37 -0400
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

=46rom: Tero Kristo <t-kristo@ti.com>

Add a custom reset function for the usb_host_fs/fsusb IP block, and
connect it to the OMAP4 FSUSB block.

This is the first of two fixes required to get rid of the boot
warning:

omap_hwmod: usb_host_fs: _wait_target_disable failed

and to allow the module to idle.

It may be necessary to use this reset method for OMAP2xxx SoCs as
well; this is left for a future patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul@pwsan.com: rewrote the custom reset function, documented it and
 updated the commit message, and moved the code to mach-omap2/fs-usb.c]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Makefile               |    4 --
 arch/arm/mach-omap2/cm.h                   |    8 +++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1=20
 arch/arm/mach-omap2/usb-fs.c               |   62 ++++++++++++++++++++=
++++++++
 arch/arm/plat-omap/include/plat/usb.h      |    3 +
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index bc2ac4f..fc2ff91 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -245,9 +245,7 @@ omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:=3D hsmmc.o
 obj-y					+=3D $(omap-hsmmc-m) $(omap-hsmmc-y)
=20
=20
-usbfs-$(CONFIG_ARCH_OMAP_OTG)		:=3D usb-fs.o
-obj-y					+=3D $(usbfs-m) $(usbfs-y)
-obj-y					+=3D usb-musb.o
+obj-y					+=3D usb-fs.o usb-musb.o
 obj-y					+=3D omap_phy_internal.o
=20
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+=3D usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index a7bc096..99978c7 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -1,7 +1,7 @@
 /*
  * OMAP2+ Clock Management prototypes
  *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2012 Texas Instruments, Inc.
  * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
@@ -14,6 +14,12 @@
 #define __ARCH_ASM_MACH_OMAP2_CM_H
=20
 /*
+ * MAX_MODULE_SOFTRESET_TIME: maximum time in microseconds to wait for
+ * an IP block to finish an OCP SOFTRESET.
+ */
+#define MAX_MODULE_SOFTRESET_WAIT	10000
+
+/*
  * MAX_MODULE_READY_TIME: max duration in microseconds to wait for the
  * PRCM to request that a module exit the inactive state in the case o=
f
  * OMAP2 & 3.
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index a93ce48..02daacc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3314,6 +3314,7 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_usb_host_fs_sysc =3D {
 static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class =3D {
 	.name	=3D "usb_host_fs",
 	.sysc	=3D &omap44xx_usb_host_fs_sysc,
+	.reset	=3D omap_usb_host_fs_reset,
 };
=20
 /* usb_host_fs */
diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.=
c
index 1481078..4faf0f7 100644
--- a/arch/arm/mach-omap2/usb-fs.c
+++ b/arch/arm/mach-omap2/usb-fs.c
@@ -1,7 +1,7 @@
 /*
  * Platform level USB initialization for FS USB OTG controller on omap=
1 and 24xx
  *
- * Copyright (C) 2004 Texas Instruments, Inc.
+ * Copyright (C) 2004, 2012 Texas Instruments, Inc.
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License as published b=
y
@@ -32,6 +32,8 @@
 #include <plat/usb.h>
 #include <plat/board.h>
=20
+#include "cm.h"
+#include "common.h"
 #include "control.h"
 #include "mux.h"
=20
@@ -41,6 +43,64 @@
 #define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
 #define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
=20
+/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS registe=
r */
+#define HCCOMMANDSTATUS			0x0008
+
+/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag =
*/
+#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
+
+/**
+ * omap_usb_host_fs_reset - custom reset function for the FSUSB IP blo=
ck
+ * @oh: struct omap_hwmod * of the usb_host_fs IP block
+ *
+ * Reset the FSUSB IP block.  This IP block requires a custom
+ * two-stage reset; otherwise the IP block won't idle-ack to the PRCM.
+ * First the OCP SOFTRESET method must be used.  Next, the IP block's
+ * internal reset bit must be toggled.  This will place the OHCI
+ * controller state into UsbSuspend, which allows the IP block to
+ * idle-ack to the PRCM.  Note that the FSUSB still takes almost 4
+ * milliseconds to idle-ack after this function returns.  Returns 0
+ * upon success, -EINVAL if the IP block softreset data wasn't
+ * supplied, or -EBUSY if the IP block reset times out.
+ */
+int omap_usb_host_fs_reset(struct omap_hwmod *oh)
+{
+	int c;
+
+	if (omap_hwmod_softreset(oh))
+		return -EINVAL;
+
+	omap_test_timeout(!(omap_hwmod_read(oh, oh->class->sysc->sysc_offs)
+			   & SYSC_TYPE2_SOFTRESET_MASK),
+			  MAX_MODULE_SOFTRESET_WAIT, c);
+
+	if (c =3D=3D MAX_MODULE_SOFTRESET_WAIT) {
+		pr_warn("%s: %s: softreset failed (waited %d usec)\n",
+			__func__, oh->name, MAX_MODULE_SOFTRESET_WAIT);
+		return -EBUSY;
+	} else {
+		pr_debug("%s: %s: softreset in %d usec\n", __func__,
+			 oh->name, c);
+	}
+
+	omap_hwmod_write(HCCOMMANDSTATUS_HCR_MASK, oh, HCCOMMANDSTATUS);
+
+	omap_test_timeout(!(omap_hwmod_read(oh, HCCOMMANDSTATUS)
+			    & HCCOMMANDSTATUS_HCR_MASK),
+			  MAX_MODULE_SOFTRESET_WAIT, c);
+
+	if (c =3D=3D MAX_MODULE_SOFTRESET_WAIT) {
+		pr_warn("%s: %s: host controller reset failed (waited %d usec)\n",
+			__func__, oh->name, MAX_MODULE_SOFTRESET_WAIT);
+		return -EBUSY;
+	} else {
+		pr_debug("%s: %s: host controller reset in %d usec\n", __func__,
+			 oh->name, c);
+	}
+
+	return 0;
+}
+
 #if defined(CONFIG_ARCH_OMAP2)
=20
 #ifdef	CONFIG_USB_GADGET_OMAP
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap=
/include/plat/usb.h
index 762eeb0..ac7db50 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -6,6 +6,7 @@
 #include <linux/io.h>
 #include <linux/usb/musb.h>
 #include <plat/board.h>
+#include <plat/omap_hwmod.h>
=20
 #define OMAP3_HS_USB_PORTS	3
=20
@@ -181,6 +182,8 @@ static inline void omap2_usbfs_init(struct omap_usb=
_config *pdata)
 }
 #endif
=20
+extern int omap_usb_host_fs_reset(struct omap_hwmod *oh);
+
 /*--------------------------------------------------------------------=
-----*/
=20
 /*


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
