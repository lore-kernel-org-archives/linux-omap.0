From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 26 Jan 2016 14:50:13 -0800
Message-ID: <20160126225013.GC19432@atomide.com>
References: <20160126224804.GB19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160126224804.GB19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160126 14:49]:
> Hi,
> 
> Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
> PM states at probe error and driver unbind") broke PM on at least
> omap3. It seems we now need to additionally also call
> pm_runtime_dont_use_autosuspend() to get things working again?
> 
> The following fixes idling on omap3, but I'm wondering if we
> should do something in pm_runtime_reinit() instead?

Oh one more thing, this happens as we get -EPROBE_DEFER with
the regulators initially.

> 8< ---------------------
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2232,6 +2232,7 @@ err_irq:
>  		dma_release_channel(host->tx_chan);
>  	if (host->rx_chan)
>  		dma_release_channel(host->rx_chan);
> +	pm_runtime_dont_use_autosuspend(host->dev);
>  	pm_runtime_put_sync(host->dev);
>  	pm_runtime_disable(host->dev);
>  	if (host->dbclk)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
