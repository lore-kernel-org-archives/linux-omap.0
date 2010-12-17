From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 7/9] OMAP1: DMA: Implement in platform device model
Date: Fri, 17 Dec 2010 21:09:46 +0530
Message-ID: <1292600388-13094-8-git-send-email-manjugk@ti.com>
References: <1292600388-13094-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32829 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076Ab0LQPi6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 10:38:58 -0500
In-Reply-To: <1292600388-13094-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, santosh.shilimkar@ti.com, b-cousson@ti.com, paul@pwsan.com

Implement OMAP1 DMA as platform device and add support for
registering through platform device layer using resource
structures.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap1/dma.c |  179 +++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
new file mode 100644
index 0000000..120eff7
--- /dev/null
+++ b/arch/arm/mach-omap1/dma.c
@@ -0,0 +1,179 @@
+/*
+ * OMAP1/OMAP7xx - specific DMA driver
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
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.c=
om/
+ * Converted DMA library into platform driver
+ *                   - G, Manjunath Kondaiah <manjugk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
+#include <plat/dma.h>
+#include <plat/tc.h>
+#include <plat/irqs.h>
+
+#define OMAP1_DMA_BASE			(0xfffed800)
+
+static struct resource res[] __initdata =3D {
+	[0] =3D {
+		.start	=3D OMAP1_DMA_BASE,
+		.end	=3D OMAP1_DMA_BASE + SZ_2K - 1,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.name   =3D "0",
+		.start  =3D INT_DMA_CH0_6,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[2] =3D {
+		.name   =3D "1",
+		.start  =3D INT_DMA_CH1_7,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[3] =3D {
+		.name   =3D "2",
+		.start  =3D INT_DMA_CH2_8,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[4] =3D {
+		.name   =3D "3",
+		.start  =3D INT_DMA_CH3,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[5] =3D {
+		.name   =3D "4",
+		.start  =3D INT_DMA_CH4,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[6] =3D {
+		.name   =3D "5",
+		.start  =3D INT_DMA_CH5,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[7] =3D {
+		.name   =3D "6",
+		.start  =3D INT_1610_DMA_CH6,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	/* irq's for omap16xx and omap7xx */
+	[8] =3D {
+		.name   =3D "7",
+		.start  =3D INT_1610_DMA_CH7,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[9] =3D {
+		.name   =3D "8",
+		.start  =3D INT_1610_DMA_CH8,
+		.flags  =3D IORESOURCE_IRQ,
+	},
+	[10] =3D {
+		.name  =3D "9",
+		.start =3D INT_1610_DMA_CH9,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[11] =3D {
+		.name  =3D "10",
+		.start =3D INT_1610_DMA_CH10,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[12] =3D {
+		.name  =3D "11",
+		.start =3D INT_1610_DMA_CH11,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[13] =3D {
+		.name  =3D "12",
+		.start =3D INT_1610_DMA_CH12,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[14] =3D {
+		.name  =3D "13",
+		.start =3D INT_1610_DMA_CH13,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[15] =3D {
+		.name  =3D "14",
+		.start =3D INT_1610_DMA_CH14,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[16] =3D {
+		.name  =3D "15",
+		.start =3D INT_1610_DMA_CH15,
+		.flags =3D IORESOURCE_IRQ,
+	},
+	[17] =3D {
+		.name  =3D "16",
+		.start =3D INT_DMA_LCD,
+		.flags =3D IORESOURCE_IRQ,
+	},
+};
+
+static int __init omap1_system_dma_init(void)
+{
+	struct omap_system_dma_plat_info	*p;
+	struct platform_device			*pdev;
+	int ret;
+
+	pdev =3D platform_device_alloc("omap_dma_system", 0);
+	if (!pdev) {
+		pr_err("%s: Unable to device alloc for dma\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ret =3D platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_device_del;
+	}
+
+	p =3D kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
+	if (!p) {
+		dev_err(&pdev->dev, "%s: Unable to allocate 'p' for %s\n",
+			__func__, pdev->name);
+		ret =3D -ENOMEM;
+		goto exit_device_put;
+	}
+
+	ret =3D platform_device_add_data(pdev, p, sizeof(*p));
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_device_put;
+	}
+
+	ret =3D platform_device_add(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_device_put;
+	}
+
+	return ret;
+
+exit_device_put:
+	platform_device_put(pdev);
+exit_device_del:
+	platform_device_del(pdev);
+
+	return ret;
+}
+arch_initcall(omap1_system_dma_init);
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
