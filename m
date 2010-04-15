From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 9/13] DSPBRIDGE: Cleanup custom error code
 (CFG_E_RESOURCENOTAVAIL -> -NODATA)
Date: Fri, 16 Apr 2010 02:47:53 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FE1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757223Ab0DOVR7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:59 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLHu9s019413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:17:58 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLHuCZ011142
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:47:56 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 23669058bd3ab9c981cc6b630505f055ace0b05b Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 11:33:05 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (CFG_E_RESOURCENOTAVAIL -> -NODATA)

 This patch replaces CFG_E_RESOURCENOTAVAIL  with -ENODATA.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfg.h     |   14 +++++++-------
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/services/cfg.c              |   12 ++++++------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 635ffbc..3eb47f5 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -44,7 +44,7 @@ extern void cfg_exit(void);
  *  Returns:
  *      DSP_SOK:                Success.
  *      -EFAULT:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: Unable to retreive resource.
+ *      -ENODATA: Unable to retreive resource.
  *  Requires:
  *      CFG initialized.
  *  Ensures:
@@ -84,7 +84,7 @@ extern dsp_status cfg_get_cd_version(OUT u32 *pdwVersion);
  *      DSP_SOK:                Success.
  *      -EFAULT:  dev_node_obj is invalid.
  *      -EFAULT:   phDevObject is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
+ *      -ENODATA: The resource is not available.
  *  Requires:
  *      CFG initialized.
  *  Ensures:
@@ -104,7 +104,7 @@ extern dsp_status cfg_get_dev_object(IN struct cfg_devnode *dev_node_obj,
  *  Returns:
  *      DSP_SOK:                On success.
  *      -EFAULT:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The DSP Resource information is not
+ *      -ENODATA: The DSP Resource information is not
  *                              available
  *  Requires:
  *      CFG initialized.
@@ -127,7 +127,7 @@ extern dsp_status cfg_get_dsp_resources(IN struct cfg_devnode *dev_node_obj,
  *      DSP_SOK:                Success.
  *      -EFAULT:  dev_node_obj is invalid.
  *      -EFAULT:   pstrExecFile is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
+ *      -ENODATA: The resource is not available.
  *  Requires:
  *      CFG initialized.
  *  Ensures:
@@ -149,7 +149,7 @@ extern dsp_status cfg_get_exec_file(IN struct cfg_devnode *dev_node_obj,
  *      DSP_SOK:                On success.
  *      -EFAULT:   pHostResTable is invalid.
  *      -EFAULT:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
+ *      -ENODATA: The resource is not available.
  *  Requires:
  *      CFG initialized.
  *  Ensures:
@@ -204,7 +204,7 @@ extern void cfg_get_perf_value(OUT bool *pfEnablePerf);
  *  Returns:
  *      DSP_SOK:                On success.
  *      -EFAULT:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: The filename is not available.
+ *      -ENODATA: The filename is not available.
  *  Requires:
  *      CFG initialized.
  *  Ensures:
@@ -228,7 +228,7 @@ extern dsp_status cfg_get_wmd_file_name(IN struct cfg_devnode *dev_node_obj,
  *      DSP_SOK:                Success.
  *      -EFAULT:   pstrZLFileName is invalid.
  *      -EFAULT:  dev_node_obj is invalid.
- *      CFG_E_RESOURCENOTAVAIL: couldn't find the ZLFileName.
+ *      -ENODATA: couldn't find the ZLFileName.
  *  Requires:
  *      CFG initialized.
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 1c3da08..dec4b34 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -216,9 +216,6 @@
 /* FAILURE Codes : CFG */
 #define CFG_EBASE                   (DSP_COMP_EBASE + 0x200)
 
-/* Unable to retrieve resource information from the registry. */
-#define CFG_E_RESOURCENOTAVAIL      (CFG_EBASE + 0x02)
-
 /* Unable to find board name key in registry. */
 #define CFG_E_INVALIDBOARDNAME      (CFG_EBASE + 0x03)
 
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 747ae0e..952dc25 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -65,7 +65,7 @@ dsp_status cfg_get_auto_start(struct cfg_devnode *dev_node_obj,
 		status = reg_get_value(AUTOSTART, (u8 *) pdwAutoStart,
 				       &dw_buf_size);
 		if (DSP_FAILED(status))
-			status = CFG_E_RESOURCENOTAVAIL;
+			status = -ENODATA;
 	}
 
 	DBC_ENSURE((status == DSP_SOK &&
@@ -128,7 +128,7 @@ dsp_status cfg_get_dsp_resources(struct cfg_devnode *dev_node_obj,
 				       &dw_res_size);
 	}
 	if (DSP_FAILED(status)) {
-		status = CFG_E_RESOURCENOTAVAIL;
+		status = -ENODATA;
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	}
 	/* assert that resource values are reasonable */
@@ -160,7 +160,7 @@ dsp_status cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 ul_buf_size,
 		status =
 		    reg_get_value(DEFEXEC, (u8 *) pstrExecFile, &exec_size);
 		if (DSP_FAILED(status))
-			status = CFG_E_RESOURCENOTAVAIL;
+			status = -ENODATA;
 		else if (exec_size > ul_buf_size)
 			status = -EINVAL;
 
@@ -195,7 +195,7 @@ dsp_status cfg_get_host_resources(struct cfg_devnode *dev_node_obj,
 		if (DSP_FAILED
 		    (reg_get_value
 		     (CURRENTCONFIG, (u8 *) pHostResTable, &dw_buf_size))) {
-			status = CFG_E_RESOURCENOTAVAIL;
+			status = -ENODATA;
 		}
 	}
 	if (DSP_FAILED(status))
@@ -220,13 +220,13 @@ dsp_status cfg_get_object(OUT u32 *pdwValue, u8 dw_type)
 		status =
 		    reg_get_value(DRVOBJECT, (u8 *) pdwValue, &dw_buf_size);
 		if (DSP_FAILED(status))
-			status = CFG_E_RESOURCENOTAVAIL;
+			status = -ENODATA;
 		break;
 	case (REG_MGR_OBJECT):
 		status =
 		    reg_get_value(MGROBJECT, (u8 *) pdwValue, &dw_buf_size);
 		if (DSP_FAILED(status))
-			status = CFG_E_RESOURCENOTAVAIL;
+			status = -ENODATA;
 		break;
 	default:
 		break;
-- 
1.6.0.4

