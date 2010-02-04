From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 1/2] OMAP: omap_device: add omap_device_has_lost_context()
Date: Wed,  3 Feb 2010 16:19:10 -0800
Message-ID: <1265242751-12199-2-git-send-email-khilman@deeprootsystems.com>
References: <1265242751-12199-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f201.google.com ([209.85.223.201]:62253 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008Ab0BDATP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:19:15 -0500
Received: by iwn39 with SMTP id 39so2324235iwn.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:19:15 -0800 (PST)
In-Reply-To: <1265242751-12199-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add new function omap_device_has_lost_context() as a simple check
to be used after omap_device_enable() to determine if device has
lost context (and thus needs context restore.)

Motivation: Currently, each driver needs to read the context-loss
count before suspend, and again upon resume to determine if
device context needs to be restored.  Rather than duplicating
this process across all drivers, move it into omap_device.  After
omap_device_enable(), omap_device_has_lost_context() can be called
to determine if context was lost.

This API is not intended for direct use by drivers.  Rather, the
OMAP runtime PM core will use this to determine whether or not
to call the drivers runtime_resume hook which can then be used to
restore context.

The goal is to only call drivers "restore" hook when necessary.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    3 ++
 arch/arm/plat-omap/omap_device.c              |   35 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 76d4917..ff98eb4 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -71,6 +71,8 @@ struct omap_device {
 	s8				pm_lat_level;
 	u8				hwmods_cnt;
 	u8				_state;
+	u32                             activate_loss_cnt;
+	u32                             deactivate_loss_cnt;
 };
 
 /* Device driver interface (call via platform_data fn ptrs) */
@@ -78,6 +80,7 @@ struct omap_device {
 int omap_device_enable(struct platform_device *pdev);
 int omap_device_idle(struct platform_device *pdev);
 int omap_device_shutdown(struct platform_device *pdev);
+bool omap_device_has_lost_context(struct platform_device *pdev);
 
 /* Core code interface */
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d8c75c8..aaa009d 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -84,6 +84,7 @@
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
+#include <plat/powerdomain.h>
 
 /* These parameters are passed to _omap_device_{de,}activate() */
 #define USE_WAKEUP_LAT			0
@@ -119,6 +120,7 @@
 static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;
+	struct powerdomain *pwrdm;
 
 	pr_debug("omap_device: %s: activating\n", od->pdev.name);
 
@@ -168,6 +170,10 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		od->dev_wakeup_lat -= odpl->activate_lat;
 	}
 
+	pwrdm = omap_device_get_pwrdm(od);
+	if (pwrdm)
+		od->activate_loss_cnt = pwrdm->state_counter[PWRDM_POWER_OFF];
+
 	return 0;
 }
 
@@ -188,6 +194,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;
+	struct powerdomain *pwrdm;
 
 	pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
 
@@ -239,6 +246,10 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		od->pm_lat_level++;
 	}
 
+	pwrdm = omap_device_get_pwrdm(od);
+	if (pwrdm)
+		od->deactivate_loss_cnt = pwrdm->state_counter[PWRDM_POWER_OFF];
+
 	return 0;
 }
 
@@ -560,6 +571,30 @@ int omap_device_shutdown(struct platform_device *pdev)
 }
 
 /**
+ * omap_device_has_lost_context() - check if omap_device has lost context
+ * @od: struct omap_device *
+ *
+ * When an omap_device has been deactivated via omap_device_idle() or
+ * omap_device_shutdown() and then (re)activated using omap_device_enable()
+ * This function should be used to determine if the omap_device has
+ * lost context (due to an off-mode transistion)
+ */
+bool omap_device_has_lost_context(struct platform_device *pdev)
+{
+	struct omap_device *od;
+
+	od = _find_by_pdev(pdev);
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: has_lost_context() called "
+		     "from invalid state\n", od->pdev.name, od->pdev.id);
+		return -EINVAL;
+	}
+
+	return (od->activate_loss_cnt != od->deactivate_loss_cnt);
+}
+
+/**
  * omap_device_align_pm_lat - activate/deactivate device to match wakeup lat lim
  * @od: struct omap_device *
  *
-- 
1.6.6

