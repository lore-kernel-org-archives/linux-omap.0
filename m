From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: PATCH 2/2 OMAP: HSMMC: Disable the mmc clocks when not needed
Date: Tue, 21 Oct 2008 15:46:24 +0300
Message-ID: <20081021124624.GA11859@angel.research.nokia.com>
References: <20081021124306.GA11845@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47506 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbYJUMqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 08:46:55 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9LCkOpo011785
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 15:46:52 +0300
Received: from jlavi by angel.research.nokia.com with local (Exim 4.69)
	(envelope-from <jlavi@angel.research.nokia.com>)
	id 1KsGcy-00035d-V2
	for linux-omap@vger.kernel.org; Tue, 21 Oct 2008 15:46:24 +0300
Content-Disposition: inline
In-Reply-To: <20081021124306.GA11845@angel.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>

The HSMMC clocks are running all the time even when no requests
are running and this consumes power to no effect.

The patch shuts down the clocks lazily using 100 ms timer after a
request is completed and if no other request has started.

MMCA spec would require mmc clocks to be enabled for at least 8 cycles
after a command has been run. At 400 kHz this is 20 microseconds.

Cheers
Jarkko Lavinen

>From 66e7a87a53b706aa5abf39a4cea15df37092f835 Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Tue, 21 Oct 2008 15:04:37 +0300
Subject: [PATCH] OMAP: HSMMC: Disable the mmc clocks when not needed

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |  138 +++++++++++++++++++++++++++++++---------
 1 files changed, 107 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index edd1ce0..456c87b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -102,6 +102,8 @@
 #define OMAP_MMC_MASTER_CLOCK	96000000
 #define DRIVER_NAME		"mmci-omap"
 
+#define CLK_SHUTOFF_DELAY	msecs_to_jiffies(100)
+
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -127,6 +129,9 @@ struct mmc_omap_host {
 	struct	clk		*fclk;
 	struct	clk		*iclk;
 	struct	clk		*dbclk;
+	struct  timer_list      clk_timer;
+	spinlock_t              clk_lock;	/* Potects clk_enabled */
+	unsigned int 		clks_enabled:1;
 	struct	semaphore	sem;
 	struct	work_struct	mmc_carddetect_work;
 	void	__iomem		*base;
@@ -148,6 +153,9 @@ struct mmc_omap_host {
 	struct	omap_mmc_platform_data	*pdata;
 };
 
+static void mmc_omap_cmd_done(struct mmc_omap_host *host,
+			      struct mmc_command *cmd);
+
 /*
  * Stop clock to the card
  */
@@ -216,6 +224,67 @@ mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
 
+static int omap_mmc_clks_enable(struct mmc_omap_host *host)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&host->clk_lock, flags);
+	del_timer(&host->clk_timer);
+	if (host->clks_enabled == 0) {
+		ret = clk_enable(host->fclk);
+		if (ret) {
+			dev_dbg(mmc_dev(host->mmc),
+				"Enabling fclk failed\n");
+			goto err_out;
+		}
+
+		ret = clk_enable(host->iclk);
+		if (ret) {
+			dev_dbg(mmc_dev(host->mmc),
+				"Enabling iclk failed\n");
+			goto err_out;
+		}
+
+		if (!IS_ERR(host->dbclk)) {
+			int rc = clk_enable(host->dbclk);
+			if (rc) {
+				static int nagged;
+
+				if (!nagged) {
+					dev_dbg(mmc_dev(host->mmc), "Enabling "
+						"debounce clk failed\n");
+					nagged = 1;
+				}
+				host->dbclk_enabled = 0;
+			} else
+				host->dbclk_enabled = 1;
+		} else
+			host->dbclk_enabled = 0;
+	}
+
+err_out:
+	spin_unlock_irqrestore(&host->clk_lock, flags);
+	return ret;
+}
+
+static void omap_mmc_clks_disable(struct mmc_omap_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->clk_lock, flags);
+	if (host->clks_enabled != 0) {
+		clk_disable(host->fclk);
+		clk_disable(host->iclk);
+		if (host->dbclk_enabled)
+			clk_disable(host->dbclk);
+	}
+
+	host->clks_enabled = 0;
+
+	return;
+}
+
 /*
  * Configure the response type and send the cmd.
  */
@@ -288,6 +357,7 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 
 	if (!data->stop) {
 		host->mrq = NULL;
+		mod_timer(&host->clk_timer, jiffies + CLK_SHUTOFF_DELAY);
 		mmc_request_done(host->mmc, data->mrq);
 		return;
 	}
