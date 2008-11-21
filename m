From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 7/9] OMAP: HSMMC: Use mod_timer from a single point for readability.
Date: Fri, 21 Nov 2008 11:52:20 +0200
Message-ID: <492684D4.1070100@nokia.com>
References: <49267E28.1020303@nokia.com> <49268161.1010304@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64949 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYKUJnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:43:53 -0500
In-Reply-To: <49268161.1010304@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Thu, 6 Nov 2008 16:02:30 +0200

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e329115..d81f9af 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -192,6 +192,11 @@ static void mmc_omap_idle_timer(unsigned long data)
 	mmc_omap_fclk_state(host, OFF);
 }
 
+static void mmc_omap_fclk_lazy_disable(struct mmc_omap_host *host)
+{
+	mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+}
+
 /*
  * Stop clock to the card
  */
@@ -332,7 +337,7 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 
 	if (!data->stop) {
 		host->mrq = NULL;
-		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+		mmc_omap_fclk_lazy_disable(host);
 		mmc_request_done(host->mmc, data->mrq);
 		return;
 	}
@@ -361,7 +366,7 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 	}
 	if (host->data == NULL || cmd->error) {
 		host->mrq = NULL;
-		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+		mmc_omap_fclk_lazy_disable(host);
 		mmc_request_done(host->mmc, cmd->mrq);
 	}
 }
@@ -577,7 +582,7 @@ static void mmc_omap_detect(struct work_struct *work)
 		while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD) ;
 		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
 	}
-	mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+	mmc_omap_fclk_lazy_disable(host);
 }
 
 /*
@@ -878,7 +883,7 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode == MMC_POWER_OFF)
 		mmc_omap_fclk_state(host, OFF);
 	else
-		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+		mmc_omap_fclk_lazy_disable(host);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
@@ -1093,7 +1098,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_cover_switch;
 	}
-	mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+	mmc_omap_fclk_lazy_disable(host);
 
 	return 0;
 
@@ -1233,7 +1238,6 @@ static int omap_mmc_resume(struct platform_device *pdev)
 		return 0;
 
 	if (host) {
-
 		if (mmc_omap_fclk_state(host, ON) != 0)
 			goto clk_en_err;
 
@@ -1260,7 +1264,7 @@ static int omap_mmc_resume(struct platform_device *pdev)
 		if (ret == 0)
 			host->suspended = 0;
 
-		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
+		mmc_omap_fclk_lazy_disable(host);
 	}
 
 	return ret;
-- 
1.5.4.3
