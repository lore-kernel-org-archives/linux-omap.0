From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: RFC] [PATCH 3/13] DSPBRIDGE: Cleanup custom error code
 (DSP_ENOMORECONNECTIONS -> -ECONNREFUSED)
Date: Fri, 16 Apr 2010 02:46:56 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FD9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40779 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0DOVRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:17:00 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLGv02030898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:16:59 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLGvhJ011033
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:46:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 7ec741cb6e3e10844b77e1cb235488218bc0d1a9 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 10:41:25 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ENOMORECONNECTIONS -> -ECONNREFUSED)

 This patch replaces DSP_ENOMORECONNECTIONS with -ECONNREFUSED.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/node.h    |    2 +-
 drivers/dsp/bridge/rmgr/node.c                 |    4 ++--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 28c4d7b..3f637dd 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -85,9 +85,6 @@
 /* No error text was found for the specified error code. */
 #define DSP_ENOERRTEXT              (DSP_EBASE + 0xe)
 
-/* No more connections can be made for this node. */
-#define DSP_ENOMORECONNECTIONS      (DSP_EBASE + 0xf)
-
 /* I/O is currently pending. */
 #define DSP_EPENDING                (DSP_EBASE + 0x11)
 
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 073991b..3c58ecb 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -172,7 +172,7 @@ extern dsp_status node_close_orphans(struct node_mgr *hnode_mgr,
  *                              indices uStream1 or uStream2.
  *      DSP_EWRONGSTATE:        Either hNode1 or hNode2 is not in the
  *                              NODE_ALLOCATED state.
- *      DSP_ENOMORECONNECTIONS: No more connections available.
+ *      -ECONNREFUSED: No more connections available.
  *      DSP_EFAIL:              Attempt to make an illegal connection (eg,
  *                              Device node to device node, or device node to
  *                              GPP), the two nodes are on different DSPs.
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index d4949dc..c50ac1b 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -953,7 +953,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
 		/* Find available pipe */
 		pipe_id = gb_findandset(hnode_mgr->pipe_map);
 		if (pipe_id == GB_NOBITS) {
-			status = DSP_ENOMORECONNECTIONS;
+			status = -ECONNREFUSED;
 		} else {
 			hNode1->outputs[uStream1].type = NODECONNECT;
 			hNode2->inputs[uStream2].type = NODECONNECT;
@@ -1025,7 +1025,7 @@ dsp_status node_connect(struct node_object *hNode1, u32 uStream1,
 			chnl_id = gb_findandset(hnode_mgr->chnl_map);
 		}
 		if (chnl_id == GB_NOBITS) {
-			status = DSP_ENOMORECONNECTIONS;
+			status = -ECONNREFUSED;
 			goto func_cont2;
 		}
 		pstr_dev_name = mem_calloc(HOSTNAMELEN + 1, MEM_PAGED);
-- 
1.6.0.4

