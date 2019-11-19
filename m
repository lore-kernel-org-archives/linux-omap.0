From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 08/15] remoteproc/omap: Remove the unused fields from platform data
Date: Tue, 19 Nov 2019 16:16:38 +0200
Message-ID: <20191119141645.19777-9-t-kristo@ti.com>
References: <20191119141645.19777-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119141645.19777-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The following fields: .name, .oh_name, .oh_name_opt, .mbox_name,
.firmware, .ops and .set_bootaddr, are removed from the platform data,
as these are no longer needed after the addition of DT support to the
OMAP remoteproc driver.

The .name field was used to give a name to the remoteproc, and this
is replaced with the device name. The .ops field was never used by
the OMAP remoteproc driver. The .mbox_name was used to define the
sub-mailbox node used for communication with the remote processor,
and is retrieved using the 'mboxes' property in the DT node. The
.firmware field is encoded directly in the OMAP remoteproc driver and
is retrieved using driver match data. The .set_bootaddr ops was used
for using a OMAP Control Module API to configure the boot address for
the processor, and is now implemented within the driver using a
syscon property.

The .oh_name field is used to define the primary hwmod for the processor
node, and is represented using the 'ti,hwmods' property in the DT node.
The .oh_name_opt field was primarily defined to identify the hwmod for
the second cpu in a dual Cortex-M3/M4 IPU processor sub-system. This
hwmod entry is no longer defined usually, but rather a single hwmod
representing both the processors in the IPU sub-system is defined.
A single firmware image (either in SMP-mode or a combined image for
non-SMP mode) is used, with both the resets released together always
as part of the device management. Any power management and recovery
aspects require that both the processors be managed as one entity due
to the presence of shared MMU and unicache within the IPU sub-system.

The OMAP remoteproc platform data structure is eventually expected
to be removed completely once the other dependencies with the
mach-omap layer are met.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 include/linux/platform_data/remoteproc-omap.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
index 7e3a16097672..6bea01e199fe 100644
--- a/include/linux/platform_data/remoteproc-omap.h
+++ b/include/linux/platform_data/remoteproc-omap.h
@@ -2,38 +2,23 @@
 /*
  * Remote Processor - omap-specific bits
  *
- * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2011-2018 Texas Instruments Incorporated - http://www.ti.com/
  * Copyright (C) 2011 Google, Inc.
  */
 
 #ifndef _PLAT_REMOTEPROC_H
 #define _PLAT_REMOTEPROC_H
 
-struct rproc_ops;
 struct platform_device;
 
 /*
  * struct omap_rproc_pdata - omap remoteproc's platform data
- * @name: the remoteproc's name
- * @oh_name: omap hwmod device
- * @oh_name_opt: optional, secondary omap hwmod device
- * @firmware: name of firmware file to load
- * @mbox_name: name of omap mailbox device to use with this rproc
- * @ops: start/stop rproc handlers
  * @device_enable: omap-specific handler for enabling a device
  * @device_shutdown: omap-specific handler for shutting down a device
- * @set_bootaddr: omap-specific handler for setting the rproc boot address
  */
 struct omap_rproc_pdata {
-	const char *name;
-	const char *oh_name;
-	const char *oh_name_opt;
-	const char *firmware;
-	const char *mbox_name;
-	const struct rproc_ops *ops;
 	int (*device_enable)(struct platform_device *pdev);
 	int (*device_shutdown)(struct platform_device *pdev);
-	void (*set_bootaddr)(u32);
 };
 
 #if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
