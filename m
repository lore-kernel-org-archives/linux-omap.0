From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: omap_device: add to_omap_device() macro
Date: Tue, 24 Nov 2009 10:41:57 -0800
Message-ID: <1259088117-25834-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f215.google.com ([209.85.219.215]:56834 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbZKXSl6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 13:41:58 -0500
Received: by ewy7 with SMTP id 7so43884ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 10:42:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Following the model of to_platform_device(), add to_omap_device()
macro so a platform_device pointer can be converted into an
omap_device pointer.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 11a9773..d939246 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -137,5 +137,7 @@ struct omap_device_pm_latency {
 };
 
 
-#endif
+/* Get omap_device pointer from platform_device pointer */
+#define to_omap_device(x) container_of((x), struct omap_device, pdev)
 
+#endif
-- 
1.6.5.1

