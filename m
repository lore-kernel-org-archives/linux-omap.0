From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 25/40] DSPBRIDGE: err code replace DSP_ETRANSLATE with ESRCH
Date: Thu,  3 Jun 2010 00:47:38 -0500
Message-ID: <1275544073-20418-26-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37611 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567Ab0FCF4W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:22 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_ETRANSLATE with ESRCH

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c |    6 +++---
 drivers/dsp/bridge/rmgr/strm.c |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 1c7742a..20bfe18 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1861,10 +1861,10 @@ dsp_status node_get_message(struct node_object *hnode,
 			pmsg->dw_arg1 = (u32) tmp_buf;
 			pmsg->dw_arg2 *= hnode->hnode_mgr->udsp_word_size;
 		} else {
-			status = DSP_ETRANSLATE;
+			status = -ESRCH;
 		}
 	} else {
-		status = DSP_ETRANSLATE;
+		status = -ESRCH;
 	}
 func_end:
 	dev_dbg(bridge, "%s: hnode: %p pmsg: %p utimeout: 0x%x\n", __func__,
@@ -2170,7 +2170,7 @@ dsp_status node_put_message(struct node_object *hnode,
 				status = -EPERM;	/* bad DSPWordSize */
 			}
 		} else {	/* failed to translate buffer address */
-			status = DSP_ETRANSLATE;
+			status = -ESRCH;
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index d560503..094b134 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -440,7 +440,7 @@ dsp_status strm_issue(struct strm_object *hStrm, IN u8 *pbuf, u32 ul_bytes,
 						       (void *)pbuf,
 						       CMM_VA2DSPPA);
 			if (tmp_buf == NULL)
-				status = DSP_ETRANSLATE;
+				status = -ESRCH;
 
 		}
 		if (DSP_SUCCEEDED(status)) {
@@ -676,7 +676,7 @@ dsp_status strm_reclaim(struct strm_object *hStrm, OUT u8 ** buf_ptr,
 							       CMM_PA2VA);
 			}
 			if (tmp_buf == NULL)
-				status = DSP_ETRANSLATE;
+				status = -ESRCH;
 
 			chnl_ioc_obj.pbuf = tmp_buf;
 		}
@@ -685,7 +685,7 @@ dsp_status strm_reclaim(struct strm_object *hStrm, OUT u8 ** buf_ptr,
 func_end:
 	/* ensure we return a documented return code */
 	DBC_ENSURE(DSP_SUCCEEDED(status) || status == -EFAULT ||
-		   status == -ETIME || status == DSP_ETRANSLATE ||
+		   status == -ETIME || status == -ESRCH ||
 		   status == -EPERM);
 
 	dev_dbg(bridge, "%s: hStrm: %p buf_ptr: %p pulBytes: %p pdw_arg: %p "
@@ -730,7 +730,7 @@ dsp_status strm_register_notify(struct strm_object *hStrm, u32 event_mask,
 	}
 	/* ensure we return a documented return code */
 	DBC_ENSURE(DSP_SUCCEEDED(status) || status == -EFAULT ||
-		   status == -ETIME || status == DSP_ETRANSLATE ||
+		   status == -ETIME || status == -ESRCH ||
 		   status == -ENOSYS || status == -EPERM);
 	return status;
 }
-- 
1.7.1

