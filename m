From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 07/11] OMAP: HSMMC: Fix unused variable warning
Date: Fri, 27 Aug 2010 02:26:45 +0530
Message-ID: <1282856209-15645-8-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45113 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab0HZU6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 16:58:12 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

Fixes warning due to unused variable.

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
drivers/mmc/host/omap_hsmmc.c:2308: warning: unused variable 'state'

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4a8776f..fb6446a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2305,7 +2305,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 	int ret = 0;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
-- 
1.7.0.4

