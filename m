From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 5/5] staging: tidspbridge: remove unused code to handle iva_img
Date: Thu, 10 Jan 2013 03:37:02 -0600
Message-ID: <1357810622-1709-6-git-send-email-omar.ramirez@copitl.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:39711 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3AJJhZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 04:37:25 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so343730oag.14
        for <linux-omap@vger.kernel.org>; Thu, 10 Jan 2013 01:37:24 -0800 (PST)
In-Reply-To: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen Gang <gang.chen@asianux.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>

There is no way to specify the value of iva_img and since this code
is not being used, remove it.

This analysis resulted from a report by
Chen Gang <gang.chen@asianux.com>, mentioning that the existing code
was wrongly specifying the size to be copied.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
---
 .../staging/tidspbridge/include/dspbridge/proc.h   |    2 --
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |    1 -
 drivers/staging/tidspbridge/rmgr/proc.c            |    4 ----
 3 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/proc.h b/drivers/staging/tidspbridge/include/dspbridge/proc.h
index 851b356..774a3f6 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/proc.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/proc.h
@@ -23,8 +23,6 @@
 #include <dspbridge/devdefs.h>
 #include <dspbridge/drv.h>
 
-extern char *iva_img;
-
 /*
  *  ======== proc_attach ========
  *  Purpose:
diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers/staging/tidspbridge/rmgr/drv_interface.c
index e6f31d8..df0f37e 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -65,7 +65,6 @@ static struct class *bridge_class;
 static u32 driver_context;
 static s32 driver_major;
 static char *base_img;
-char *iva_img;
 static s32 shm_size = 0x500000;	/* 5 MB */
 static int tc_wordswapon;	/* Default value is always false */
 #ifdef CONFIG_TIDSPBRIDGE_RECOVERY
diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index ac016ed..e1bdf6e 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -382,7 +382,6 @@ static int get_exec_file(struct cfg_devnode *dev_node_obj,
 				u32 size, char *exec_file)
 {
 	u8 dev_type;
-	s32 len;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 	dev_get_dev_type(hdev_obj, (u8 *) &dev_type);
@@ -398,9 +397,6 @@ static int get_exec_file(struct cfg_devnode *dev_node_obj,
 			return -EINVAL;
 
 		strcpy(exec_file, drv_datap->base_img);
-	} else if (dev_type == IVA_UNIT && iva_img) {
-		len = strlen(iva_img);
-		strncpy(exec_file, iva_img, len + 1);
 	} else {
 		return -ENOENT;
 	}
-- 
1.7.4.4

