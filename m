From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/19] omap_hsmmc: Ensure regulator enable / disable are paired
Date: Thu, 11 Feb 2010 16:51:27 -0800
Message-ID: <20100212005127.24958.82734.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51397 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738Ab0BLAuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:46 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Stop using 'regulator_is_enabled()' and just pair enables
with disables so that the regulator reference counts can
work correctly.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index cb94044..d2fad58 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -296,11 +296,8 @@ static int omap_hsmmc_23_set_power(struct device *dev, int slot, int power_on,
 				ret = mmc_regulator_set_ocr(host->vcc, 0);
 		}
 	} else {
-		if (host->vcc_aux) {
-			ret = regulator_is_enabled(host->vcc_aux);
-			if (ret > 0)
-				ret = regulator_disable(host->vcc_aux);
-		}
+		if (host->vcc_aux)
+			ret = regulator_disable(host->vcc_aux);
 		if (ret == 0)
 			ret = mmc_regulator_set_ocr(host->vcc, 0);
 	}
@@ -1975,7 +1972,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	host->slot_id	= 0;
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
-	host->power_mode = -1;
+	host->power_mode = MMC_POWER_OFF;
 
 	platform_set_drvdata(pdev, host);
 	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);

