From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 3/5] DSPBRIDGE: Remove function delete_strm_mgr
Date: Mon, 21 Jun 2010 17:07:12 -0500
Message-ID: <1277158034-21843-3-git-send-email-ernesto@ti.com>
References: <1277158034-21843-1-git-send-email-ernesto@ti.com>
 <1277158034-21843-2-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47205 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847Ab0FUWE1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jun 2010 18:04:27 -0400
In-Reply-To: <1277158034-21843-2-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Remove function delete_strm_mgr in strm.c and
use kfree instead.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/strm.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index e537ee8..ce32b3d 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -89,7 +89,6 @@ static u32 refs;		/* module reference count */
 
 /*  ----------------------------------- Function Prototypes */
 static int delete_strm(struct strm_object *hStrm);
-static void delete_strm_mgr(struct strm_mgr *strm_mgr_obj);
 
 /*
  *  ======== strm_allocate_buffer ========
@@ -230,7 +229,7 @@ int strm_create(OUT struct strm_mgr **phStrmMgr,
 	if (DSP_SUCCEEDED(status))
 		*phStrmMgr = strm_mgr_obj;
 	else
-		delete_strm_mgr(strm_mgr_obj);
+		kfree(strm_mgr_obj);
 
 	DBC_ENSURE((DSP_SUCCEEDED(status) && *phStrmMgr) ||
 				(DSP_FAILED(status) && *phStrmMgr == NULL));
@@ -248,7 +247,7 @@ void strm_delete(struct strm_mgr *strm_mgr_obj)
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(strm_mgr_obj);
 
-	delete_strm_mgr(strm_mgr_obj);
+	kfree(strm_mgr_obj);
 }
 
 /*
@@ -848,14 +847,3 @@ static int delete_strm(struct strm_object *hStrm)
 	}
 	return status;
 }
-
-/*
- *  ======== delete_strm_mgr ========
- *  Purpose:
- *      Frees stream manager.
- */
-static void delete_strm_mgr(struct strm_mgr *strm_mgr_obj)
-{
-	if (strm_mgr_obj)
-		kfree(strm_mgr_obj);
-}
-- 
1.5.4.5

