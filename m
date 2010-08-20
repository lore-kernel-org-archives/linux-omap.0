From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 09/10] [PM-WIP-MMC] OMAP MMC : Fix crash with
     CONFIG_PM_RUNTIME
Date: Sat, 21 Aug 2010 01:41:16 +0530 (IST)
Message-ID: <16171.10.24.255.18.1282335076.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49311 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab0HTULT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 16:11:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com

Crash if enabled CONFIG_PM_RUNTIME and power_saving set.

Use get_sync/put_sync properly so that host->nesting_cnt gets
updated properly.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c113bfd..90a69c3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2036,7 +2036,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	host->dpm_state = DISABLED;

 	pm_runtime_enable(host->dev);
-	pm_runtime_get_sync(host->dev);
+	if (mmc_host_enable(host->mmc) != 0)
+		goto err1;

 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
@@ -2139,8 +2140,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)

 	mmc_add_host(mmc);

-	pm_runtime_put(host->dev);
-
 	if (mmc_slot(host).name != NULL) {
 		ret = device_create_file(&mmc->class_dev, &dev_attr_slot_name);
 		if (ret < 0)
-- 
1.7.0.4


