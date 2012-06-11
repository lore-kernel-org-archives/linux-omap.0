From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 07/12] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
Date: Sun, 10 Jun 2012 18:46:14 -0600
Message-ID: <20120611004611.20034.60143.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42576 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab2FKAwL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:11 -0400
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?b?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Enable the AESS auto-gating control bit during AESS hwmod setup.  This
fixes the following boot warning on OMAP4:

omap_hwmod: aess: _wait_target_disable failed

Without this patch, the AESS IP block does not indicate to the PRCM
that it is idle after it is reset.  This prevents some types of SoC
power management until something sets the auto-gating control bit.

This second version of this patch moves the control functions to
include/linux/platform_data/aess.h at Tony's request:

    http://www.spinics.net/lists/arm-kernel/msg178329.html

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +
 include/linux/platform_data/aess.h         |   76 ++++++++++++++++++++=
++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 include/linux/platform_data/aess.h

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 6b0aedc..7700d6d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -20,6 +20,8 @@
=20
 #include <linux/io.h>
=20
+#include <linux/platform_data/aess.h>
+
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 #include <plat/i2c.h>
@@ -313,6 +315,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_a=
ess_sysc =3D {
 static struct omap_hwmod_class omap44xx_aess_hwmod_class =3D {
 	.name	=3D "aess",
 	.sysc	=3D &omap44xx_aess_sysc,
+	.setup_preprogram =3D hwmod_aess_preprogram,
 };
=20
 /* aess */
diff --git a/include/linux/platform_data/aess.h b/include/linux/platfor=
m_data/aess.h
new file mode 100644
index 0000000..1e0d71b
--- /dev/null
+++ b/include/linux/platform_data/aess.h
@@ -0,0 +1,76 @@
+/*
+ * AESS IP block integration
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
+#ifndef __LINUX_PLATFORM_DATA_AESS_H__
+#define __LINUX_PLATFORM_DATA_AESS_H__
+
+#include <linux/kernel.h>
+
+#include <plat/omap_hwmod.h>
+
+/*
+ * AESS_AUTO_GATING_ENABLE_OFFSET: offset in bytes of the AESS IP
+ *     block's AESS_AUTO_GATING_ENABLE__1 register from the IP block's
+ *     base address
+ */
+#define AESS_AUTO_GATING_ENABLE_OFFSET			0x07c
+
+/* Register bitfields in the AESS_AUTO_GATING_ENABLE__1 register */
+#define AESS_AUTO_GATING_ENABLE_SHIFT			0
+
+/**
+ * aess_enable_autogating - enable AESS internal autogating
+ * @oh: struct omap_hwmod *
+ *
+ * Enable internal autogating on the AESS.  This allows the AESS to
+ * indicate that it is idle to the OMAP PRCM.  Returns 0.
+ */
+static void aess_enable_autogating(void __iomem *base)
+{
+	u32 v;
+
+	/* Set AESS_AUTO_GATING_ENABLE__1.ENABLE to allow idle entry */
+	v =3D 1 << AESS_AUTO_GATING_ENABLE_SHIFT;
+	writel(v, base + AESS_AUTO_GATING_ENABLE_OFFSET);
+}
+
+/**
+ * hwmod_aess_preprogram - enable AESS internal autogating (called by =
hwmod)
+ * @oh: struct omap_hwmod *
+ *
+ * The AESS will not IdleAck to the PRCM until its internal autogating
+ * is enabled.  Since internal autogating is disabled by default after
+ * AESS reset, we must enable autogating after the hwmod code resets
+ * the AESS.  Returns 0.
+ */
+static int __maybe_unused hwmod_aess_preprogram(struct omap_hwmod *oh)
+{
+	void __iomem *va;
+
+	va =3D omap_hwmod_get_mpu_rt_va(oh);
+	if (!va)
+		return -EINVAL;
+
+	aess_enable_autogating(va);
+
+	return 0;
+}
+
+#endif /* __LINUX_PLATFORM_DATA_AESS_H__ */


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
