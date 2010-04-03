From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [PATCH] DSPBRIDGE: Change channel mode type to u8
Date: Sat, 3 Apr 2010 18:29:55 +0530
Message-ID: <830E2177532E7946BE0E82F0F4288505044E450B98@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43951 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638Ab0DCNAB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Apr 2010 09:00:01 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o33Cxvtm004163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 08:00:00 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o33CxuQ8010668
	for <linux-omap@vger.kernel.org>; Sat, 3 Apr 2010 18:29:56 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 4723494935d2188ef014297a5bed66fecb3901ad Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 19 Mar 2010 15:12:03 -0600
Subject: [PATCH] DSPBRIDGE: Change channel mode type to u8

chnl_mode or dw_mode can have value 0 or 1.
Hence changing the type to u8.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/chnldefs.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmdchnl.h  |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                  |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c                |    8 ++++----
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index cd153ed..131c37c 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -136,7 +136,7 @@ struct chnl_object {
  struct chnl_mgr *chnl_mgr_obj;
  u32 chnl_id;  /* Channel id */
  u8 dw_state;  /* Current channel state */
- u32 chnl_mode;  /* Chnl mode and attributes */
+ u8 chnl_mode;  /* Chnl mode and attributes */
  /* Chnl I/O completion event (user mode) */
  bhandle user_event;
  /* Abstract syncronization object */
diff --git a/arch/arm/plat-omap/include/dspbridge/chnldefs.h b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
index a12870e..66fb660 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
@@ -26,8 +26,8 @@
 #define CHNL_INITIOREQS      4 /* Default # of I/O requests. */
 
 /* Channel modes */
-#define CHNL_MODETODSP       0x0000 /* Data streaming to the DSP. */
-#define CHNL_MODEFROMDSP     0x0001 /* Data streaming from the DSP. */
+#define CHNL_MODETODSP  0 /* Data streaming to the DSP. */
+#define CHNL_MODEFROMDSP 1 /* Data streaming from the DSP. */
 
 /* GetIOCompletion flags */
 #define CHNL_IOCINFINITE     0xffffffff /* Wait forever for IO completion. */
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index 939b783..c24e78f 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -77,7 +77,7 @@ struct chnl_info {
  bhandle event_obj; /* Channel I/O completion event. */
  /*Abstraction of I/O completion event. */
  struct sync_object *sync_event;
- u32 dw_mode;  /* Channel mode. */
+ u8 dw_mode;  /* Channel mode. */
  u8 dw_state;  /* Current channel state. */
  u32 bytes_tx;  /* Total bytes transferred. */
  u32 cio_cs;  /* Number of IOCs in queue. */
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index f9883db..a798ec9 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -409,7 +409,7 @@ typedef void (*fxn_deh_notify) (struct deh_mgr *hdeh_mgr,
 typedef dsp_status(*fxn_chnl_open) (OUT struct chnl_object
         **phChnl,
         struct chnl_mgr *hchnl_mgr,
-        short int chnl_mode,
+     u8 chnl_mode,
         u32 uChnlId,
         CONST IN OPTIONAL struct
         chnl_attr * pattrs);
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdchnl.h b/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
index 0d874ab..193db25 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdchnl.h
@@ -33,7 +33,7 @@ extern dsp_status bridge_chnl_destroy(struct chnl_mgr *hchnl_mgr);
 
 extern dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
        struct chnl_mgr *hchnl_mgr,
-       short int chnl_mode,
+     u8 chnl_mode,
        u32 uChnlId,
        CONST IN OPTIONAL struct chnl_attr
        *pattrs);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index a761eb0..c18539d 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -845,7 +845,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
  struct stream_chnl *pstream;
  gb_bit_num pipe_id = GB_NOBITS;
  gb_bit_num chnl_id = GB_NOBITS;
- short int chnl_mode;
+ u8 chnl_mode;
  u32 dw_length;
  dsp_status status = DSP_SOK;
  DBC_REQUIRE(refs > 0);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index ed62925..113b9bd 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -483,7 +483,7 @@ dsp_status strm_open(struct node_object *hnode, u32 dir, u32 index,
  struct bridge_drv_interface *intf_fxns;
  u32 ul_chnl_id;
  struct strm_object *strm_obj = NULL;
- short int chnl_mode;
+ u8 chnl_mode;
  struct chnl_attr chnl_attr_obj;
  dsp_status status = DSP_SOK;
  struct cmm_object *hcmm_mgr = NULL; /* Shared memory manager hndl */
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 1050228..0ee2fe7 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -257,7 +257,7 @@ dsp_status bridge_chnl_cancel_io(struct chnl_object *chnl_obj)
  dsp_status status = DSP_SOK;
  struct chnl_object *pchnl = (struct chnl_object *)chnl_obj;
  u32 chnl_id = -1;
- short int chnl_mode;
+ u8 chnl_mode;
  struct chnl_irp *chnl_packet_obj;
  struct chnl_mgr *chnl_mgr_obj = NULL;
 
@@ -492,7 +492,7 @@ dsp_status bridge_chnl_flush_io(struct chnl_object *chnl_obj, u32 dwTimeOut)
 {
  dsp_status status = DSP_SOK;
  struct chnl_object *pchnl = (struct chnl_object *)chnl_obj;
- short int chnl_mode = -1;
+ u8 chnl_mode;
  struct chnl_mgr *chnl_mgr_obj;
  struct chnl_ioc chnl_ioc_obj;
  /* Check args: */
@@ -758,7 +758,7 @@ dsp_status bridge_chnl_get_mgr_info(struct chnl_mgr *hchnl_mgr, u32 uChnlID,
 dsp_status bridge_chnl_idle(struct chnl_object *chnl_obj, u32 dwTimeOut,
        bool fFlush)
 {
- short int chnl_mode;
+ u8 chnl_mode;
  struct chnl_mgr *chnl_mgr_obj;
  dsp_status status = DSP_SOK;
 
@@ -786,7 +786,7 @@ dsp_status bridge_chnl_idle(struct chnl_object *chnl_obj, u32 dwTimeOut,
  *      Open a new half-duplex channel to the DSP board.
  */
 dsp_status bridge_chnl_open(OUT struct chnl_object **phChnl,
-       struct chnl_mgr *hchnl_mgr, short int chnl_mode,
+       struct chnl_mgr *hchnl_mgr, u8 chnl_mode,
        u32 uChnlId, CONST IN struct chnl_attr *pattrs)
 {
  dsp_status status = DSP_SOK;
-- 
1.6.0.4