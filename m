From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] MMC: OMAP: flush posted write to IRQ
Date: Wed,  1 Apr 2009 16:12:47 -0700
Message-ID: <1238627567-19753-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:57393 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935002AbZDAXMv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 19:12:51 -0400
Received: by wf-out-1314.google.com with SMTP id 29so291831wff.4
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2009 16:12:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Spurious IRQs seen on MMC after 2.6.29.  Flush posted write in IRQ
handler.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3916a56..4270676 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -464,6 +464,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 	}
 
 	OMAP_HSMMC_WRITE(host->base, STAT, status);
+	OMAP_HSMMC_READ(host->base, STAT); /* flush posted write */
 
 	if (end_cmd || (status & CC))
 		mmc_omap_cmd_done(host, host->cmd);
-- 
1.6.1.3

