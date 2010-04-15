From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 1/13] DSPBRIDGE: Cleanup custom error code
 (DSP_EDIRECTION -> -EPERM)
Date: Fri, 16 Apr 2010 02:46:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FD8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757178Ab0DOVQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:16:50 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLGldH032052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:16:49 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLGlda011009
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:46:47 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 3c0c44b52335a21832d889382c9a631df23df356 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 8 Apr 2010 17:17:46 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EDIRECTION -> -EPERM)

This patch replaces DSP_EDIRECTION with -EPERM.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 arch/arm/plat-omap/include/dspbridge/strm.h    |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                 |    4 ++--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index a9ecb71..8a0e48c 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -79,9 +79,6 @@
 /* A failure occurred during a delete operation */
 #define DSP_EDELETE                 (DSP_EBASE + 5)
 
-/* The specified direction is invalid */
-#define DSP_EDIRECTION              (DSP_EBASE + 6)
-
 /* A stream has been issued the maximum number of buffers allowed in the
  * stream at once ;  buffers must be reclaimed from the stream before any
  * more can be issued. */
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index f53d66b..fd27da2 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -259,7 +259,7 @@ extern dsp_status strm_issue(struct strm_object *hStrm, IN u8 * pbuf,
  *  Returns:
  *      DSP_SOK:        Success.
  *      -EFAULT:    Invalid hnode.
- *      DSP_EDIRECTION: Invalid dir.
+ *      -EPERM: Invalid dir.
  *      -EINVAL:     Invalid index.
  *      -EPERM:  hnode is not a task or DAIS socket node.
  *      DSP_EFAIL:      Unable to open stream.
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 45a15b4..10d86ca 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -495,7 +495,7 @@ dsp_status strm_open(struct node_object *hnode, u32 dir, u32 index,
 	DBC_REQUIRE(pattr != NULL);
 	*phStrm = NULL;
 	if (dir != DSP_TONODE && dir != DSP_FROMNODE) {
-		status = DSP_EDIRECTION;
+		status = -EPERM;
 	} else {
 		/* Get the channel id from the node (set in node_connect()) */
 		status = node_get_channel_id(hnode, dir, index, &ul_chnl_id);
@@ -613,7 +613,7 @@ func_cont:
 	DBC_ENSURE((DSP_SUCCEEDED(status) &&
 		    MEM_IS_VALID_HANDLE((*phStrm), STRM_SIGNATURE)) ||
 		   (*phStrm == NULL && (status == -EFAULT ||
-					status == DSP_EDIRECTION
+					status == -EPERM
 					|| status == -EINVAL
 					|| status == DSP_EFAIL)));
 
-- 
1.6.0.4

