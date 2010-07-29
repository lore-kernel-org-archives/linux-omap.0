From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH 06/11] OMAP1: DMA: Introduce DMA driver as platform driver
Date: Thu, 29 Jul 2010 15:29:00 +0530
Message-ID: <1280397545-27323-7-git-send-email-manjugk@ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53203 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756386Ab0G2KBD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 06:01:03 -0400
In-Reply-To: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

This patch introduces OMAP1 DMA driver as platform device
and adds support for registering through platform device
layer.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/mach-omap1/dma.c              |  234 ++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap1/include/mach/dma.h |   80 +++++++++++
 2 files changed, 314 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap1/include/mach/dma.h

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
new file mode 100644
index 0000000..0df2b82
--- /dev/null
+++ b/arch/arm/mach-omap1/dma.c
@@ -0,0 +1,234 @@
+/*
+ * dma.c - OMAP1/OMAP7xx-specific DMA code
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
+#include <plat/dma.h>
+#include <plat/tc.h>
+
+#define dma_read(reg)							\
+({									\
+	u32 __val;							\
+	__val =3D __raw_readw(dma_base + OMAP1_DMA_##reg);		\
+	__val;								\
+})
+
+#define dma_write(val, reg)						\
+({									\
+	__raw_writew((val), dma_base + OMAP1_DMA_##reg);		\
+})
+
+static struct resource res[] __initdata =3D {
+	[0] =3D {
+		.start	=3D OMAP1_DMA_BASE,
+		.end	=3D OMAP1_DMA_BASE + SZ_2K - 1,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.name   =3D "system_dma_0",
+		.start  =3D INT_DMA_CH0_6,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[2] =3D {
+		.name   =3D "system_dma_1",
+		.start  =3D INT_DMA_CH1_7,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[3] =3D {
+		.name   =3D "system_dma_2",
+		.start  =3D INT_DMA_CH2_8,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[4] =3D {
+		.name   =3D "system_dma_3",
+		.start  =3D INT_DMA_CH3,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[5] =3D {
+		.name   =3D "system_dma_4",
+		.start  =3D INT_DMA_CH4,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[6] =3D {
+		.name   =3D "system_dma_5",
+		.start  =3D INT_DMA_CH5,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[7] =3D {
+		.name   =3D "system_dma_6",
+		.start  =3D INT_DMA_LCD,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	/* irq's for omap16xx and omap7xx */
+	[8] =3D {
+		.name   =3D "system_dma_7",
+		.start  =3D 53 + IH2_BASE,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[9] =3D {
+		.name   =3D "system_dma_8",
+		.start  =3D 54 + IH2_BASE,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[10] =3D {
+		.name  =3D "system_dma_9",
+		.start =3D 55 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[11] =3D {
+		.name  =3D "system_dma_10",
+		.start =3D 56 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[12] =3D {
+		.name  =3D "system_dma_11",
+		.start =3D 57 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[13] =3D {
+		.name  =3D "system_dma_12",
+		.start =3D 58 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[14] =3D {
+		.name  =3D "system_dma_13",
+		.start =3D 59 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[15] =3D {
+		.name  =3D "system_dma_14",
+		.start =3D 60 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[16] =3D {
+		.name  =3D "system_dma_15",
+		.start =3D 61 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[17] =3D {
+		.name  =3D "system_dma_16",
+		.start =3D 62 + IH2_BASE,
+		.flags =3D IORESOURCE_IRQ,
+	},
+};
+
+static void __iomem *dma_base;
+
+static int __init omap1_system_dma_init(void)
+{
+	struct platform_device *pdev;
+	struct omap_system_dma_plat_info *pdata;
+	struct omap_dma_dev_attr *d;
+	int ret;
+
+	pdev =3D platform_device_alloc("system_dma", 0);
+	if (!pdev) {
+		pr_err("%s: Unable to device alloc for dma\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ret =3D platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret) {
+		pr_err("%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_device_put;
+	}
+
+	pdata =3D kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNE=
L);
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: Unable to allocate pdata for %s\n",
+			__func__, pdev->name);
+		ret =3D -ENOMEM;
+		goto exit_device_put;
+	}
+
+	d =3D pdata->dma_attr;
+
+	/* Valid attributes for omap1 plus processors */
+	d->dma_dev_attr =3D 0;
+
+	if (cpu_is_omap15xx())
+		d->dma_dev_attr =3D ENABLE_1510_MODE;
+
+	d->dma_dev_attr			|=3D SRC_PORT;
+	d->dma_dev_attr			|=3D DST_PORT;
+	d->dma_dev_attr			|=3D SRC_INDEX;
+	d->dma_dev_attr			|=3D DST_INDEX;
+	d->dma_dev_attr			|=3D IS_BURST_ONLY4;
+	d->dma_dev_attr			|=3D CLEAR_CSR_ON_READ;
+	d->dma_dev_attr			|=3D IS_WORD_16;
+
+	d->dma_lch_count		=3D OMAP1_LOGICAL_DMA_CH_COUNT;
+
+	if (cpu_is_omap15xx())
+		d->dma_chan_count =3D 9;
+	else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
+		if (!(d->dma_dev_attr & ENABLE_1510_MODE))
+			d->dma_chan_count =3D 16;
+		else
+			d->dma_chan_count =3D 9;
+	}
+
+	pdata->omap_dma_base		=3D (void __iomem *)res[0].start;
+	dma_base			=3D pdata->omap_dma_base;
+
+	d->dma_chan =3D kzalloc(sizeof(struct omap_dma_lch) *
+					(d->dma_lch_count), GFP_KERNEL);
+
+	if (!d->dma_chan) {
+		dev_err(&pdev->dev, "%s: Memory allcation failed"
+					"for dma_chan!!!\n", __func__);
+		goto exit_release_pdata;
+	}
+
+	ret =3D platform_device_add_data(pdev, pdata, sizeof(*pdata));
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_release_dma_chan;
+	}
+	ret =3D platform_device_add(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_release_dma_chan;
+	}
+
+exit_release_dma_chan:
+	kfree(d->dma_chan);
+exit_release_pdata:
+	kfree(pdata);
+exit_device_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+arch_initcall(omap1_system_dma_init);
diff --git a/arch/arm/mach-omap1/include/mach/dma.h b/arch/arm/mach-oma=
p1/include/mach/dma.h
new file mode 100644
index 0000000..d446cdd
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/dma.h
@@ -0,0 +1,80 @@
+/*
+ *  OMAP DMA controller register offsets.
+ *
+ *  Copyright (C) 2003 Nokia Corporation
+ *  Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
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
+#ifndef __ASM_ARCH_OMAP1_DMA_H
+#define __ASM_ARCH_OMAP1_DMA_H
+/* Hardware registers for omap1 */
+#define OMAP1_DMA_BASE			(0xfffed800)
+
+#define OMAP1_DMA_GCR			0x400
+#define OMAP1_DMA_GSCR			0x404
+#define OMAP1_DMA_GRST			0x408
+#define OMAP1_DMA_HW_ID			0x442
+#define OMAP1_DMA_PCH2_ID		0x444
+#define OMAP1_DMA_PCH0_ID		0x446
+#define OMAP1_DMA_PCH1_ID		0x448
+#define OMAP1_DMA_PCHG_ID		0x44a
+#define OMAP1_DMA_PCHD_ID		0x44c
+#define OMAP1_DMA_CAPS_0_U		0x44e
+#define OMAP1_DMA_CAPS_0_L		0x450
+#define OMAP1_DMA_CAPS_1_U		0x452
+#define OMAP1_DMA_CAPS_1_L		0x454
+#define OMAP1_DMA_CAPS_2		0x456
+#define OMAP1_DMA_CAPS_3		0x458
+#define OMAP1_DMA_CAPS_4		0x45a
+#define OMAP1_DMA_PCH2_SR		0x460
+#define OMAP1_DMA_PCH0_SR		0x480
+#define OMAP1_DMA_PCH1_SR		0x482
+#define OMAP1_DMA_PCHD_SR		0x4c0
+
+#define OMAP1_LOGICAL_DMA_CH_COUNT	17
+
+/* Common channel specific registers for omap1 */
+#define OMAP1_DMA_CH_BASE(n)		(0x40 * (n) + 0x00)
+#define OMAP1_DMA_CSDP(n)		(0x40 * (n) + 0x00)
+#define OMAP1_DMA_CCR(n)		(0x40 * (n) + 0x02)
+#define OMAP1_DMA_CICR(n)		(0x40 * (n) + 0x04)
+#define OMAP1_DMA_CSR(n)		(0x40 * (n) + 0x06)
+#define OMAP1_DMA_CEN(n)		(0x40 * (n) + 0x10)
+#define OMAP1_DMA_CFN(n)		(0x40 * (n) + 0x12)
+#define OMAP1_DMA_CSFI(n)		(0x40 * (n) + 0x14)
+#define OMAP1_DMA_CSEI(n)		(0x40 * (n) + 0x16)
+#define OMAP1_DMA_CPC(n)		(0x40 * (n) + 0x18)	/* 15xx only */
+#define OMAP1_DMA_CSAC(n)		(0x40 * (n) + 0x18)
+#define OMAP1_DMA_CDAC(n)		(0x40 * (n) + 0x1a)
+#define OMAP1_DMA_CDEI(n)		(0x40 * (n) + 0x1c)
+#define OMAP1_DMA_CDFI(n)		(0x40 * (n) + 0x1e)
+#define OMAP1_DMA_CLNK_CTRL(n)		(0x40 * (n) + 0x28)
+
+/* Channel specific registers only on omap1 */
+#define OMAP1_DMA_CSSA_L(n)		(0x40 * (n) + 0x08)
+#define OMAP1_DMA_CSSA_U(n)		(0x40 * (n) + 0x0a)
+#define OMAP1_DMA_CDSA_L(n)		(0x40 * (n) + 0x0c)
+#define OMAP1_DMA_CDSA_U(n)		(0x40 * (n) + 0x0e)
+#define OMAP1_DMA_COLOR_L(n)		(0x40 * (n) + 0x20)
+#define OMAP1_DMA_COLOR_U(n)		(0x40 * (n) + 0x22)
+#define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
+#define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)
+
+#endif /* __ASM_ARCH_OMAP1_DMA_H */
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
