From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] omap_hsmmc: Add missing probe handler hook to platform driver data
Date: Thu,  1 Oct 2009 17:39:13 +0300
Message-ID: <1254407953-25124-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64516 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932519AbZJAOjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 10:39:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: madhu.cr@ti.com
Cc: linux-omap@vger.kernel.org, ext-roger.quadros@nokia.com

The missing probe handler hook will never probe the driver. Add it back.
Fixes broken MMC on OMAP.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4487cc0..26abe1e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2001,6 +2001,7 @@ clk_en_err:
 #endif
 
 static struct platform_driver omap_hsmmc_driver = {
+	.probe		= omap_hsmmc_probe,
 	.remove		= omap_hsmmc_remove,
 	.suspend	= omap_hsmmc_suspend,
 	.resume		= omap_hsmmc_resume,
-- 
1.6.0.4

