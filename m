From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] staging: tidspbridge: fix incorrect free to drv_datap
Date: Mon, 30 Jan 2012 19:20:18 -0600
Message-ID: <1327972818-30993-3-git-send-email-omar.ramirez@ti.com>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:37080 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752514Ab2AaBUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 20:20:35 -0500
Received: by mail-gx0-f176.google.com with SMTP id r5so37783ggn.7
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 17:20:35 -0800 (PST)
In-Reply-To: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

This structure is still used after it has been freed, since it
is being allocated in probe, calls to free it have been moved to
module's remove routine.

This should fix the follwoing messages when attempting to remove the
module:
 drv_get_first_dev_extension: Failed to retrieve the object handle
 drv_get_first_dev_extension: Failed to retrieve the object handle
 drv_destroy: Failed to store DRV object
 mgr_destroy: Failed to store MGR object

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c    |    2 --
 drivers/staging/tidspbridge/rmgr/drv_interface.c |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index e1c4492..dde559d 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -1046,8 +1046,6 @@ static int bridge_dev_destroy(struct bridge_dev_context *dev_ctxt)
 
 	/* Free the driver's device context: */
 	kfree(drv_datap->base_img);
-	kfree(drv_datap);
-	dev_set_drvdata(bridge, NULL);
 	kfree((void *)dev_ctxt);
 	return status;
 }
diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers/staging/tidspbridge/rmgr/drv_interface.c
index 8bac511..385740b 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -410,6 +410,9 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 		DBC_ASSERT(ret == true);
 	}
 
+	kfree(drv_datap);
+	dev_set_drvdata(bridge, NULL);
+
 func_cont:
 	mem_ext_phys_pool_release();
 
-- 
1.7.4.1

