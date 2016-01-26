From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Wed, 27 Jan 2016 00:14:54 +0100
Message-ID: <CAJZ5v0i79X5JjOZiu4cOZ0Esd5BxAvutF8d17asDzq9ECcML-g@mail.gmail.com>
References: <20160126224804.GB19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160126224804.GB19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 26, 2016 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
> PM states at probe error and driver unbind") broke PM on at least
> omap3. It seems we now need to additionally also call
> pm_runtime_dont_use_autosuspend() to get things working again?
>
> The following fixes idling on omap3, but I'm wondering if we
> should do something in pm_runtime_reinit() instead?

Well, does it actually help if you add
pm_runtime_dont_use_autosuspend(dev) to pm_runtime_reinit()?

> 8< ---------------------
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2232,6 +2232,7 @@ err_irq:
>                 dma_release_channel(host->tx_chan);
>         if (host->rx_chan)
>                 dma_release_channel(host->rx_chan);
> +       pm_runtime_dont_use_autosuspend(host->dev);
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
>         if (host->dbclk)
> --


Thanks,
Rafael
