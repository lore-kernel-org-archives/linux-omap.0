From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Tue, 24 Aug 2010 16:34:22 +0530
Message-ID: <1282647866-6918-8-git-send-email-manjugk@ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56916 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0HXLFu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Aug 2010 07:05:50 -0400
In-Reply-To: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch converts omap2/3/4 dma driver into platform
devices through using omap hwmod, omap device and runtime pm
frameworks.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/dma.c              |  134 ++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/include/mach/dma.h |   80 +++++++++++++++++++
 2 files changed, 214 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
new file mode 100644
index 0000000..f369bee
--- /dev/null
+++ b/arch/arm/mach-omap2/dma.c
@@ -0,0 +1,134 @@
+/*
+ * dma.c - OMAP2 specific DMA code
+ *
+ * Copyright (C) 2003 - 2008 Nokia Corporation
+ * Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.co=
m>
+ * Graphics DMA and LCD DMA graphics tranformations
+ * by Imre Deak <imre.deak@nokia.com>
+ * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
+ * Some functions based on earlier dma-omap.c Copyright (C) 2001 Ridge=
Run, Inc.
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Converted DMA library into platform driver by Manjunatha GK <manjug=
k@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/device.h>
+
+#include <plat/irqs.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+#include <plat/dma.h>
+
+#define dma_read(reg)							\
+({									\
+	u32 __val;							\
+	__val =3D __raw_readl(dma_base + OMAP_DMA4_##reg);		\
+	__val;								\
+})
+
+#define dma_write(val, reg)						\
+({									\
+	__raw_writel((val), dma_base + OMAP_DMA4_##reg);		\
+})
+
+static struct omap_dma_dev_attr *d;
+static void __iomem *dma_base;
+static struct omap_system_dma_plat_info *omap2_pdata;
+static int dma_caps0_status;
+
+static struct omap_device_pm_latency omap2_dma_latency[] =3D {
+	{
+	.deactivate_func =3D omap_device_idle_hwmods,
+	.activate_func	 =3D omap_device_enable_hwmods,
+	.flags		 =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+/* One time initializations */
+static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, voi=
d *user)
+{
+	struct omap_device *od;
+	struct omap_system_dma_plat_info *pdata;
+	struct resource *mem;
+	char *name =3D "dma";
+
+	pdata =3D kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNE=
L);
+	if (!pdata) {
+		pr_err("%s: Unable to allocate pdata for %s:%s\n",
+			__func__, name, oh->name);
+		return -ENOMEM;
+	}
+
+	pdata->dma_attr		=3D (struct omap_dma_dev_attr *)oh->dev_attr;
+
+	od =3D omap_device_build(name, 0, oh, pdata, sizeof(*pdata),
+			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Cant build omap_device for %s:%s.\n",
+			__func__, name, oh->name);
+		kfree(pdata);
+		return 0;
+	}
+
+	mem =3D platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&od->pdev.dev, "%s: no mem resource\n", __func__);
+		return -EINVAL;
+	}
+
+	dma_base =3D ioremap(mem->start, resource_size(mem));
+	if (!dma_base) {
+		dev_err(&od->pdev.dev, "%s: ioremap fail\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* Get DMA device attributes from hwmod data base */
+	d =3D (struct omap_dma_dev_attr *)oh->dev_attr;
+
+	/* OMAP2 Plus: physical and logical channel count is same */
+	d->chan_count =3D d->lch_count;
+
+	d->chan =3D kzalloc(sizeof(struct omap_dma_lch) *
+					(d->lch_count), GFP_KERNEL);
+
+	if (!d->chan) {
+		dev_err(&od->pdev.dev, "%s: kzalloc fail\n", __func__);
+		return -ENOMEM;
+	}
+
+	omap2_pdata		=3D pdata;
+	dma_caps0_status	=3D dma_read(CAPS_0);
+
+	return 0;
+}
+
+static int __init omap2_system_dma_init(void)
+{
+	int ret;
+
+	ret =3D omap_hwmod_for_each_by_class("dma",
+			omap2_system_dma_init_dev, NULL);
+
+	return ret;
+}
+arch_initcall(omap2_system_dma_init);
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-oma=
p2/include/mach/dma.h
new file mode 100644
index 0000000..3eca7d8
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -0,0 +1,80 @@
+/*
+ *  OMAP DMA controller register offsets.
+ *
+ *  Copyright (C) 2003 Nokia Corporation
+ *  Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ *
+ *  Copyright (C) 2009 Texas Instruments
+ *  Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ *  Copyright (C) 2010 Texas Instruments
+ *  Converted DMA library into platform driver by Manjunatha GK <manju=
gk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ */
+
+#ifndef __ASM_ARCH_OMAP2_DMA_H
+#define __ASM_ARCH_OMAP2_DMA_H
+
+/* OMAP2 Plus register offset's */
+#define OMAP_DMA4_REVISION		0x00
+#define OMAP_DMA4_GCR			0x78
+#define OMAP_DMA4_IRQSTATUS_L0		0x08
+#define OMAP_DMA4_IRQSTATUS_L1		0x0c
+#define OMAP_DMA4_IRQSTATUS_L2		0x10
+#define OMAP_DMA4_IRQSTATUS_L3		0x14
+#define OMAP_DMA4_IRQENABLE_L0		0x18
+#define OMAP_DMA4_IRQENABLE_L1		0x1c
+#define OMAP_DMA4_IRQENABLE_L2		0x20
+#define OMAP_DMA4_IRQENABLE_L3		0x24
+#define OMAP_DMA4_SYSSTATUS		0x28
+#define OMAP_DMA4_OCP_SYSCONFIG		0x2c
+#define OMAP_DMA4_CAPS_0		0x64
+#define OMAP_DMA4_CAPS_2		0x6c
+#define OMAP_DMA4_CAPS_3		0x70
+#define OMAP_DMA4_CAPS_4		0x74
+
+/* Should be part of hwmod data base ? */
+#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? =
*/
+
+/* Common channel specific registers for omap2 */
+#define OMAP_DMA4_CH_BASE(n)		(0x60 * (n) + 0x80)
+#define OMAP_DMA4_CCR(n)		(0x60 * (n) + 0x80)
+#define OMAP_DMA4_CLNK_CTRL(n)		(0x60 * (n) + 0x84)
+#define OMAP_DMA4_CICR(n)		(0x60 * (n) + 0x88)
+#define OMAP_DMA4_CSR(n)		(0x60 * (n) + 0x8c)
+#define OMAP_DMA4_CSDP(n)		(0x60 * (n) + 0x90)
+#define OMAP_DMA4_CEN(n)		(0x60 * (n) + 0x94)
+#define OMAP_DMA4_CFN(n)		(0x60 * (n) + 0x98)
+#define OMAP_DMA4_CSEI(n)		(0x60 * (n) + 0xa4)
+#define OMAP_DMA4_CSFI(n)		(0x60 * (n) + 0xa8)
+#define OMAP_DMA4_CDEI(n)		(0x60 * (n) + 0xac)
+#define OMAP_DMA4_CDFI(n)		(0x60 * (n) + 0xb0)
+#define OMAP_DMA4_CSAC(n)		(0x60 * (n) + 0xb4)
+#define OMAP_DMA4_CDAC(n)		(0x60 * (n) + 0xb8)
+
+/* Channel specific registers only on omap2 */
+#define OMAP_DMA4_CSSA(n)		(0x60 * (n) + 0x9c)
+#define OMAP_DMA4_CDSA(n)		(0x60 * (n) + 0xa0)
+#define OMAP_DMA4_CCEN(n)		(0x60 * (n) + 0xbc)
+#define OMAP_DMA4_CCFN(n)		(0x60 * (n) + 0xc0)
+#define OMAP_DMA4_COLOR(n)		(0x60 * (n) + 0xc4)
+
+/* Additional registers available on OMAP4 */
+#define OMAP_DMA4_CDP(n)		(0x60 * (n) + 0xd0)
+#define OMAP_DMA4_CNDP(n)		(0x60 * (n) + 0xd4)
+#define OMAP_DMA4_CCDN(n)		(0x60 * (n) + 0xd8)
+
+#endif /* __ASM_ARCH_OMAP2_DMA_H */
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
