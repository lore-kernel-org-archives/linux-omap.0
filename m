From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH] DSPBRIDGE: Fix wrong prints of DBC_ENSURE()
Date: Thu, 10 Jun 2010 13:28:35 -0500
Message-ID: <1276194515-3216-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47825 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab0FJSfa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jun 2010 14:35:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

The patch "DSPBRIDGE: Check pointer instead of using MEM_IS_VALID_HANDLE
macro" uncovered an issue when calling the assertion macros after the
pointer was freed, but not set to NULL.

This issue was not showing before the above patch because the macro
MEM_IS_VALID_HANDLE checked for the pointer and signature, which was
not good because it dereferenced a pointer that was already freed.

This patch removes DBC_ENSURE() whenever it checks for a previously
freed pointer, or fix the code to avoid wrong assertions printing.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 drivers/dsp/bridge/pmgr/chnl.c  |    2 --
 drivers/dsp/bridge/pmgr/dev.c   |    3 ---
 drivers/dsp/bridge/rmgr/dbdcd.c |    5 ++---
 drivers/dsp/bridge/rmgr/disp.c  |    2 --
 drivers/dsp/bridge/rmgr/drv.c   |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c   |    2 --
 drivers/dsp/bridge/rmgr/nldr.c  |    1 -
 drivers/dsp/bridge/rmgr/strm.c  |   11 ++++-------
 8 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index bc5c3e9..32ddd46 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -127,8 +127,6 @@ dsp_status chnl_destroy(struct chnl_mgr *hchnl_mgr)
 		status = -EFAULT;
 	}
 
-	DBC_ENSURE(DSP_FAILED(status) || !chnl_mgr_obj);
-
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 3465b52..990695c 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -575,8 +575,6 @@ struct dev_object *dev_get_first(void)
 
 	dev_obj = (struct dev_object *)drv_get_first_dev_object();
 
-	DBC_ENSURE((dev_obj == NULL) || dev_obj);
-
 	return dev_obj;
 }
 
@@ -644,7 +642,6 @@ struct dev_object *dev_get_next(struct dev_object *hdev_obj)
 		next_dev_object = (struct dev_object *)
 		    drv_get_next_dev_object((u32) hdev_obj);
 	}
-	DBC_ENSURE((next_dev_object == NULL) || next_dev_object);
 
 	return next_dev_object;
 }
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 3fa267f..c15d121 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -157,9 +157,8 @@ dsp_status dcd_create_manager(IN char *pszZlDllName,
 		cod_delete(cod_mgr);
 	}
 
-	DBC_ENSURE((DSP_SUCCEEDED(status)) || ((cod_mgr == NULL) &&
-					       (status == -EPERM))
-		   || ((dcd_mgr_obj == NULL) && (status == -ENOMEM)));
+	DBC_ENSURE((DSP_SUCCEEDED(status)) ||
+			((dcd_mgr_obj == NULL) && (status == -ENOMEM)));
 
 func_end:
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index c125395..1e7c22a 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -185,8 +185,6 @@ void disp_delete(struct disp_object *disp_obj)
 	DBC_REQUIRE(disp_obj);
 
 	delete_disp(disp_obj);
-
-	DBC_ENSURE(!disp_obj);
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index aab6416..e30432c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -512,7 +512,7 @@ dsp_status drv_destroy(struct drv_object *hDRVObject)
 	kfree(pdrv_object);
 	/* Update the DRV Object in Registry to be 0 */
 	(void)cfg_set_object(0, REG_DRV_OBJECT);
-	DBC_ENSURE(!pdrv_object);
+
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index a0e89dc..0441d47 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -106,8 +106,6 @@ dsp_status mgr_destroy(struct mgr_object *hmgr_obj)
 	/* Update the Registry with NULL for MGR Object */
 	(void)cfg_set_object(0, REG_MGR_OBJECT);
 
-	DBC_ENSURE(DSP_FAILED(status) || !hmgr_obj);
-
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 6d8c646..6faa439 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -658,7 +658,6 @@ void nldr_delete(struct nldr_object *nldr_obj)
 		kfree(nldr_obj->ovly_table);
 	}
 	kfree(nldr_obj);
-	DBC_ENSURE(!nldr_obj);
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index aa3d81f..c3ae9a2 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -232,8 +232,8 @@ dsp_status strm_create(OUT struct strm_mgr **phStrmMgr,
 	else
 		delete_strm_mgr(strm_mgr_obj);
 
-	DBC_ENSURE(DSP_SUCCEEDED(status) &&
-		(*phStrmMgr || (DSP_FAILED(status) && *phStrmMgr == NULL)));
+	DBC_ENSURE((DSP_SUCCEEDED(status) && *phStrmMgr) ||
+				(DSP_FAILED(status) && *phStrmMgr == NULL));
 
 	return status;
 }
@@ -249,8 +249,6 @@ void strm_delete(struct strm_mgr *strm_mgr_obj)
 	DBC_REQUIRE(strm_mgr_obj);
 
 	delete_strm_mgr(strm_mgr_obj);
-
-	DBC_ENSURE(!strm_mgr_obj);
 }
 
 /*
@@ -602,9 +600,8 @@ func_cont:
 	/* ensure we return a documented error code */
 	DBC_ENSURE((DSP_SUCCEEDED(status) && *phStrm) ||
 		   (*phStrm == NULL && (status == -EFAULT ||
-					status == -EPERM
-					|| status == -EINVAL
-					|| status == -EPERM)));
+					status == -EPERM  ||
+					status == -EINVAL)));
 
 	dev_dbg(bridge, "%s: hnode: %p dir: 0x%x index: 0x%x pattr: %p "
 		"phStrm: %p status: 0x%x\n", __func__,
-- 
1.7.0.3

