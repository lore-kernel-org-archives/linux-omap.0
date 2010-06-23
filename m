From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/13] OMAP: omap_device: add flag to disable automatic bus-level suspend/resume
Date: Wed, 23 Jun 2010 16:42:40 -0700
Message-ID: <1277336563-24988-11-git-send-email-khilman@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:42006 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab0FWXnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:43:05 -0400
Received: by mail-px0-f174.google.com with SMTP id 7so469497pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:43:04 -0700 (PDT)
In-Reply-To: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

As part of the runtime PM support, bus-level code can automatically
handle the enable/idle for each omap_device.  There are, however, some
special cases where we don't want the bus-level layer to handle this,
and instead handle it manually.

Specific use cases are for omap_devices that are controlled
inside the idle path (like UART.)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 3694b62..2cdbcdd 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -68,12 +68,16 @@ struct omap_device {
 	struct omap_device_pm_latency	*pm_lats;
 	u32				dev_wakeup_lat;
 	u32				_dev_wakeup_lat_limit;
+	u32                             flags;
 	u8				pm_lats_cnt;
 	s8				pm_lat_level;
 	u8				hwmods_cnt;
 	u8				_state;
 };
 
+/* flags for struct omap_device */
+#define OMAP_DEVICE_NO_BUS_SUSPEND     BIT(0)
+
 /* Device driver interface (call via platform_data fn ptrs) */
 
 int omap_device_enable(struct platform_device *pdev);
@@ -142,6 +146,7 @@ struct omap_device_pm_latency {
 	u32 flags;
 };
 
+/* flags for struct omap_device_pm_latency */
 #define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
 
 /* Get omap_device pointer from platform_device pointer */
-- 
1.7.0.2

