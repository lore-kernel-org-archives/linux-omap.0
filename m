From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 13/17] OMAP3: PM: Support for enabling smartreflex autocompensation by default.
Date: Thu, 18 Mar 2010 14:45:51 +0530
Message-ID: <1268903755-4151-14-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
 <1268903755-4151-9-git-send-email-thara@ti.com>
 <1268903755-4151-10-git-send-email-thara@ti.com>
 <1268903755-4151-11-git-send-email-thara@ti.com>
 <1268903755-4151-12-git-send-email-thara@ti.com>
 <1268903755-4151-13-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50250 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-13-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds support to pdata enable smartreflex autocompenstion
during init based on enable_on_init flag passed as pdata.

This patch also adds enabling of autocompensation by
default (setting enable_on_init  flag to true) in case of ES3.1
OMAP3430 chip. In the current implementation
this step is kept in smartreflex.c itself.Later an API can be added
so that the decision to enable autocompensation by default
can be passed from the corresponding board files.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    5 +++++
 arch/arm/mach-omap2/sr_device.c   |   16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 35848d9..aeb9761 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -345,6 +345,7 @@ static void  sr_stop_vddautocomp(int srid)
 static int sr_late_init(struct omap_sr *sr_info)
 {
 	char name[SMARTREFLEX_NAME_LEN];
+	struct omap_smartreflex_data *pdata = sr_info->pdev->dev.platform_data;
 	int ret = 0;
 
 	if (sr_class->class_type == SR_CLASS2 &&
@@ -358,6 +359,10 @@ static int sr_late_init(struct omap_sr *sr_info)
 				handler for SR%d. Smartreflex will \
 				not function as desired\n", sr_info->srid);
 	}
+
+	if (pdata->enable_on_init)
+		sr_start_vddautocomp(sr_info->srid);
+
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 1ee7f4c..209909c 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -162,7 +162,21 @@ static int __init omap_devinit_smartreflex(void)
 		if (WARN_ON(!sr_data))
 			return -ENOMEM;
 
-		sr_data->enable_on_init = false;
+		/*
+		 * OMAP3430 ES3.1 chips by default come with Efuse burnt
+		 * with parameters required for full functionality of
+		 * smartreflex AVS feature like ntarget values , sennenable
+		 * and senpenable. So enable the SR AVS feature during boot up
+		 * itself if it is a OMAP3430 ES3.1 chip.
+		 */
+		if (cpu_is_omap343x()) {
+			if (omap_rev() == OMAP3430_REV_ES3_1)
+				sr_data->enable_on_init = true;
+			else
+				sr_data->enable_on_init = false;
+		} else {
+			sr_data->enable_on_init = false;
+		}
 		sr_data->device_enable = omap_device_enable;
 		sr_data->device_shutdown = omap_device_shutdown;
 		sr_data->device_idle = omap_device_idle;
-- 
1.7.0.rc1.33.g07cf0f

