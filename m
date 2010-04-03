From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH] DSPBRIDGE: Change dw_type to u8.
Date: Sat, 3 Apr 2010 18:31:28 +0530
Message-ID: <830E2177532E7946BE0E82F0F4288505044E450B9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36735 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab0DCNBe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Apr 2010 09:01:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o33D1Ud7000906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 08:01:33 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o33D1TwP010906
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 18:31:29 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 8bb4088a58220da7e80e5a7a4b59f12c4dd3922a Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 19 Mar 2010 15:37:56 -0600
Subject: [PATCH] DSPBRIDGE: Change dw_type to u8.

channel type can take value 1 or 2.
Hence changing the type to u8.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/cfg.h      |    4 ++--
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    2 +-
 drivers/dsp/bridge/services/cfg.c               |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 131c37c..1c64165 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -121,7 +121,7 @@ struct chnl_mgr {
  u32 max_channels; /* Total number of channels */
  u32 open_channels; /* Total number of open channels */
  struct chnl_object **ap_channel; /* Array of channels */
- u32 dw_type;  /* Type of channel class library */
+ u8 dw_type;  /* Type of channel class library */
  /* If no shm syms, return for CHNL_Open */
  dsp_status chnl_open_status;
 };
diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 80c8fde..9a9ab8e 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -175,7 +175,7 @@ extern dsp_status cfg_get_host_resources(IN struct cfg_devnode *dev_node_obj,
  *      DSP_SOK:    *pdwValue is set to the retrieved u32(non-Zero).
  *      else:       *pdwValue is set to 0L.
  */
-extern dsp_status cfg_get_object(OUT u32 *pdwValue, u32 dw_type);
+extern dsp_status cfg_get_object(OUT u32 *pdwValue, u8 dw_type);
 
 /*
  *  ======== cfg_get_perf_value ========
@@ -286,6 +286,6 @@ extern dsp_status cfg_set_dev_object(IN struct cfg_devnode *dev_node_obj,
  *  Ensures:
  *      DSP_SOK:        The Private u32 was successfully set.
  */
-extern dsp_status cfg_set_object(IN u32 dwValue, IN u32 dw_type);
+extern dsp_status cfg_set_object(IN u32 dwValue, u8 dw_type);
 
 #endif /* CFG_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index c24e78f..ba00974 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -91,7 +91,7 @@ struct chnl_info {
 
 /* Channel manager info: */
 struct chnl_mgrinfo {
- u32 dw_type;  /* Type of channel class library. */
+ u8 dw_type;  /* Type of channel class library. */
  /* Channel handle, given the channel id. */
  struct chnl_object *chnl_obj;
  u32 open_channels; /* Number of open channels. */
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index a3daad7..a878b6c 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -208,7 +208,7 @@ dsp_status cfg_get_host_resources(struct cfg_devnode *dev_node_obj,
  *  Purpose:
  *      Retrieve the Object handle from the Registry
  */
-dsp_status cfg_get_object(OUT u32 *pdwValue, u32 dw_type)
+dsp_status cfg_get_object(OUT u32 *pdwValue, u8 dw_type)
 {
  dsp_status status = DSP_EINVALIDARG;
  u32 dw_buf_size;
-- 
1.6.0.4