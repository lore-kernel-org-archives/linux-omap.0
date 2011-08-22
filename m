From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 6/7] OMAP: omap_device: Create a default omap_device_pm_latency
Date: Mon, 22 Aug 2011 17:19:06 +0200
Message-ID: <1314026347-21623-7-git-send-email-b-cousson@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44885 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab1HVPUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2011 11:20:20 -0400
In-Reply-To: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>

Most devices are using the same default omap_device_pm_latency structure
during device built. In order to avoid the duplication of the same
structure everywhere, add a default structure that will be used if
the device does not have an explicit one.

Next patches will clean the duplicated structures.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 455594a..f2149be 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -97,6 +97,14 @@
 static int omap_device_register(struct platform_device *pdev);
 static int omap_early_device_register(struct platform_device *pdev);
 
+static struct omap_device_pm_latency omap_default_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	}
+};
+
 /* Private functions */
 
 /**
@@ -510,8 +518,13 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	if (ret)
 		goto odbs_exit3;
 
-	od->pm_lats = pm_lats;
-	od->pm_lats_cnt = pm_lats_cnt;
+	if (pm_lats) {
+		od->pm_lats = pm_lats;
+		od->pm_lats_cnt = pm_lats_cnt;
+	} else {
+		od->pm_lats = omap_default_latency;
+		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
+	}
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
-- 
1.7.0.4

