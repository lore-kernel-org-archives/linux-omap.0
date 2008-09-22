From: kucheria.amit@gmail.com
Subject: [PATCH 2/2] [PATCH] HSMMC: Make driver support dynamic idle
Date: Mon, 22 Sep 2008 10:23:09 +0300
Message-ID: <1222068189-10683-1-git-send-email-kucheria.amit@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62095 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbYIVHXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 03:23:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Amit Kucheria <amit.kucheria@verdurent.com>

From: Amit Kucheria <amit.kucheria@verdurent.com>

Add a timer that is kept active by MMC requests. FCLK is disabled on timeout

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
---
 drivers/mmc/host/omap_hsmmc.c |   71 +++++++++++++++++++++++++++++++++-------
 1 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 997f0dc..8c17291 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -110,6 +110,9 @@
 #define OMAP_HSMMC_WRITE(base, reg, val) \
 	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
 
+enum {OFF=0, ON};
+#define IDLE_TIMEOUT (5*HZ)
+
 struct mmc_omap_host {
 	struct	device		*dev;
 	struct	mmc_host	*mmc;
@@ -137,9 +140,49 @@ struct mmc_omap_host {
 	int			initstr;
 	int			slot_id;
 	int			dbclk_enabled;
+
+	struct timer_list       idle_timer;
+	spinlock_t		clk_lock;     /* for changing enabled state */
+	int			fclk_enabled:1;
+
 	struct	omap_mmc_platform_data	*pdata;
 };
 
+int mmc_omap_fclk_state(struct mmc_omap_host *host, unsigned int state)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&host->clk_lock, flags);
+	if (host->fclk_enabled != state) {
+		if (state == ON) {
+			if (host->fclk_enabled == OFF) {
+				ret = clk_enable(host->fclk);
+				if (ret != 0)
+					return ret;
+				dev_dbg(mmc_dev(host->mmc), "mmc_fclk: enabled\n");
+			}
+			/* Revisit: Change the timer bump based on real MMC usage characteristics */
+			mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+		}
+		else {
+			clk_disable(host->fclk);
+			dev_dbg(mmc_dev(host->mmc), "mmc_fclk: disabled\n");
+			del_timer(&host->idle_timer);
+		}
+		host->fclk_enabled = state;
+	}
+	spin_unlock_irqrestore(&host->clk_lock, flags);
+	return 0;
+}
+
+static void mmc_omap_idle_timer(unsigned long data)
+{
+	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
+
+	mmc_omap_fclk_state(host, OFF);
+}
+
 /*
  * Stop clock to the card
  */
@@ -441,7 +484,7 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 	int ret;
 
 	/* Disable the clocks */
-	clk_disable(host->fclk);
+	mmc_omap_fclk_state(host, OFF);
 	clk_disable(host->iclk);
 	clk_disable(host->dbclk);
 
@@ -455,7 +498,7 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 	if (ret != 0)
 		goto err;
 
-	clk_enable(host->fclk);
+	mmc_omap_fclk_state(host, ON);
 	clk_enable(host->iclk);
 	clk_enable(host->dbclk);
 
@@ -689,10 +732,10 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
 	mmc_omap_prepare_data(host, req);
+	mmc_omap_fclk_state(host, ON);
 	mmc_omap_start_command(host, req->cmd, req->data);
 }
 
-
 /* Routine to configure clock values. Exposed API to core */
 static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
@@ -771,6 +814,7 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
 		OMAP_HSMMC_WRITE(host->base, CON,
 				OMAP_HSMMC_READ(host->base, CON) | OD);
+
 }
 /* NOTE: Read only switch not supported yet */
 static struct mmc_host_ops mmc_omap_ops = {
@@ -784,7 +828,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
-	int ret = 0, irq;
+	int ret = 0, irq, reg;
 	u32 hctl, capa;
 
 	if (pdata == NULL) {
@@ -843,14 +887,16 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	if (clk_enable(host->fclk) != 0) {
+	spin_lock_init(&host->clk_lock);
+	setup_timer(&host->idle_timer, mmc_omap_idle_timer, (unsigned long) host);
+
+	if (mmc_omap_fclk_state(host, ON) != 0) {
 		clk_put(host->iclk);
 		clk_put(host->fclk);
 		goto err1;
 	}
-
 	if (clk_enable(host->iclk) != 0) {
-		clk_disable(host->fclk);
+		mmc_omap_fclk_state(host, OFF);
 		clk_put(host->iclk);
 		clk_put(host->fclk);
 		goto err1;
@@ -965,7 +1011,7 @@ err_irq_cd_init:
 err_irq_cd:
 	free_irq(host->irq, host);
 err_irq:
-	clk_disable(host->fclk);
+	mmc_omap_fclk_state(host, OFF);
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
 	clk_put(host->iclk);
@@ -1014,7 +1060,7 @@ static int omap_mmc_remove(struct platform_device *pdev)
 			free_irq(mmc_slot(host).card_detect_irq, host);
 		flush_scheduled_work();
 
-		clk_disable(host->fclk);
+		mmc_omap_fclk_state(host, OFF);
 		clk_disable(host->iclk);
 		clk_put(host->fclk);
 		clk_put(host->iclk);
@@ -1067,7 +1113,7 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 					| SDBP);
 			}
 
-			clk_disable(host->fclk);
+			mmc_omap_fclk_state(host, OFF);
 			clk_disable(host->iclk);
 			clk_disable(host->dbclk);
 		}
@@ -1087,13 +1133,12 @@ static int omap_mmc_resume(struct platform_device *pdev)
 
 	if (host) {
 
-		ret = clk_enable(host->fclk);
-		if (ret)
+		if (mmc_omap_fclk_state(host, ON) != 0)
 			goto clk_en_err;
 
 		ret = clk_enable(host->iclk);
 		if (ret) {
-			clk_disable(host->fclk);
+			mmc_omap_fclk_state(host, OFF);
 			clk_put(host->fclk);
 			goto clk_en_err;
 		}
-- 
1.5.6.3

