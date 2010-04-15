From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 8/13] DSPBRIDGE: Cleanup custom error code
 (CFG_E_INVALIDHDEVNODE -> -EFAULT)
Date: Fri, 16 Apr 2010 02:47:45 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FDF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51965 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757222Ab0DOVRv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:51 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLHmNj008740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:17:50 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLHmxR011113
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:47:48 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 1daa5435abd871e8451c93fbd1d2de136566ac7e Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 11:28:53 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (CFG_E_INVALIDHDEVNODE -> -EFAULT)

This patch replaces CFG_E_INVALIDHDEVNODE with -EFAULT.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfg.h     |   16 ++++++++--------
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/services/cfg.c              |   14 +++++++-------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index faeb87c..635ffbc 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -43,7 +43,7 @@ extern void cfg_exit(void);
  *      pdwAutoStart:   Ptr to location for 32 bit autostart mask.
  *  Returns:
  *      DSP_SOK:                Success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      CFG_E_RESOURCENOTAVAIL: Unable to retreive resource.
  *  Requires:
  *      CFG initialized.
@@ -82,7 +82,7 @@ extern dsp_status cfg_get_cd_version(OUT u32 *pdwVersion);
  *      pdwValue:       Ptr to location to store the value.
  *  Returns:
  *      DSP_SOK:                Success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      -EFAULT:   phDevObject is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
  *  Requires:
@@ -103,7 +103,7 @@ extern dsp_status cfg_get_dev_object(IN struct cfg_devnode *dev_node_obj,
  *      pDSPResTable:   Ptr to a location to store the DSP resource table.
  *  Returns:
  *      DSP_SOK:                On success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The DSP Resource information is not
  *                              available
  *  Requires:
@@ -125,7 +125,7 @@ extern dsp_status cfg_get_dsp_resources(IN struct cfg_devnode *dev_node_obj,
  *      pstrExecFile:   Ptr to character buf to hold ExecFile.
  *  Returns:
  *      DSP_SOK:                Success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      -EFAULT:   pstrExecFile is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
  *  Requires:
@@ -148,7 +148,7 @@ extern dsp_status cfg_get_exec_file(IN struct cfg_devnode *dev_node_obj,
  *  Returns:
  *      DSP_SOK:                On success.
  *      -EFAULT:   pHostResTable is invalid.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
  *  Requires:
  *      CFG initialized.
@@ -203,7 +203,7 @@ extern void cfg_get_perf_value(OUT bool *pfEnablePerf);
  *      pWMDFileName:   Ptr to a character buffer to hold the WMD filename.
  *  Returns:
  *      DSP_SOK:                On success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The filename is not available.
  *  Requires:
  *      CFG initialized.
@@ -227,7 +227,7 @@ extern dsp_status cfg_get_wmd_file_name(IN struct cfg_devnode *dev_node_obj,
  *  Returns:
  *      DSP_SOK:                Success.
  *      -EFAULT:   pstrZLFileName is invalid.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      CFG_E_RESOURCENOTAVAIL: couldn't find the ZLFileName.
  *  Requires:
  *      CFG initialized.
@@ -261,7 +261,7 @@ extern bool cfg_init(void);
  *      dwValue:    Arbitrary value to store.
  *  Returns:
  *      DSP_SOK:                Success.
- *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
+ *      -EFAULT:  dev_node_obj is invalid.
  *      DSP_EFAIL:              Internal Error.
  *  Requires:
  *      CFG initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 660deb6..1c3da08 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -216,9 +216,6 @@
 /* FAILURE Codes : CFG */
 #define CFG_EBASE                   (DSP_COMP_EBASE + 0x200)
 
-/* Invalid device node handle passed into a configuration module function. */
-#define CFG_E_INVALIDHDEVNODE       (CFG_EBASE + 0x01)
-
 /* Unable to retrieve resource information from the registry. */
 #define CFG_E_RESOURCENOTAVAIL      (CFG_EBASE + 0x02)
 
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index ad02875..747ae0e 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -58,7 +58,7 @@ dsp_status cfg_get_auto_start(struct cfg_devnode *dev_node_obj,
 
 	dw_buf_size = sizeof(*pdwAutoStart);
 	if (!dev_node_obj)
-		status = CFG_E_INVALIDHDEVNODE;
+		status = -EFAULT;
 	if (!pdwAutoStart)
 		status = -EFAULT;
 	if (DSP_SUCCEEDED(status)) {
@@ -86,10 +86,10 @@ dsp_status cfg_get_dev_object(struct cfg_devnode *dev_node_obj,
 	u32 dw_buf_size;
 
 	if (!dev_node_obj)
-		status = CFG_E_INVALIDHDEVNODE;
+		status = -EFAULT;
 
 	if (!pdwValue)
-		status = CFG_E_INVALIDHDEVNODE;
+		status = -EFAULT;
 
 	dw_buf_size = sizeof(pdwValue);
 	if (DSP_SUCCEEDED(status)) {
@@ -120,7 +120,7 @@ dsp_status cfg_get_dsp_resources(struct cfg_devnode *dev_node_obj,
 	u32 dw_res_size;
 
 	if (!dev_node_obj) {
-		status = CFG_E_INVALIDHDEVNODE;
+		status = -EFAULT;
 	} else if (!pDSPResTable) {
 		status = -EFAULT;
 	} else {
@@ -152,7 +152,7 @@ dsp_status cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 ul_buf_size,
 	u32 exec_size = ul_buf_size;
 
 	if (!dev_node_obj)
-		status = CFG_E_INVALIDHDEVNODE;
+		status = -EFAULT;
 	else if (!pstrExecFile)
 		status = -EFAULT;
 
@@ -185,7 +185,7 @@ dsp_status cfg_get_host_resources(struct cfg_devnode *dev_node_obj,
 	u32 dw_buf_size;
 
 	if (!dev_node_obj)
-		status = CFG_E_INVALIDHDEVNODE;
+		status = -EFAULT;
 
 	if (!pHostResTable)
 		status = -EFAULT;
@@ -274,7 +274,7 @@ dsp_status cfg_set_dev_object(struct cfg_devnode *dev_node_obj, u32 dwValue)
 	u32 dw_buff_size;
 
 	if (!dev_node_obj)
-		status = CFG_E_INVALIDHDEVNODE;
+		status = -EFAULT;
 
 	dw_buff_size = sizeof(dwValue);
 	if (DSP_SUCCEEDED(status)) {
-- 
1.6.0.4

