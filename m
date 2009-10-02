From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH v2] omap_hsmmc: Add missing probe handler hook
Date: Fri,  2 Oct 2009 15:22:40 +0300
Message-ID: <1254486160-7117-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55094 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbZJBMX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 08:23:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: madhu.cr@ti.com
Cc: tony@atomide.com, rok@kanardia.eu, linux-omap@vger.kernel.org

The missing probe handler hook will never probe the driver. Add it back.
Fixes broken MMC on OMAP.

We use platform_driver_probe() API since omap_hsmmc is not a hot-pluggable
device.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4487cc0..0aecaae 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2013,7 +2013,7 @@ static struct platform_driver omap_hsmmc_driver = {
 static int __init omap_hsmmc_init(void)
 {
 	/* Register the MMC driver */
-	return platform_driver_register(&omap_hsmmc_driver);
+	return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
 }
 
 static void __exit omap_hsmmc_cleanup(void)
-- 
1.6.0.4

