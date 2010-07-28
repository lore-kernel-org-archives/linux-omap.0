From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 09/10] staging:ti dspbridge: remove DSP_FAILED macro from services
Date: Wed, 28 Jul 2010 09:45:32 -0500
Message-ID: <1280328333-31336-10-git-send-email-ernesto@ti.com>
References: <1280328333-31336-1-git-send-email-ernesto@ti.com>
 <1280328333-31336-2-git-send-email-ernesto@ti.com>
 <1280328333-31336-3-git-send-email-ernesto@ti.com>
 <1280328333-31336-4-git-send-email-ernesto@ti.com>
 <1280328333-31336-5-git-send-email-ernesto@ti.com>
 <1280328333-31336-6-git-send-email-ernesto@ti.com>
 <1280328333-31336-7-git-send-email-ernesto@ti.com>
 <1280328333-31336-8-git-send-email-ernesto@ti.com>
 <1280328333-31336-9-git-send-email-ernesto@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280328333-31336-9-git-send-email-ernesto@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, nm@ti.com, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>
List-Id: linux-omap@vger.kernel.org

Since status succeeded is 0, DSP_FAILED macro
is not necessary anymore.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/staging/tidspbridge/services/cfg.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/services/cfg.c b/drivers/staging/tidspbridge/services/cfg.c
index c3f33f6..a7af74f 100644
--- a/drivers/staging/tidspbridge/services/cfg.c
+++ b/drivers/staging/tidspbridge/services/cfg.c
@@ -102,7 +102,7 @@ int cfg_get_dev_object(struct cfg_devnode *dev_node_obj,
 		      "TIOMAP1510")))
 			*value = (u32)drv_datap->dev_object;
 	}
-	if (DSP_FAILED(status))
+	if (status)
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	return status;
 }
@@ -130,7 +130,7 @@ int cfg_get_exec_file(struct cfg_devnode *dev_node_obj, u32 buf_size,
 	if (!status && drv_datap->base_img)
 		strcpy(str_exec_file, drv_datap->base_img);
 
-	if (DSP_FAILED(status))
+	if (status)
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	DBC_ENSURE(((status == 0) &&
 		    (strlen(str_exec_file) <= buf_size))
@@ -174,12 +174,11 @@ int cfg_get_object(u32 *value, u8 dw_type)
 	default:
 		break;
 	}
-	if (DSP_FAILED(status)) {
+	if (status) {
 		*value = 0;
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	}
-	DBC_ENSURE((!status && *value != 0) ||
-		   (DSP_FAILED(status) && *value == 0));
+	DBC_ENSURE((!status && *value != 0) || (status && *value == 0));
 	return status;
 }
 
@@ -217,7 +216,7 @@ int cfg_set_dev_object(struct cfg_devnode *dev_node_obj, u32 value)
 		if (!(strcmp((char *)dev_node_obj, "TIOMAP1510")))
 			drv_datap->dev_object = (void *) value;
 	}
-	if (DSP_FAILED(status))
+	if (status)
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 
 	return status;
@@ -248,7 +247,7 @@ int cfg_set_object(u32 value, u8 dw_type)
 	default:
 		break;
 	}
-	if (DSP_FAILED(status))
+	if (status)
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	return status;
 }
-- 
1.5.4.5
