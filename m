From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] omap2+: add drm device
Date: Fri, 13 Jan 2012 13:41:27 -0600
Message-ID: <1326483687-458-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:32853 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758916Ab2AMTla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 14:41:30 -0500
Received: by yenq4 with SMTP id q4so421415yen.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 11:41:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Register OMAP DRM/KMS platform device, and reserve a CMA region for
the device to use for buffer allocation.

Signed-off-by: Rob Clark <rob@ti.com>
---
 arch/arm/plat-omap/Makefile |    2 +-
 arch/arm/plat-omap/common.c |    2 +
 arch/arm/plat-omap/drm.c    |   88 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/drm.h    |   37 ++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-omap/drm.c
 create mode 100644 arch/arm/plat-omap/drm.h

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 9a58461..b86e6cb 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o \
-	 usb.o fb.o counter_32k.o
+	 usb.o fb.o counter_32k.o drm.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 06383b5..caf6082 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -24,6 +24,7 @@
 
 #include <plat/omap-secure.h>
 
+#include "drm.h"
 
 #define NO_LENGTH_CHECK 0xffffffff
 
@@ -65,6 +66,7 @@ const void *__init omap_get_var_config(u16 tag, size_t *len)
 
 void __init omap_reserve(void)
 {
+	omapdrm_reserve_vram();
 	omapfb_reserve_sdram_memblock();
 	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
diff --git a/arch/arm/plat-omap/drm.c b/arch/arm/plat-omap/drm.c
new file mode 100644
index 0000000..5d8588f
--- /dev/null
+++ b/arch/arm/plat-omap/drm.c
@@ -0,0 +1,88 @@
+/*
+ * File: arch/arm/plat-omap/drm.c
+ *
+ * DRM/KMS device registration for TI OMAP platforms
+ *
+ * Copyright (C) 2011 Texas Instruments
+ * Author: Rob Clark <rob.clark@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#ifdef CONFIG_CMA
+#  include <linux/dma-contiguous.h>
+#endif
+
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
+
+#include "drm.h"
+
+/* files from staging that contain platform data structure definitions */
+#include "../../../drivers/staging/omapdrm/omap_priv.h"
+#include "../../../drivers/staging/omapdrm/omap_dmm_tiler.h"
+
+#if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
+
+static struct omap_drm_platform_data omapdrm_platdata;
+static struct omap_dmm_platform_data dmm_platdata;
+
+static struct platform_device omap_drm_device = {
+		.dev = {
+			.coherent_dma_mask = DMA_BIT_MASK(32),
+			.platform_data = &omapdrm_platdata,
+		},
+		.name = "omapdrm",
+		.id = 0,
+};
+
+static int __init omap_init_gpu(void)
+{
+	struct omap_hwmod *oh = NULL;
+
+	/* lookup and populate the DMM information, if present - OMAP4+ */
+	oh = omap_hwmod_lookup("dmm");
+
+	if (oh) {
+		dmm_platdata.base = omap_hwmod_get_mpu_rt_va(oh);
+		dmm_platdata.irq = oh->mpu_irqs[0].irq;
+
+		if (dmm_platdata.base)
+			omapdrm_platdata.dmm_pdata = &dmm_platdata;
+	}
+
+	return platform_device_register(&omap_drm_device);
+}
+
+arch_initcall(omap_init_gpu);
+
+void omapdrm_reserve_vram(void)
+{
+#ifdef CONFIG_CMA
+	/* Create private 32MiB contiguous memory area for omapdrm.0 device
+	 * TODO revisit size.. if uc/wc buffers are allocated from CMA pages
+	 * then the amount of memory we need goes up..
+	 */
+	dma_declare_contiguous(&omap_drm_device.dev, 32*SZ_1M, 0, 0);
+#else
+#  warning "CMA is not enabled, there may be limitations about scanout buffer allocations on OMAP3 and earlier"
+#endif
+}
+
+#endif
diff --git a/arch/arm/plat-omap/drm.h b/arch/arm/plat-omap/drm.h
new file mode 100644
index 0000000..56e0c0e
--- /dev/null
+++ b/arch/arm/plat-omap/drm.h
@@ -0,0 +1,37 @@
+/*
+ * File: arch/arm/plat-omap/drm.c
+ *
+ * DRM/KMS device registration for TI OMAP platforms
+ *
+ * Copyright (C) 2011 Texas Instruments
+ * Author: Rob Clark <rob.clark@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __PLAT_OMAP_DRM_H__
+#define __PLAT_OMAP_DRM_H__
+
+#if defined(CONFIG_DRM_OMAP) || defined(CONFIG_DRM_OMAP_MODULE)
+
+void omapdrm_reserve_vram(void);
+
+#else
+
+static inline void omapdrm_reserve_vram(void)
+{
+}
+
+#endif
+
+#endif /* __PLAT_OMAP_DRM_H__ */
-- 
1.7.5.4

