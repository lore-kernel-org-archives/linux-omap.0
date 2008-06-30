From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] omap: hsmmc: Avoid NULL pointer dereference
Date: Mon, 30 Jun 2008 17:16:27 +0300
Message-ID: <1214835387-11123-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22270 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538AbYF3ORb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 10:17:31 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5UEH0dO010755
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 17:17:28 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Try if pdata provides a cleanup function pointers. For
boards which don't provide it, driver will oops in
omap_remove.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 467f146..4dfa8dd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -887,7 +887,8 @@ static int omap_mmc_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	if (host) {
-		host->pdata->cleanup(&pdev->dev);
+		if (host->pdata->cleanup)
+			host->pdata->cleanup(&pdev->dev);
 		free_irq(host->irq, host);
 		if (mmc_slot(host).card_detect_irq)
 			free_irq(mmc_slot(host).card_detect_irq, host);
-- 
1.5.6.49.g112db

