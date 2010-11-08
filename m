From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v4 09/13] OMAP2+: DMA: hwmod: Device registration
Date: Mon,  8 Nov 2010 19:37:48 +0530
Message-ID: <1289225272-9767-10-git-send-email-manjugk@ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57473 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284Ab0KHOH5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 09:07:57 -0500
In-Reply-To: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Prepare omap2+ dma driver to use hwmod infrastructure
so that DMA driver can register as platform device.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/dma.c              |   86 ++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/include/mach/dma.h |   32 ++++++++++++
 2 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
new file mode 100644
index 0000000..30b20cd
--- /dev/null
+++ b/arch/arm/mach-omap2/dma.c
@@ -0,0 +1,86 @@
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
+ * Converted DMA library into platform driver
+ *	- G, Manjunath Kondaiah <manjugk@ti.com>
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
+static struct omap_device_pm_latency omap2_dma_latency[] =3D {
+	{
+		.deactivate_func =3D omap_device_idle_hwmods,
+		.activate_func	 =3D omap_device_enable_hwmods,
+		.flags		 =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+/* One time initializations */
+static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, voi=
d *unused)
+{
+	struct omap_device			*od;
+	struct omap_system_dma_plat_info	*p;
+	char					*name =3D "omap_system_dma";
+
+	p =3D kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
+	if (!p) {
+		pr_err("%s: Unable to allocate pdata for %s:%s\n",
+			__func__, name, oh->name);
+		return -ENOMEM;
+	}
+	od =3D omap_device_build(name, 0, oh, p, sizeof(*p),
+			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Cant build omap_device for %s:%s.\n",
+			__func__, name, oh->name);
+		kfree(p);
+		return IS_ERR(od);
+	}
+	kfree(p);
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
index 0000000..d0a7d5b
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -0,0 +1,32 @@
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
+ *  Converted DMA library into platform driver
+ *          - G, Manjunath Kondaiah <manjugk@ti.com>
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
+#endif /* __ASM_ARCH_OMAP2_DMA_H */
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
