From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH RESEND 4/8] mmc: omap: context save after enabling runtime pm
Date: Thu, 15 Mar 2012 20:03:38 +0530
Message-ID: <1331822022-26714-5-git-send-email-svenkatr@ti.com>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

call context save api after enabling runtime pm
to make sure register access in context save api happens with clk enabled.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0f8d34b..9fa2f39 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1871,8 +1871,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	omap_hsmmc_context_save(host);
-
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
 		mmc->caps2 |= MMC_CAP2_NO_MULTI_READ;
@@ -1883,6 +1881,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(host->dev);
 
+	omap_hsmmc_context_save(host);
+
 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 		/*
-- 
1.7.10.rc0.41.gfa678

