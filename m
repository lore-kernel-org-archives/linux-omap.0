From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH] DSPBRIDGE: Change max channels/open channels type to u8
Date: Sat, 3 Apr 2010 18:32:09 +0530
Message-ID: <830E2177532E7946BE0E82F0F4288505044E450B99@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36764 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab0DCNCO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Apr 2010 09:02:14 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o33D2Ajo000956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 08:02:13 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o33D29XU011012
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 18:32:09 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From eb282300f2527473fa0bfbaa23a516ca8361f18a Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 19 Mar 2010 16:15:25 -0600
Subject: [PATCH] DSPBRIDGE: Change max channels/open channels type to u8

max channels can have max value of 32. So changing
max channnels and open channels type to u8

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    6 +++---
 drivers/dsp/bridge/wmd/chnl_sm.c                |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 1c64165..0084c2e 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -118,8 +118,8 @@ struct chnl_mgr {
  /* Critical section object handle */
  struct sync_csobject *hcs_obj;
  u32 word_size;  /* Size in bytes of DSP word */
- u32 max_channels; /* Total number of channels */
- u32 open_channels; /* Total number of open channels */
+ u8 max_channels; /* Total number of channels */
+ u8 open_channels; /* Total number of open channels */
  struct chnl_object **ap_channel; /* Array of channels */
  u8 dw_type;  /* Type of channel class library */
  /* If no shm syms, return for CHNL_Open */
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index ba00974..fbb05f3 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -94,14 +94,14 @@ struct chnl_mgrinfo {
  u8 dw_type;  /* Type of channel class library. */
  /* Channel handle, given the channel id. */
  struct chnl_object *chnl_obj;
- u32 open_channels; /* Number of open channels. */
- u32 max_channels; /* total # of chnls supported */
+ u8 open_channels; /* Number of open channels. */
+ u8 max_channels; /* total # of chnls supported */
 };
 
 /* Channel Manager Attrs: */
 struct chnl_mgrattrs {
  /* Max number of channels this manager can use. */
- u32 max_channels;
+ u8 max_channels;
  u32 word_size;  /* DSP Word size. */
 };
 
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 8a10eee..ebb4827 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -389,7 +389,7 @@ dsp_status bridge_chnl_create(OUT struct chnl_mgr **phChnlMgr,
 {
  dsp_status status = DSP_SOK;
  struct chnl_mgr *chnl_mgr_obj = NULL;
- s32 max_channels;
+ u8 max_channels;
 
  /* Check DBC requirements: */
  DBC_REQUIRE(phChnlMgr != NULL);
-- 
1.6.0.4