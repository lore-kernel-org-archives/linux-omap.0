From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 2/2] OMAP: add omap_device_reset()
Date: Fri, 27 May 2011 10:38:28 +0300
Message-ID: <1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:43121 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755056Ab1E0Hin (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 03:38:43 -0400
Received: by eye27 with SMTP id 27so809773eye.34
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 00:38:41 -0700 (PDT)
In-Reply-To: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add omap_device_reset() function which can be used to reset the hwmods
associated with the given platform device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 70d31d0..bcf1b35 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -108,6 +108,7 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 			     u32 new_wakeup_lat_limit);
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
 int omap_device_get_context_loss_count(struct platform_device *pdev);
+int omap_device_reset(struct platform_device *pdev);
 
 /* Other */
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9753f71..4e6fc1b 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -324,6 +324,29 @@ int omap_device_get_context_loss_count(struct platform_device *pdev)
 }
 
 /**
+ * omap_device_reset - reset hwmods of given device
+ * @pdev: struct platform_device *
+ *
+ * Reset all hwmods associated with the given device. If a reset of a hwmod
+ * fails the rest of the hwmods are skipped and the error is returned.
+ */
+int omap_device_reset(struct platform_device *pdev)
+{
+	struct omap_device *od;
+	int i, r;
+
+	od = _find_by_pdev(pdev);
+
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		r = omap_hwmod_reset(od->hwmods[i]);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+/**
  * omap_device_count_resources - count number of struct resource entries needed
  * @od: struct omap_device *
  *
-- 
1.7.4.1

