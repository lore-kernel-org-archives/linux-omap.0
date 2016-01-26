From: Tony Lindgren <tony@atomide.com>
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Tue, 26 Jan 2016 14:48:05 -0800
Message-ID: <20160126224804.GB19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
PM states at probe error and driver unbind") broke PM on at least
omap3. It seems we now need to additionally also call
pm_runtime_dont_use_autosuspend() to get things working again?

The following fixes idling on omap3, but I'm wondering if we
should do something in pm_runtime_reinit() instead?

Regards,

Tony

8< ---------------------
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2232,6 +2232,7 @@ err_irq:
 		dma_release_channel(host->tx_chan);
 	if (host->rx_chan)
 		dma_release_channel(host->rx_chan);
+	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	if (host->dbclk)
