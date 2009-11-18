From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 5/8] OMAP: omap_device: add usecounting
Date: Tue, 17 Nov 2009 17:05:10 -0800
Message-ID: <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:45572 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbZKRBF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:28 -0500
Received: by mail-gx0-f226.google.com with SMTP id 26so630093gxk.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:34 -0800 (PST)
In-Reply-To: <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add use counters to omap_device to enable multiple potential users of
an omap_device.  This is needed if ever there are multiple users or
multiple instances of a driver with a single omap_device.

Without usecounting, with multiple users, the first one to call idle
may forcibly idle the device while other users are still active.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index d939246..c504780 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -71,6 +71,7 @@ struct omap_device {
 	s8				pm_lat_level;
 	u8				hwmods_cnt;
 	u8				_state;
+	u32                             _usecount;
 };
 
 /* Device driver interface (call via platform_data fn ptrs) */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index da649f2..6a8b0ce 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -388,6 +388,8 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
+	od->_usecount = 0;
+
 	ret = omap_device_register(od);
 	if (ret)
 		goto odbs_exit4;
@@ -446,6 +448,9 @@ int omap_device_enable(struct platform_device *pdev)
 
 	od = _find_by_pdev(pdev);
 
+	if (od->_usecount++)
+		return 0;
+
 	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
 		WARN(1, "omap_device: %s.%d: omap_device_enable() called from "
 		     "invalid state\n", od->pdev.name, od->pdev.id);
@@ -485,6 +490,9 @@ int omap_device_idle(struct platform_device *pdev)
 
 	od = _find_by_pdev(pdev);
 
+	if (--od->_usecount)
+		return 0;
+
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
 		WARN(1, "omap_device: %s.%d: omap_device_idle() called from "
 		     "invalid state\n", od->pdev.name, od->pdev.id);
@@ -530,6 +538,7 @@ int omap_device_shutdown(struct platform_device *pdev)
 		omap_hwmod_shutdown(oh);
 
 	od->_state = OMAP_DEVICE_STATE_SHUTDOWN;
+	od->_usecount = 0;
 
 	return ret;
 }
-- 
1.6.5.1

