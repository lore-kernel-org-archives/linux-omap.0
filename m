From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 4/4] mmc: omap: context save after enabling runtime pm
Date: Fri, 24 Feb 2012 21:14:34 +0530
Message-ID: <1330098274-12048-5-git-send-email-balajitk@ti.com>
References: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456Ab2BXPnk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 10:43:40 -0500
In-Reply-To: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

call context save api after enabling runtime pm
to make sure register access in context save api happens with clk enabled.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2576c36..0924cc8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1944,8 +1944,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	omap_hsmmc_context_save(host);
-
 	mmc->caps |= MMC_CAP_DISABLE;
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
@@ -1957,6 +1955,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(host->dev);
 
+	omap_hsmmc_context_save(host);
+
 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 		/*
-- 
1.7.0.4

