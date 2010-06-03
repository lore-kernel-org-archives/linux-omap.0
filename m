From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 34/40] DSPBRIDGE: err code replace DSP_EPENDING with EPIPE
Date: Thu,  3 Jun 2010 00:47:47 -0500
Message-ID: <1275544073-20418-35-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227Ab0FCF4V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:21 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EPENDING with EPIPE

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/strm.h |    2 +-
 drivers/dsp/bridge/rmgr/strm.c              |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 97d657d..c4b1d91 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -59,7 +59,7 @@ extern dsp_status strm_allocate_buffer(struct strm_object *hStrm,
  *  Returns:
  *      0:        Success.
  *      -EFAULT:    Invalid hStrm.
- *      DSP_EPENDING:   Some data buffers issued to the stream have not
+ *      -EPIPE:   Some data buffers issued to the stream have not
  *                      been reclaimed.
  *      -EPERM:      Failure to close stream.
  *  Requires:
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 061175e..58ec979 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -166,7 +166,7 @@ dsp_status strm_close(struct strm_object *hStrm,
 		status = -EFAULT;
 	} else {
 		/* Have all buffers been reclaimed? If not, return
-		 * DSP_EPENDING */
+		 * -EPIPE */
 		intf_fxns = hStrm->strm_mgr_obj->intf_fxns;
 		status =
 		    (*intf_fxns->pfn_chnl_get_info) (hStrm->chnl_obj,
@@ -174,7 +174,7 @@ dsp_status strm_close(struct strm_object *hStrm,
 		DBC_ASSERT(DSP_SUCCEEDED(status));
 
 		if (chnl_info_obj.cio_cs > 0 || chnl_info_obj.cio_reqs > 0)
-			status = DSP_EPENDING;
+			status = -EPIPE;
 		else
 			status = delete_strm(hStrm);
 	}
@@ -187,7 +187,7 @@ dsp_status strm_close(struct strm_object *hStrm,
 		drv_proc_remove_strm_res_element(hstrm_res, pr_ctxt);
 func_end:
 	DBC_ENSURE(status == 0 || status == -EFAULT ||
-		   status == DSP_EPENDING || status == -EPERM);
+		   status == -EPIPE || status == -EPERM);
 
 	dev_dbg(bridge, "%s: hStrm: %p, status 0x%x\n", __func__,
 		hStrm, status);
-- 
1.7.1

