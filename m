From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [RFC/PATCH] mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete
Date: Tue, 6 Nov 2012 21:20:04 +0530
Message-ID: <CAOyx1Lr1g=5RrOZdUiUcgWU0wjoNnpzH6Hr5JfqK8s0n5uoShw@mail.gmail.com>
References: <1350910768-8522-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1350910768-8522-1-git-send-email-balbi@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 22, 2012 at 6:29 PM, Felipe Balbi <balbi@ti.com> wrote:
> prepare() is supposed to prevent new children from
> being registered. On the MMC subsystem, children
> (new cards) registration starts with the card
> detect IRQ.
>
> Move card detect IRQ disabling to prepare() so that
> no new cards will be registered while we're trying
> to suspend.
>
> Likewise, move card detect IRQ enabling to complete()
> so we only try to register new children after our MMC
> IP is back up.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> Venkat, do you think the patch below makes sense ?

Except for the minor nit mentioned below, it works well.
I'll include it in my patch series.

>
> cheers
>
>  drivers/mmc/host/omap_hsmmc.c | 45 ++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 54bfd0c..4c8b41e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2022,6 +2022,26 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
>  }
>
>  #ifdef CONFIG_PM
> +static int omap_hsmmc_prepare(struct device *dev)
> +{
> +       struct omap_hsmmc_host *host = dev_get_drvdata(dev);
> +
> +       if (host->pdata->suspend)
> +               return host->pdata->suspend(dev, host->slot_id);
> +
> +       return 0;
> +}
> +
> +static int omap_hsmmc_complete(struct device *dev)

The .complete() function prototype requires to return void.
This one emits a compilation warning.
