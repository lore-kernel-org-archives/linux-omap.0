From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] HSMMC: mmc_omap_irq: Do not expect cmd/data to be non-null
 when CC/TC occurs
Date: Wed, 08 Apr 2009 11:18:32 +0300
Message-ID: <49DC5DD8.2070208@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27081 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763616AbZDHISD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Apr 2009 04:18:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

With spurious interrupt cmd can be null even when we have CC
set in irq status.

Fixes: NB#106295 - prevent potential kernel crash in the MMC driver

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d183be6..0268992 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -490,7 +490,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 
 	OMAP_HSMMC_WRITE(host->base, STAT, status);
 
-	if (end_cmd || (status & CC))
+	if (end_cmd || ((status & CC) && host->cmd))
 		mmc_omap_cmd_done(host, host->cmd);
 	if (end_trans || (status & TC))
 		mmc_omap_xfer_done(host, data);
-- 
1.5.6.3
