From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 8/8] OMAP: omap_device: use UINT_MAX for default wakeup latency limit
Date: Tue, 17 Nov 2009 17:05:13 -0800
Message-ID: <1258506313-17115-9-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61295 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734AbZKRBFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:40 -0500
Received: by mail-yx0-f187.google.com with SMTP id 17so614173yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:46 -0800 (PST)
In-Reply-To: <1258506313-17115-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The _dev_wakeup_lat_limit field of struct omap_device is u32, so use
UINT_MAX instead of INT_MAX for the default maximum.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 83bee1c..9ec3735 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -468,7 +468,7 @@ int omap_device_enable(struct platform_device *pdev)
 	ret = _omap_device_activate(od, IGNORE_WAKEUP_LAT);
 
 	od->dev_wakeup_lat = 0;
-	od->_dev_wakeup_lat_limit = INT_MAX;
+	od->_dev_wakeup_lat_limit = UINT_MAX;
 	od->_state = OMAP_DEVICE_STATE_ENABLED;
 
 	return ret;
-- 
1.6.5.1

