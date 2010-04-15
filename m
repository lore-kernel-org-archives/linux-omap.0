From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 7/13] DSPBRIDGE: Cleanup custom error code
 (CFG_E_INVALIDPOINTER -> -EFAULT)
Date: Fri, 16 Apr 2010 02:47:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FDE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55901 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757219Ab0DOVRc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:32 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLHT62019370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:17:31 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLHTRT011087
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:47:29 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From d7646f5d1aff38453705586e256bc12a2cfd289a Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 11:23:35 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (CFG_E_INVALIDPOINTER -> -EFAULT)

This patch replaces CFG_E_INVALIDPOINTER with -EFAULT.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfg.h     |    8 ++++----
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/services/cfg.c              |    8 ++++----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 9a9ab8e..faeb87c 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -83,7 +83,7 @@ extern dsp_status cfg_get_cd_version(OUT u32 *pdwVersion);
  *  Returns:
  *      DSP_SOK:                Success.
  *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
- *      CFG_E_INVALIDPOINTER:   phDevObject is invalid.
+ *      -EFAULT:   phDevObject is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
  *  Requires:
  *      CFG initialized.
@@ -126,7 +126,7 @@ extern dsp_status cfg_get_dsp_resources(IN struct cfg_devnode *dev_node_obj,
  *  Returns:
  *      DSP_SOK:                Success.
  *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
- *      CFG_E_INVALIDPOINTER:   pstrExecFile is invalid.
+ *      -EFAULT:   pstrExecFile is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
  *  Requires:
  *      CFG initialized.
@@ -147,7 +147,7 @@ extern dsp_status cfg_get_exec_file(IN struct cfg_devnode *dev_node_obj,
  *      pHostResTable:  Ptr to a location to store the host resource table.
  *  Returns:
  *      DSP_SOK:                On success.
- *      CFG_E_INVALIDPOINTER:   pHostResTable is invalid.
+ *      -EFAULT:   pHostResTable is invalid.
  *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
  *      CFG_E_RESOURCENOTAVAIL: The resource is not available.
  *  Requires:
@@ -226,7 +226,7 @@ extern dsp_status cfg_get_wmd_file_name(IN struct cfg_devnode *dev_node_obj,
  *      pstrZLFileName: Ptr to character buf to hold ZLFileName.
  *  Returns:
  *      DSP_SOK:                Success.
- *      CFG_E_INVALIDPOINTER:   pstrZLFileName is invalid.
+ *      -EFAULT:   pstrZLFileName is invalid.
  *      CFG_E_INVALIDHDEVNODE:  dev_node_obj is invalid.
  *      CFG_E_RESOURCENOTAVAIL: couldn't find the ZLFileName.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 06c6030..660deb6 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -216,9 +216,6 @@
 /* FAILURE Codes : CFG */
 #define CFG_EBASE                   (DSP_COMP_EBASE + 0x200)
 
-/* Invalid pointer passed into a configuration module function */
-#define CFG_E_INVALIDPOINTER        (CFG_EBASE + 0x00)
-
 /* Invalid device node handle passed into a configuration module function. */
 #define CFG_E_INVALIDHDEVNODE       (CFG_EBASE + 0x01)
 
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 36f1a7b..ad02875 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -60,7 +60,7 @@ dsp_status cfg_get_auto_start(struct cfg_devnode *dev_node_obj,
 	if (!dev_node_obj)
 		status = CFG_E_INVALIDHDEVNODE;
 	if (!pdwAutoStart)
-		status = CFG_E_INVALIDPOINTER;
+		status = -EFAULT;
 	if (DSP_SUCCEEDED(status)) {
 		status = reg_get_value(AUTOSTART, (u8 *) pdwAutoStart,
 				       &dw_buf_size);
@@ -122,7 +122,7 @@ dsp_status cfg_get_dsp_resources(struct cfg_devnode *dev_node_obj,
 	if (!dev_node_obj) {
 		status = CFG_E_INVALIDHDEVNODE;
 	} else if (!pDSPResTable) {
-		status = CFG_E_INVALIDPOINTER;
+		status = -EFAULT;
 	} else {
 		status = reg_get_value(DSPRESOURCES, (u8 *) pDSPResTable,
 				       &dw_res_size);
@@ -154,7 +154,7 @@ dsp_status cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 ul_buf_size,
 	if (!dev_node_obj)
 		status = CFG_E_INVALIDHDEVNODE;
 	else if (!pstrExecFile)
-		status = CFG_E_INVALIDPOINTER;
+		status = -EFAULT;
 
 	if (DSP_SUCCEEDED(status)) {
 		status =
@@ -188,7 +188,7 @@ dsp_status cfg_get_host_resources(struct cfg_devnode *dev_node_obj,
 		status = CFG_E_INVALIDHDEVNODE;
 
 	if (!pHostResTable)
-		status = CFG_E_INVALIDPOINTER;
+		status = -EFAULT;
 
 	if (DSP_SUCCEEDED(status)) {
 		dw_buf_size = sizeof(struct cfg_hostres);
-- 
1.6.0.4

