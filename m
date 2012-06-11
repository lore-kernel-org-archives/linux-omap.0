From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
Date: Sun, 10 Jun 2012 18:46:20 -0600
Message-ID: <20120611004617.20034.21714.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42592 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab2FKAwL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:11 -0400
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

Add a custom setup_preprogram function for the usb_host_fs/fsusb IP
block, and connect it to the OMAP4 FSUSB block.

This is the first of two fixes required to get rid of the boot
warning:

omap_hwmod: usb_host_fs: _wait_target_disable failed

and to allow the module to idle.

It may be necessary to use this reset method for OMAP2xxx SoCs as
well; this is left for a future patch.

Based on a patch originally written by Tero Kristo <t-kristo@ti.com>.

This second version of this patch moves the control functions to
include/linux/platform_data/aess.h at Tony's request:

    http://www.spinics.net/lists/arm-kernel/msg178329.html

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +
 include/linux/platform_data/fsusb.h        |  105 ++++++++++++++++++++=
++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 include/linux/platform_data/fsusb.h

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 037424f..b8b28be 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
=20
 #include <linux/platform_data/aess.h>
+#include <linux/platform_data/fsusb.h>
=20
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
@@ -3314,6 +3315,7 @@ static struct omap_hwmod_class_sysconfig omap44xx=
_usb_host_fs_sysc =3D {
 static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class =3D {
 	.name	=3D "usb_host_fs",
 	.sysc	=3D &omap44xx_usb_host_fs_sysc,
+	.setup_preprogram	=3D hwmod_fsusb_preprogram,
 };
=20
 /* usb_host_fs */
diff --git a/include/linux/platform_data/fsusb.h b/include/linux/platfo=
rm_data/fsusb.h
new file mode 100644
index 0000000..d1e08e0
--- /dev/null
+++ b/include/linux/platform_data/fsusb.h
@@ -0,0 +1,105 @@
+/*
+ * FSUSB IP block integration
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+#ifndef __LINUX_PLATFORM_DATA_FSUSB_H__
+#define __LINUX_PLATFORM_DATA_FSUSB_H__
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+
+#include <plat/omap_hwmod.h>
+
+ /*
+  * MAX_MODULE_SOFTRESET_TIME: maximum time in microseconds to wait fo=
r
+  * an IP block to finish an OCP SOFTRESET.
+  */
+#define MAX_MODULE_SOFTRESET_TIME	10000
+
+ /*
+  * MAX_FSUSB_HCR_TIME: maximum time in microseconds to wait for the
+  * FSUSB block to complete its Host Controller Reset.  This 30 =C2=B5=
s
+  * timeout comes from ohci-hcd.c:ohci_run().
+  */
+#define MAX_FSUSB_HCR_TIME		30
+
+/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS registe=
r */
+#define HCCOMMANDSTATUS			0x0008
+
+/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag =
*/
+#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
+
+/**
+ * fsusb_reset_host_controller - execute an OHCI host controller reset
+ * @name: string that uniquely identifies this on-chip instance of the=
 IP block
+ * @base: base virtual address of the FSUSB IP block
+ *
+ * Run a Host Controller reset on the FSUSB IP block.  At the
+ * conclusion of this reset, the controller will be in UsbSuspend
+ * mode.  This differs from the OCP softreset, which leaves the
+ * controller in the UsbReset mode.  (The FSUSB must be in UsbSuspend
+ * mode to indicate idle to the OMAP PRCM.)  Returns 0 upon success
+ * or -EBUSY if the reset timed out.
+ */
+static int fsusb_reset_host_controller(const char *name, void __iomem =
*base)
+{
+	int i;
+
+	writel(HCCOMMANDSTATUS_HCR_MASK, base + HCCOMMANDSTATUS);
+
+	for (i =3D 0; i < MAX_FSUSB_HCR_TIME; i++) {
+		if (!(readl(base + HCCOMMANDSTATUS) & HCCOMMANDSTATUS_HCR_MASK))
+			break;
+		udelay(1);
+	}
+
+	if (i =3D=3D MAX_FSUSB_HCR_TIME) {
+		pr_warn("%s: %s: host controller reset failed (waited %d usec)\n",
+			__func__, name, MAX_FSUSB_HCR_TIME);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/**
+ * hwmod_fsusb_preprogram - place the FSUSB into UsbSuspend state
+ * @oh: struct omap_hwmod *
+ *
+ * Run a Host Controller Reset on the FSUSB.  This will place the host
+ * controller into UsbSuspend state, which will cause the FSUSB
+ * indicate that it is idle to the OMAP PRCM.  This is intended to run
+ * _after_ the OCP softreset, which can be handled via the standard
+ * function.  Passes along the return value of
+ * fsusb_reset_host_controller().
+ */
+static int __maybe_unused hwmod_fsusb_preprogram(struct omap_hwmod *oh=
)
+{
+	void __iomem *va;
+
+	va =3D omap_hwmod_get_mpu_rt_va(oh);
+	if (!va)
+		return -EINVAL;
+
+	fsusb_reset_host_controller(oh->name, va);
+
+	return 0;
+}
+
+#endif /* __LINUX_PLATFORM_DATA_FSUSB_H__ */


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
