From: <grygorii.strashko@linaro.org>
Subject: [PATCH] omapdss: extend pm notifier to handle hibernation
Date: Wed, 25 Feb 2015 19:03:56 +0200
Message-ID: <1424883836-9119-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38791 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbBYREB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 12:04:01 -0500
Received: by lbiz11 with SMTP id z11so5245413lbi.5
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 09:04:00 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-fbdev@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Add handling of missed events in omap_dss_pm_notif which are
needed to support hibernation (suspend to disk).

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/video/fbdev/omap2/dss/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev/omap2/dss/core.c
index 6b74f73..e60976a 100644
--- a/drivers/video/fbdev/omap2/dss/core.c
+++ b/drivers/video/fbdev/omap2/dss/core.c
@@ -178,11 +178,15 @@ static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
 	DSSDBG("pm notif %lu\n", v);
 
 	switch (v) {
+	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
 		DSSDBG("suspending displays\n");
 		return dss_suspend_all_devices();
 
 	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
 		DSSDBG("resuming displays\n");
 		return dss_resume_all_devices();
 
-- 
1.9.1

