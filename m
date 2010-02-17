From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: Reclaim all pending buffer on resource
 cleanup
Date: Tue, 16 Feb 2010 18:40:13 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9606@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43997 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933615Ab0BQAkS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 19:40:18 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

>From 6ed51fea16df51e88a25bda2b9908f0a43b86303 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Tue, 16 Feb 2010 18:32:02 -0600
Subject: [PATCH] DSPBRIDGE: Reclaim all pending buffer on resource cleanup

Before in case of pending buffer while we try to close
a stream, it was doing only one reclaim, in the case there
were more pending buffer the second STRM_Close would also
fail, now all the pending buffers are reclaim.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 505f2b0..5a394da 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -461,6 +461,8 @@ DSP_STATUS DRV_RemoveAllSTRMResElements(HANDLE hPCtxt)
 	DSP_STATUS status = DSP_SOK;
 	struct STRM_RES_OBJECT *strm_res = NULL;
 	struct STRM_RES_OBJECT *strm_tmp = NULL;
+	struct STRM_INFO strm_info;
+	struct DSP_STREAMINFO user;
 	u8 **apBuffer = NULL;
 	u8 *pBufPtr;
 	u32 ulBytes;
@@ -474,17 +476,19 @@ DSP_STATUS DRV_RemoveAllSTRMResElements(HANDLE hPCtxt)
 		if (strm_res->uNumBufs) {
 			apBuffer = MEM_Alloc((strm_res->uNumBufs *
 					    sizeof(u8 *)), MEM_NONPAGED);
-			status = STRM_FreeBuffer(strm_res->hStream, apBuffer,
-						strm_res->uNumBufs, pCtxt);
-			kfree(apBuffer);
+			if (apBuffer) {
+				status = STRM_FreeBuffer(strm_res->hStream,
+					apBuffer, strm_res->uNumBufs, pCtxt);
+				kfree(apBuffer);
+			}
 		}
+		strm_info.pUser = &user;
+		user.uNumberBufsInStream = 0;
+		STRM_GetInfo(strm_res->hStream, &strm_info, sizeof(strm_info));
+		while (user.uNumberBufsInStream--)
+			STRM_Reclaim(strm_res->hStream, &pBufPtr, &ulBytes,
+					     (u32 *)&ulBufSize, &dwArg);
 		status = STRM_Close(strm_res->hStream, pCtxt);
-		if (status == DSP_EPENDING) {
-			status = STRM_Reclaim(strm_res->hStream,
-				&pBufPtr, &ulBytes, (u32 *)&ulBufSize, &dwArg);
-			if (DSP_SUCCEEDED(status))
-				status = STRM_Close(strm_res->hStream, pCtxt);
-		}
 	}
 	return status;
 }
-- 
1.6.0.4

