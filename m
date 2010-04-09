From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 13/13] DSPBRIDGE: Remove signature definitions used for
 object validation
Date: Thu, 8 Apr 2010 19:13:04 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548E64D158@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59991 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933876Ab0DIAN0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:13:26 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From a848b2a9b48c020a3928e8f334632662a2213b43 Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Mon, 29 Mar 2010 19:48:20 -0600
Subject: [PATCH 13/13] DSPBRIDGE: Remove signature definitions used for object validation

Since the patch "DSPBRIDGE: Remove dw_signature field from structures"
removed dw_signature field from structures, then its signature
definitions are no longer used.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    4 ----
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    2 --
 arch/arm/plat-omap/include/dspbridge/msgdefs.h  |    2 --
 drivers/dsp/bridge/pmgr/cmm.c                   |    5 -----
 drivers/dsp/bridge/pmgr/dbll.c                  |    3 ---
 drivers/dsp/bridge/pmgr/dev.c                   |    1 -
 drivers/dsp/bridge/pmgr/dmm.c                   |    3 ---
 drivers/dsp/bridge/rmgr/dbdcd.c                 |    2 --
 drivers/dsp/bridge/rmgr/disp.c                  |    2 --
 drivers/dsp/bridge/rmgr/drv.c                   |    2 --
 drivers/dsp/bridge/rmgr/mgr.c                   |    1 -
 drivers/dsp/bridge/rmgr/nldr.c                  |    3 ---
 drivers/dsp/bridge/rmgr/node.c                  |    3 ---
 drivers/dsp/bridge/rmgr/proc.c                  |    1 -
 drivers/dsp/bridge/rmgr/rmm.c                   |    2 --
 drivers/dsp/bridge/rmgr/strm.c                  |    3 ---
 drivers/dsp/bridge/wmd/_deh.h                   |    2 --
 drivers/dsp/bridge/wmd/msg_sm.c                 |    3 ---
 18 files changed, 0 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index 9fe7a74..d650823 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -23,10 +23,6 @@
 #include <dspbridge/devdefs.h>
 #include <dspbridge/sync.h>
 
-/* CHNL Object validation signatures: */
-#define CHNL_MGRSIGNATURE   0x52474D43	/* "CMGR" (in reverse). */
-#define CHNL_SIGNATURE      0x4C4E4843	/* "CHNL" (in reverse). */
-
 /* Channel manager limits: */
 #define CHNL_MAXCHANNELS    32	/* Max channels available per transport */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index aa4d0cf..bebf011 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -30,8 +30,6 @@
 #define IO_SERVICE          2
 #define IO_MAXSERVICE       IO_SERVICE
 
-#define IO_MGRSIGNATURE     0x494f4D43	/* "IOGR" */
-
 #define DSP_FIELD_ADDR(type, field, base, wordsize) \
     ((((s32)&(((type *)0)->field)) / wordsize) + (u32)base)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/msgdefs.h b/arch/arm/plat-omap/include/dspbridge/msgdefs.h
index cda4ef4..57c168a 100644
--- a/arch/arm/plat-omap/include/dspbridge/msgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/msgdefs.h
@@ -19,8 +19,6 @@
 #ifndef MSGDEFS_
 #define MSGDEFS_
 
-#define MSGMGR_SIGNATURE    0x4d47534d	/* "MGSM" */
-
 /* msg_ctrl Objects: */
 struct msg_mgr;
 struct msg_queue;
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index e86294a..0be6181 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -52,11 +52,6 @@
 #include <dspbridge/cmm.h>
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
-/* Object signatures */
-#define CMMSIGNATURE       0x004d4d43	/* "CMM"   (in reverse) */
-#define SMEMSIGNATURE      0x4D454D53	/* "SMEM"  SM space */
-#define CMMXLATESIGNATURE  0x584d4d43	/* "CMMX"  CMM Xlator */
-
 #define NEXT_PA(pnode)   (pnode->dw_pa + pnode->ul_size)
 
 /* Other bus/platform translations */
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index f10715a..7babea5 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -36,9 +36,6 @@
 #include <dspbridge/dbll.h>
 #include <dspbridge/rmm.h>
 
-#define DBLL_TARGSIGNATURE      0x544c4c44	/* "TLLD" */
-#define DBLL_LIBSIGNATURE       0x4c4c4c44	/* "LLLD" */
-
 /* Number of buckets for symbol hash table */
 #define MAXBUCKETS 211
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index bc42520..e32757f 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -55,7 +55,6 @@
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 
-#define SIGNATURE           0x5f564544	/* "DEV_" (in reverse) */
 #define MAKEVERSION(major, minor)   (major * 10 + minor)
 #define WCDVERSION          MAKEVERSION(WCD_MAJOR_VERSION, WCD_MINOR_VERSION)
 
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index c6965b5..9406b13 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -43,9 +43,6 @@
 #include <dspbridge/dmm.h>
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
-/* Object signatures */
-#define DMMSIGNATURE       0x004d4d44	/* "DMM"   (in reverse) */
-
 #define DMM_ADDR_VIRTUAL(a) \
 	(((struct map_page *)(a) - virtual_mapping_table) * PG_SIZE4K +\
 	dyn_mem_map_beg)
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 05bd46e..954aa2a 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -46,8 +46,6 @@
 #include <dspbridge/dbdcd.h>
 
 /*  ----------------------------------- Global defines. */