@@ -316,6 +386,7 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 	}
 	if (host->data == NULL || cmd->error) {
 		host->mrq = NULL;
+		mod_timer(&host->clk_timer, jiffies + CLK_SHUTOFF_DELAY);
 		mmc_request_done(host->mmc, cmd->mrq);
 	}
 }
@@ -449,9 +520,7 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 	int ret;
 
 	/* Disable the clocks */
-	clk_disable(host->fclk);
-	clk_disable(host->iclk);
-	clk_disable(host->dbclk);
+	omap_mmc_clks_disable(host);
 
 	/* Turn the power off */
 	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -463,9 +532,8 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 	if (ret != 0)
 		goto err;
 
-	clk_enable(host->fclk);
-	clk_enable(host->iclk);
-	clk_enable(host->dbclk);
+	/* The next request will shut down the clocks lazily */
+	omap_mmc_clks_enable(host);
 
 	OMAP_HSMMC_WRITE(host->base, HCTL,
 		OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
@@ -693,13 +761,29 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
+	int ret;
 
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
+
+	ret = omap_mmc_clks_enable(host);
+	if (ret) {
+		host->cmd->error = ret;
+		mmc_omap_cmd_done(host, host->cmd);
+		return;
+	}
+
 	mmc_omap_prepare_data(host, req);
 	mmc_omap_start_command(host, req->cmd, req->data);
 }
 
+static void
+omap_hsmmc_clk_timer(unsigned long data)
+{
+	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
+	omap_mmc_clks_disable(host);
+}
+
 
 /* Routine to configure clock values. Exposed API to core */
 static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -879,6 +963,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		else
 			host->dbclk_enabled = 1;
 
+	host->clks_enabled = 1;
+
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
 	mmc->max_phys_segs = 1;
 	mmc->max_hw_segs = 1;
@@ -966,6 +1052,9 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 			goto err_cover_switch;
 	}
 
+	setup_timer(&host->clk_timer, omap_hsmmc_clk_timer,
+		    (unsigned long) host);
+
 	return 0;
 
 err_cover_switch:
@@ -981,11 +1070,10 @@ err_irq:
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
 	clk_put(host->iclk);
-	if (host->dbclk_enabled) {
+	if (host->dbclk_enabled)
 		clk_disable(host->dbclk);
+	if (!IS_ERR(host->dbclk))
 		clk_put(host->dbclk);
-	}
-
 err1:
 	iounmap(host->base);
 err:
@@ -1026,14 +1114,13 @@ static int omap_mmc_remove(struct platform_device *pdev)
 			free_irq(mmc_slot(host).card_detect_irq, host);
 		flush_scheduled_work();
 
-		clk_disable(host->fclk);
-		clk_disable(host->iclk);
+		del_timer(&host->clk_timer);
+		omap_mmc_clks_disable(host);
+
 		clk_put(host->fclk);
 		clk_put(host->iclk);
-		if (host->dbclk_enabled) {
-			clk_disable(host->dbclk);
+		if (!IS_ERR(host->dbclk))
 			clk_put(host->dbclk);
-		}
 
 		mmc_free_host(host->mmc);
 		iounmap(host->base);
@@ -1052,6 +1139,10 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 		return 0;
 
 	if (host) {
+		ret = omap_mmc_clks_enable(host);
+		if (ret)
+			return ret;
+
 		ret = mmc_suspend_host(host->mmc, state);
 		if (ret == 0) {
 			host->suspended = 1;
@@ -1080,11 +1171,8 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 				OMAP_HSMMC_WRITE(host->base, HCTL, hctl | SDBP);
 			}
 
-			clk_disable(host->fclk);
-			clk_disable(host->iclk);
-			clk_disable(host->dbclk);
+			omap_mmc_clks_disable(host);
 		}
-
 	}
 	return ret;
 }
@@ -1099,22 +1187,10 @@ static int omap_mmc_resume(struct platform_device *pdev)
 		return 0;
 
 	if (host) {
-
-		ret = clk_enable(host->fclk);
+		ret = omap_mmc_clks_enable(host);
 		if (ret)
 			goto clk_en_err;
 
-		ret = clk_enable(host->iclk);
-		if (ret) {
-			clk_disable(host->fclk);
-			clk_put(host->fclk);
-			goto clk_en_err;
-		}
-
-		if (clk_enable(host->dbclk) != 0)
-			dev_dbg(mmc_dev(host->mmc),
-					"Enabling debounce clk failed\n");
-
 		if (host->pdata->resume) {
 			ret = host->pdata->resume(&pdev->dev, host->slot_id);
 			if (ret)
-- 
1.5.6.5

