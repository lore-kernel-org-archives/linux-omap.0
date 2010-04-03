From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH] DSPBRIDGE: Change dw_state type to u8
Date: Sat, 3 Apr 2010 18:29:20 +0530
Message-ID: <830E2177532E7946BE0E82F0F4288505044E450B97@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54377 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab0DCM71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Apr 2010 08:59:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o33CxNcD005649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 07:59:26 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o33CxM0B010634
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 18:29:22 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 147cea10f8b5ff19f4a0308f82dedc829e3d1562 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 19 Mar 2010 13:25:00 -0600
Subject: [PATCH] DSPBRIDGE: Change dw_state type to u8

The channel state can have values 0, 1 or 2. Hence changing the type to u8.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    8 ++++----
 drivers/dsp/bridge/wmd/chnl_sm.c                |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 3c6f891..cd153ed 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -135,7 +135,7 @@ struct chnl_object {
  /* Pointer back to channel manager */
  struct chnl_mgr *chnl_mgr_obj;
  u32 chnl_id;  /* Channel id */
- u32 dw_state;  /* Current channel state */
+ u8 dw_state;  /* Current channel state */
  u32 chnl_mode;  /* Chnl mode and attributes */
  /* Chnl I/O completion event (user mode) */
  bhandle user_event;
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index 0793e0d..939b783 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -49,9 +49,9 @@
 #define CHNL_MODEMASK       0x1001
 
 /* Higher level channel states: */
-#define CHNL_STATEREADY     0x0000 /* Channel ready for I/O. */
-#define CHNL_STATECANCEL    0x0001 /* I/O was cancelled. */
-#define CHNL_STATEEOS       0x0002 /* End Of Stream reached. */
+#define CHNL_STATEREADY  0 /* Channel ready for I/O. */
+#define CHNL_STATECANCEL 1 /* I/O was cancelled. */
+#define CHNL_STATEEOS  2 /* End Of Stream reached. */
 
 /* Determine if user supplied an event for this channel: */
 #define CHNL_IS_USER_EVENT(mode)  (mode & CHNL_MODEUSEREVENT)
@@ -78,7 +78,7 @@ struct chnl_info {
  /*Abstraction of I/O completion event. */
  struct sync_object *sync_event;
  u32 dw_mode;  /* Channel mode. */
- u32 dw_state;  /* Current channel state. */
+ u8 dw_state;  /* Current channel state. */
  u32 bytes_tx;  /* Total bytes transferred. */
  u32 cio_cs;  /* Number of IOCs in queue. */
  u32 cio_reqs;  /* Number of IO Requests in queue. */
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 0c14bc2..1050228 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -99,7 +99,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
  struct chnl_irp *chnl_packet_obj = NULL;
  struct wmd_dev_context *dev_ctxt;
  struct dev_object *dev_obj;
- u32 dw_state;
+ u8 dw_state;
  bool is_eos;
  struct chnl_mgr *chnl_mgr_obj = pchnl->chnl_mgr_obj;
  u8 *host_sys_buf = NULL;
-- 
1.6.0.4