-#define SIGNATURE       0x5f444344	/* "DCD_" (in reverse). */
-
 #define MAX_INT2CHAR_LENGTH     16	/* Max int2char len of 32 bit int */
 
 /* Name of section containing dependent libraries */
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 05ce538..9418f50 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -46,8 +46,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/disp.h>
 
-#define DISP_SIGNATURE       0x50534944	/* "PSID" */
-
 /* Size of a reply from RMS */
 #define REPLYSIZE (3 * sizeof(rms_word))
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index eedf5fa..3df27d9 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -44,8 +44,6 @@
 #include <dspbridge/resourcecleanup.h>
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
-#define SIGNATURE   0x5f52474d	/* "DRV_" (in reverse) */
-
 struct drv_object {
 	struct lst_list *dev_list;
 	struct lst_list *dev_node_string;
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 70522b4..60fa012 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -40,7 +40,6 @@
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 #define ZLDLLNAME               ""
-#define SIGNATURE               0x5f52474d	/* "MGR_" (in reverse) */
 
 struct mgr_object {
 	struct dcd_manager *hdcd_mgr;	/* Proc/Node data manager */
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index c12f089..c9ec523 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -36,9 +36,6 @@
 
 #include <dspbridge/nldr.h>
 
-#define NLDR_SIGNATURE      0x52444c4e	/* "RDLN" */
-#define NLDR_NODESIGNATURE  0x4e444c4e	/* "NDLN" */
-
 /* Name of section containing dynamic load mem */
 #define DYNMEMSECT  ".dspbridge_mem"
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 4da3ead..0475a09 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -67,9 +67,6 @@
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/resourcecleanup.h>
 
-#define NODE_SIGNATURE      0x45444f4e	/* "EDON" */
-#define NODEMGR_SIGNATURE   0x52474d4e	/* "RGMN" */
-
 #define HOSTPREFIX	  "/host"
 #define PIPEPREFIX	  "/dbpipe"
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 9d71fea..884d0f5 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -60,7 +60,6 @@
 
 #include <dspbridge/resourcecleanup.h>
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
-#define PROC_SIGNATURE	   0x434F5250	/* "PROC" (in reverse). */
 #define MAXCMDLINELEN       255
 #define PROC_ENVPROCID      "PROC_ID=%d"
 #define MAXPROCIDLEN	(8 + 5)
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index d1699e4..5c9af2a 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -51,8 +51,6 @@
 /*  ----------------------------------- This */
 #include <dspbridge/rmm.h>
 
-#define RMM_TARGSIGNATURE   0x544d4d52	/* "TMMR" */
-
 /*
  *  ======== rmm_header ========
  *  This header is used to maintain a list of free memory blocks.
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index b02ca45..76107c9 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -46,9 +46,6 @@
 #include <dspbridge/resourcecleanup.h>
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
-#define STRM_SIGNATURE      0x4d525453	/* "MRTS" */
-#define STRMMGR_SIGNATURE   0x5254534d	/* "RTSM" */
-
 #define DEFAULTTIMEOUT      10000
 #define DEFAULTNUMBUFS      2
 
diff --git a/drivers/dsp/bridge/wmd/_deh.h b/drivers/dsp/bridge/wmd/_deh.h
index bfe26fc..d7f2ef4 100644
--- a/drivers/dsp/bridge/wmd/_deh.h
+++ b/drivers/dsp/bridge/wmd/_deh.h
@@ -22,8 +22,6 @@
 #include <dspbridge/ntfy.h>
 #include <dspbridge/wmd.h>
 
-#define SIGNATURE       0x5f484544	/* "DEH_" backwards */
-
 /* DEH Manager: only one created per board: */
 struct deh_mgr {
 	struct wmd_dev_context *hwmd_context;	/* WMD device context. */
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index cf9c41a..e52e56a 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -38,9 +38,6 @@
 #include <_msg_sm.h>
 #include <dspbridge/wmdmsg.h>
 
-/*  ----------------------------------- Defines, Data Structures, Typedefs */
-#define MSGQ_SIGNATURE      0x5147534d	/* "QGSM" */
-
 /*  ----------------------------------- Function Prototypes */
 static dsp_status add_new_msg(struct lst_list *msgList);
 static void delete_msg_mgr(struct msg_mgr *hmsg_mgr);
-- 
1.7.0.3
