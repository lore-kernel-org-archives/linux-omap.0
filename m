From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 08/14] remoteproc/omap: remove the platform_data header
Date: Thu, 2 Jan 2020 15:18:39 +0200
Message-ID: <20200102131845.12992-9-t-kristo@ti.com>
References: <20200102131845.12992-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102131845.12992-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org, s-anna@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

The platform data header for OMAP remoteproc is no longer used for
anything post ti-sysc conversion, so just remove it completely.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
v4:
  - new patch, to remove the platform data file completely compared to
    patches #8 / #9 in previous version of the series

 include/linux/platform_data/remoteproc-omap.h | 51 -------------------
 1 file changed, 51 deletions(-)
 delete mode 100644 include/linux/platform_data/remoteproc-omap.h

diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
deleted file mode 100644
index 7e3a16097672..000000000000
--- a/include/linux/platform_data/remoteproc-omap.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Remote Processor - omap-specific bits
- *
- * Copyright (C) 2011 Texas Instruments, Inc.
- * Copyright (C) 2011 Google, Inc.
- */
-
-#ifndef _PLAT_REMOTEPROC_H
-#define _PLAT_REMOTEPROC_H
-
-struct rproc_ops;
-struct platform_device;
-
-/*
- * struct omap_rproc_pdata - omap remoteproc's platform data
- * @name: the remoteproc's name
- * @oh_name: omap hwmod device
- * @oh_name_opt: optional, secondary omap hwmod device
- * @firmware: name of firmware file to load
- * @mbox_name: name of omap mailbox device to use with this rproc
- * @ops: start/stop rproc handlers
- * @device_enable: omap-specific handler for enabling a device
- * @device_shutdown: omap-specific handler for shutting down a device
- * @set_bootaddr: omap-specific handler for setting the rproc boot address
- */
-struct omap_rproc_pdata {
-	const char *name;
-	const char *oh_name;
-	const char *oh_name_opt;
-	const char *firmware;
-	const char *mbox_name;
-	const struct rproc_ops *ops;
-	int (*device_enable)(struct platform_device *pdev);
-	int (*device_shutdown)(struct platform_device *pdev);
-	void (*set_bootaddr)(u32);
-};
-
-#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
-
-void __init omap_rproc_reserve_cma(void);
-
-#else
-
-static inline void __init omap_rproc_reserve_cma(void)
-{
-}
-
-#endif
-
-#endif /* _PLAT_REMOTEPROC_H */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
