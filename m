From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 8/9] OMAP2+: DMA: hwmod: Device registration
Date: Fri, 17 Dec 2010 21:09:47 +0530
Message-ID: <1292600388-13094-9-git-send-email-manjugk@ti.com>
References: <1292600388-13094-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51135 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab0LQPjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 10:39:03 -0500
In-Reply-To: <1292600388-13094-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, santosh.shilimkar@ti.com, b-cousson@ti.com, paul@pwsan.com

Prepare OMAP2+ DMA to use hwmod infrastructure so that DMA can register
as platform device.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/dma.c |   74 +++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dma.c

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
new file mode 100644
index 0000000..2130059
--- /dev/null
+++ b/arch/arm/mach-omap2/dma.c
@@ -0,0 +1,74 @@
+/*
+ * OMAP2+ DMA driver
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
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.c=
om/
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
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
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
+	char					*name =3D "omap_dma_system";
+
+	p =3D kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
+	if (!p) {
+		pr_err("%s: Unable to allocate pdata for %s:%s\n",
+			__func__, name, oh->name);
+		return -ENOMEM;
+	}
+
+	od =3D omap_device_build(name, 0, oh, p, sizeof(*p),
+			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
+	kfree(p);
+	if (IS_ERR(od)) {
+		pr_err("%s: Cant build omap_device for %s:%s.\n",
+			__func__, name, oh->name);
+		return IS_ERR(od);
+	}
+
+	return 0;
+}
+
+static int __init omap2_system_dma_init(void)
+{
+	return omap_hwmod_for_each_by_class("dma",
+			omap2_system_dma_init_dev, NULL);
+}
+arch_initcall(omap2_system_dma_init);
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
