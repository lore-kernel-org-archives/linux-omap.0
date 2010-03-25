From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 11/19] DSPBRIDGE: Cleanup custom error code (DSP_ERANGE
 -> EDOM)
Date: Fri, 26 Mar 2010 01:36:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab0CYUGx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

>From 97dbbf09aabd0dc94396ad15eeaa6871142ae290 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 11:31:43 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ERANGE -> EDOM)

This patch replaces DSP_ERANGE with EDOM.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/node.h    |    4 ++--
 arch/arm/plat-omap/include/dspbridge/strm.h    |    2 +-
 drivers/dsp/bridge/rmgr/node.c                 |    4 ++--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index da2900c..1cc0101 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -99,9 +99,6 @@
 /* I/O is currently pending. */
 #define DSP_EPENDING                (DSP_EBASE + 0x11)
 
-/* A parameter is specified outside its valid range. */
-#define DSP_ERANGE                  (DSP_EBASE + 0x13)
-
 /* An invalid size parameter was specified. */
 #define DSP_ESIZE                   (DSP_EBASE + 0x14)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 77af26d..e2c5c94 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -42,7 +42,7 @@
  *      ENOMEM:        Insufficient memory on GPP.
  *      DSP_EUUID:          Node UUID has not been registered.
  *      DSP_ESYMBOL:        iAlg functions not found for a DAIS node.
- *      DSP_ERANGE:         attr_in != NULL and attr_in->prio out of
+ *      EDOM:         attr_in != NULL and attr_in->prio out of
  *                          range.
  *      DSP_EFAIL:          A failure occured, unable to allocate node.
  *      DSP_EWRONGSTATE:    Proccessor is not in the running state.
@@ -99,7 +99,7 @@ extern dsp_status node_alloc_msg_buf(struct node_object *hnode,
  *  Returns:
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
- *      DSP_ERANGE:         prio is out of range.
+ *      EDOM:         prio is out of range.
  *      EPERM:      The specified node is not a task node.
  *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
  *                          or NODE_RUNNING state.
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index d0026c7..609a6e7 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -363,7 +363,7 @@ extern dsp_status strm_register_notify(struct strm_object *hStrm,
  *      utimeout:       Timeout value (milliseconds).
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_ERANGE:     nStrms out of range.
+ *      EDOM:     nStrms out of range.
 
  *      EFAULT:    Invalid stream handle in array.
  *      DSP_ETIMEOUT:   A timeout occurred before a stream became ready.
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 49c6d17..6bc0e2e 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -374,7 +374,7 @@ dsp_status node_allocate(struct proc_object *hprocessor,
 			/* Check if attr_in->prio is within range */
 			if (attr_in->prio < hnode_mgr->min_pri ||
 			    attr_in->prio > hnode_mgr->max_pri)
-				status = DSP_ERANGE;
+				status = EDOM;
 		}
 	}
 	/* Allocate node object and fill in */
@@ -785,7 +785,7 @@ dsp_status node_change_priority(struct node_object *hnode, s32 prio)
 		if (node_type != NODE_TASK && node_type != NODE_DAISSOCKET)
 			status = EPERM;
 		else if (prio < hnode_mgr->min_pri || prio > hnode_mgr->max_pri)
-			status = DSP_ERANGE;
+			status = EDOM;
 	}
 	if (DSP_FAILED(status))
 		goto func_end;
-- 
1.6.0.4

