From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq
Date: Thu,  5 Mar 2015 16:34:09 -0800
Message-ID: <1425602049-2674-5-git-send-email-tony@atomide.com>
References: <1425602049-2674-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery1.ore.mailhop.org ([54.149.155.156]:35747 "EHLO
	pmta2.delivery1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753739AbbCFAuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 19:50:05 -0500
In-Reply-To: <1425602049-2674-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

We can now use generic wakeirq handling and remove the custom handling
for the wake-up interrupts.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c | 55 +++++++++++--------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f84cfb0..32f4559 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -43,6 +43,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/platform_data/hsmmc-omap.h>
 
 /* OMAP HSMMC Host Controller Registers */
@@ -205,6 +206,7 @@ struct omap_hsmmc_host {
 	u32			capa;
 	int			irq;
 	int			wake_irq;
+	struct wakeirq_source	*wirq;
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
@@ -218,7 +220,6 @@ struct omap_hsmmc_host {
 	unsigned int		flags;
 #define AUTO_CMD23		(1 << 0)        /* Auto CMD23 support */
 #define HSMMC_SDIO_IRQ_ENABLED	(1 << 1)        /* SDIO irq enabled */
-#define HSMMC_WAKE_IRQ_ENABLED	(1 << 2)
 	struct omap_hsmmc_next	next_data;
 	struct	omap_hsmmc_platform_data	*pdata;
 
@@ -1135,22 +1136,6 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
-{
-	struct omap_hsmmc_host *host = dev_id;
-
-	/* cirq is level triggered, disable to avoid infinite loop */
-	spin_lock(&host->irq_lock);
-	if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
-		disable_irq_nosync(host->wake_irq);
-		host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
-	}
-	spin_unlock(&host->irq_lock);
-	pm_request_resume(host->dev); /* no use counter */
-
-	return IRQ_HANDLED;
-}
-
 static void set_sd_bus_power(struct omap_hsmmc_host *host)
 {
 	unsigned long i;
@@ -1695,7 +1680,6 @@ static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 {
-	struct mmc_host *mmc = host->mmc;
 	int ret;
 
 	/*
@@ -1707,11 +1691,12 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 	if (!host->dev->of_node || !host->wake_irq)
 		return -ENODEV;
 
-	/* Prevent auto-enabling of IRQ */
-	irq_set_status_flags(host->wake_irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(host->dev, host->wake_irq, omap_hsmmc_wake_irq,
-			       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-			       mmc_hostname(mmc), host);
+	host->wirq = devm_kzalloc(host->dev, sizeof(*host->wirq),
+				  GFP_KERNEL);
+	if (!host->wirq)
+		return -ENOMEM;
+	ret = dev_pm_wakeirq_request(host->dev, host->wake_irq, NULL, 0, NULL,
+				     host->wirq);
 	if (ret) {
 		dev_err(mmc_dev(host->mmc), "Unable to request wake IRQ\n");
 		goto err;
@@ -1748,7 +1733,7 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 	return 0;
 
 err_free_irq:
-	devm_free_irq(host->dev, host->wake_irq, host);
+	dev_pm_wakeirq_free(host->wirq);
 err:
 	dev_warn(host->dev, "no SDIO IRQ support, falling back to polling\n");
 	host->wake_irq = 0;
@@ -2254,10 +2239,10 @@ static int omap_hsmmc_suspend(struct device *dev)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
 
-	/* do not wake up due to sdio irq */
 	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
-	    !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
-		disable_irq(host->wake_irq);
+	    (host->flags & HSMMC_SDIO_IRQ_ENABLED) &&
+	    (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
+		dev_pm_wakeirq_arm_for_suspend(host->wirq);
 
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
@@ -2283,11 +2268,6 @@ static int omap_hsmmc_resume(struct device *dev)
 		omap_hsmmc_conf_bus_power(host);
 
 	omap_hsmmc_protect_card(host);
-
-	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
-	    !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
-		enable_irq(host->wake_irq);
-
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
 	return 0;
@@ -2331,10 +2311,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 		}
 
 		pinctrl_pm_select_idle_state(dev);
-
-		WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
-		enable_irq(host->wake_irq);
-		host->flags |= HSMMC_WAKE_IRQ_ENABLED;
+		dev_pm_wakeirq_enable(host->wirq);
 	} else {
 		pinctrl_pm_select_idle_state(dev);
 	}
@@ -2356,11 +2333,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&host->irq_lock, flags);
 	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
 	    (host->flags & HSMMC_SDIO_IRQ_ENABLED)) {
-		/* sdio irq flag can't change while in runtime suspend */
-		if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
-			disable_irq_nosync(host->wake_irq);
-			host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
-		}
+		dev_pm_wakeirq_disable(host->wirq);
 
 		pinctrl_pm_select_default_state(host->dev);
 
-- 
2.1.4

