From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/1] OMAP: omap_device: only override _noirq methods, not normal suspend/resume
Date: Wed, 24 Aug 2011 16:43:57 -0700
Message-ID: <1314229437-31836-2-git-send-email-khilman@ti.com>
References: <1314229437-31836-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60851 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803Ab1HXXng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 19:43:36 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1825789pzk.29
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 16:43:35 -0700 (PDT)
In-Reply-To: <1314229437-31836-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

commit c03f007a8bf0e092caeb6856a5c8a850df10b974 (OMAP: PM:
omap_device: add system PM methods for PM domain handling) mistakenly
used SET_SYSTEM_SLEEP_PM_OPS() when trying to configure custom methods
for the PM domains noirq methods.  Fix that by setting only the
suspend_noirq and resume_noirq methods with custom versions.

Note that all other PM domain methods (including the "normal"
suspend/resume methods) are populated using USE_PLATFORM_PM_SLEEP_OPS,
which configures them all to the default subsystem (platform_bus)
methods.

Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index b6b4097..9a6a538 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -622,7 +622,8 @@ static struct dev_pm_domain omap_device_pm_domain = {
 		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
 				   _od_runtime_idle)
 		USE_PLATFORM_PM_SLEEP_OPS
-		SET_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq, _od_resume_noirq)
+		.suspend_noirq = _od_suspend_noirq,
+		.resume_noirq = _od_resume_noirq,
 	}
 };
 
-- 
1.7.6

