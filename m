From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 2/9] OMAP: HSMMC: Ensure fclk is running before accessing
 HSMMC registers
Date: Fri, 21 Nov 2008 11:24:21 +0200
Message-ID: <49267E45.8040804@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58315 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYKUJQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:16:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ee21a64..2eed691 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -154,26 +154,24 @@ struct mmc_omap_host {
 
 	struct timer_list       idle_timer;
 	spinlock_t		clk_lock;     /* for changing enabled state */
-	int			fclk_enabled:1;
+	unsigned int		fclk_enabled:1;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
 
-int mmc_omap_fclk_state(struct mmc_omap_host *host, unsigned int state)
+static int mmc_omap_fclk_state(struct mmc_omap_host *host, unsigned int state)
 {
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&host->clk_lock, flags);
 	if (host->fclk_enabled != state) {
 		if (state == ON) {
-			if (host->fclk_enabled == OFF) {
-				ret = clk_enable(host->fclk);
-				if (ret != 0)
-					return ret;
-				dev_dbg(mmc_dev(host->mmc),
-					"mmc_fclk: enabled\n");
-			}
+			ret = clk_enable(host->fclk);
+			if (ret != 0)
+				goto err_out;
+
+			dev_dbg(mmc_dev(host->mmc), "mmc_fclk: enabled\n");
 			/* Revisit: Change the timer bump based on real
 			   MMC usage characteristics */
 			mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
@@ -184,8 +182,10 @@ int mmc_omap_fclk_state(struct mmc_omap_host *host, unsigned int state)
 		}
 		host->fclk_enabled = state;
 	}
+
+err_out:
 	spin_unlock_irqrestore(&host->clk_lock, flags);
-	return 0;
+	return ret;
 }
 
 static void mmc_omap_idle_timer(unsigned long data)
@@ -557,6 +557,7 @@ static void mmc_omap_detect(struct work_struct *work)
 						mmc_carddetect_work);
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
+	mmc_omap_fclk_state(host, ON);
 	if (host->carddetect) {
 		if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
 			/*
@@ -785,8 +786,8 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
-	mmc_omap_prepare_data(host, req);
 	mmc_omap_fclk_state(host, ON);
+	mmc_omap_prepare_data(host, req);
 	mmc_omap_start_command(host, req->cmd, req->data);
 }
 
@@ -798,6 +799,8 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	unsigned long regval;
 	unsigned long timeout;
 
+	mmc_omap_fclk_state(host, ON);
+
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -869,6 +872,8 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		OMAP_HSMMC_WRITE(host->base, CON,
 				OMAP_HSMMC_READ(host->base, CON) | OD);
 
+	if (ios->power_mode == MMC_POWER_OFF)
+		mmc_omap_fclk_state(host, OFF);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
@@ -1120,6 +1125,7 @@ static int omap_mmc_remove(struct platform_device *pdev)
 	struct resource *res;
 	u16 vdd = 0;
 
+	mmc_omap_fclk_state(host, ON);
 	if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
 	/*
 	 * Set the vdd back to 3V,
@@ -1170,6 +1176,8 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 		return 0;
 
 	if (host) {
+		mmc_omap_fclk_state(host, ON);
+
 		ret = mmc_suspend_host(host->mmc, state);
 		if (ret == 0) {
 			host->suspended = 1;
-- 
1.5.4.3
