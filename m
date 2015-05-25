From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/5] mmc: omap_hsmmc: Change wake-up interrupt to use
 generic wakeirq
Date: Mon, 25 May 2015 10:38:31 +0200
Message-ID: <CAPDyKFqsfVL1SG2uuQRx3g=8DeJ4W_RhZwEEeQwFedhwOnBjXA@mail.gmail.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
	<1431560196-5722-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34579 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbEYIic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2015 04:38:32 -0400
Received: by qkgx75 with SMTP id x75so59680384qkg.1
        for <linux-omap@vger.kernel.org>; Mon, 25 May 2015 01:38:31 -0700 (PDT)
In-Reply-To: <1431560196-5722-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

On 14 May 2015 at 01:36, Tony Lindgren <tony@atomide.com> wrote:
> We can now use generic wakeirq handling and remove the custom handling
> for the wake-up interrupts.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Rafael, if you are fine with it, please take this one through your
linux-pm tree.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 51 +++++++------------------------------------
>  1 file changed, 8 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 9df2b68..5fbf4d8 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -43,6 +43,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/platform_data/hsmmc-omap.h>
>
>  /* OMAP HSMMC Host Controller Registers */
> @@ -218,7 +219,6 @@ struct omap_hsmmc_host {
>         unsigned int            flags;
>  #define AUTO_CMD23             (1 << 0)        /* Auto CMD23 support */
>  #define HSMMC_SDIO_IRQ_ENABLED (1 << 1)        /* SDIO irq enabled */
> -#define HSMMC_WAKE_IRQ_ENABLED (1 << 2)
>         struct omap_hsmmc_next  next_data;
>         struct  omap_hsmmc_platform_data        *pdata;
>
> @@ -1117,22 +1117,6 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
> -{
> -       struct omap_hsmmc_host *host = dev_id;
> -
> -       /* cirq is level triggered, disable to avoid infinite loop */
> -       spin_lock(&host->irq_lock);
> -       if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
> -               disable_irq_nosync(host->wake_irq);
> -               host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
> -       }
> -       spin_unlock(&host->irq_lock);
> -       pm_request_resume(host->dev); /* no use counter */
> -
> -       return IRQ_HANDLED;
> -}
> -
>  static void set_sd_bus_power(struct omap_hsmmc_host *host)
>  {
>         unsigned long i;
> @@ -1665,7 +1649,6 @@ static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>
>  static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>  {
> -       struct mmc_host *mmc = host->mmc;
>         int ret;
>
>         /*
> @@ -1677,11 +1660,7 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>         if (!host->dev->of_node || !host->wake_irq)
>                 return -ENODEV;
>
> -       /* Prevent auto-enabling of IRQ */
> -       irq_set_status_flags(host->wake_irq, IRQ_NOAUTOEN);
> -       ret = devm_request_irq(host->dev, host->wake_irq, omap_hsmmc_wake_irq,
> -                              IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -                              mmc_hostname(mmc), host);
> +       ret = dev_pm_request_wake_irq(host->dev, host->wake_irq, NULL, 0, NULL);
>         if (ret) {
>                 dev_err(mmc_dev(host->mmc), "Unable to request wake IRQ\n");
>                 goto err;
> @@ -1718,7 +1697,7 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>         return 0;
>
>  err_free_irq:
> -       devm_free_irq(host->dev, host->wake_irq, host);
> +       dev_pm_free_wake_irq(host->dev);
>  err:
>         dev_warn(host->dev, "no SDIO IRQ support, falling back to polling\n");
>         host->wake_irq = 0;
> @@ -2007,6 +1986,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 omap_hsmmc_ops.multi_io_quirk = omap_hsmmc_multi_io_quirk;
>         }
>
> +       device_init_wakeup(&pdev->dev, true);
>         pm_runtime_enable(host->dev);
>         pm_runtime_get_sync(host->dev);
>         pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
> @@ -2147,6 +2127,7 @@ err_slot_name:
>         if (host->use_reg)
>                 omap_hsmmc_reg_put(host);
>  err_irq:
> +       device_init_wakeup(&pdev->dev, false);
>         if (host->tx_chan)
>                 dma_release_channel(host->tx_chan);
>         if (host->rx_chan)
> @@ -2178,6 +2159,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
> +       device_init_wakeup(&pdev->dev, false);
>         if (host->dbclk)
>                 clk_disable_unprepare(host->dbclk);
>
> @@ -2204,11 +2186,6 @@ static int omap_hsmmc_suspend(struct device *dev)
>                                 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
>         }
>
> -       /* do not wake up due to sdio irq */
> -       if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
> -           !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
> -               disable_irq(host->wake_irq);
> -
>         if (host->dbclk)
>                 clk_disable_unprepare(host->dbclk);
>
> @@ -2233,11 +2210,6 @@ static int omap_hsmmc_resume(struct device *dev)
>                 omap_hsmmc_conf_bus_power(host);
>
>         omap_hsmmc_protect_card(host);
> -
> -       if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
> -           !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
> -               enable_irq(host->wake_irq);
> -
>         pm_runtime_mark_last_busy(host->dev);
>         pm_runtime_put_autosuspend(host->dev);
>         return 0;
> @@ -2277,10 +2249,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
>                 }
>
>                 pinctrl_pm_select_idle_state(dev);
> -
> -               WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
> -               enable_irq(host->wake_irq);
> -               host->flags |= HSMMC_WAKE_IRQ_ENABLED;
> +               dev_pm_enable_wake_irq(host->dev);
>         } else {
>                 pinctrl_pm_select_idle_state(dev);
>         }
> @@ -2302,11 +2271,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
>         spin_lock_irqsave(&host->irq_lock, flags);
>         if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
>             (host->flags & HSMMC_SDIO_IRQ_ENABLED)) {
> -               /* sdio irq flag can't change while in runtime suspend */
> -               if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
> -                       disable_irq_nosync(host->wake_irq);
> -                       host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
> -               }
> +               dev_pm_disable_wake_irq(host->dev);
>
>                 pinctrl_pm_select_default_state(host->dev);
>
> --
> 2.1.4
>
