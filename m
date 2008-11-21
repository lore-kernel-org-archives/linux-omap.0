From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 3/9] OMAP: HSMMC: Make fclk disable request driven.
Date: Fri, 21 Nov 2008 11:24:35 +0200
Message-ID: <49267E53.3070607@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58310 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYKUJQe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:16:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Start idle timer only at the end of request or request like operation
such card detect, set_ios, probe, or resume. This will ensure the fclk is
disable quickly after the operation is done, but never too early.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2eed691..a134f76 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -122,7 +122,7 @@
 	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
 
 enum {OFF = 0, ON};
-#define IDLE_TIMEOUT (5*HZ)
+#define IDLE_TIMEOUT (jiffies_to_msecs(10))
 
 struct mmc_omap_host {
 	struct	device		*dev;
@@ -165,6 +165,7 @@ static int mmc_omap_fclk_state(struct mmc_omap_host *host, unsigned int state)
 	int ret = 0;
 
 	spin_lock_irqsave(&host->clk_lock, flags);
+	del_timer(&host->idle_timer);
 	if (host->fclk_enabled != state) {
 		if (state == ON) {
 			ret = clk_enable(host->fclk);
@@ -172,13 +173,9 @@ static int mmc_omap_fclk_state(struct mmc_omap_host *host, unsigned int state)
 				goto err_out;
 
 			dev_dbg(mmc_dev(host->mmc), "mmc_fclk: enabled\n");
-			/* Revisit: Change the timer bump based on real
-			   MMC usage characteristics */
-			mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
 		} else {
 			clk_disable(host->fclk);
 			dev_dbg(mmc_dev(host->mmc), "mmc_fclk: disabled\n");
-			del_timer(&host->idle_timer);
 		}
 		host->fclk_enabled = state;
 	}
@@ -335,6 +332,7 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 
 	if (!data->stop) {
 		host->mrq = NULL;
+		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
 		mmc_request_done(host->mmc, data->mrq);
 		return;
 	}
@@ -363,6 +361,7 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 	}
 	if (host->data == NULL || cmd->error) {
 		host->mrq = NULL;
+		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
 		mmc_request_done(host->mmc, cmd->mrq);
 	}
 }
@@ -575,6 +574,7 @@ static void mmc_omap_detect(struct work_struct *work)
 		while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD) ;
 		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
 	}
+	mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
 }
 
 /*
@@ -874,6 +874,8 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		mmc_omap_fclk_state(host, OFF);
+	else
+		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
@@ -1088,6 +1090,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_cover_switch;
 	}
+	mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
 
 	return 0;
 
@@ -1250,6 +1253,8 @@ static int omap_mmc_resume(struct platform_device *pdev)
 		ret = mmc_resume_host(host->mmc);
 		if (ret == 0)
 			host->suspended = 0;
+
+		mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
 	}
 
 	return ret;
-- 
1.5.4.3
