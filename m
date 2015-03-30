From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6] mmc: omap_hsmmc: use generic slot-gpio isr to manage
 card detect pin
Date: Mon, 30 Mar 2015 11:34:46 +0200
Message-ID: <CAPDyKFqu-ThZg2Qp7WaNf1F0fTj0Mty96M2LctJT2kWSHS+Y1A@mail.gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
	<1425385698-6588-7-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1425385698-6588-7-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 3 March 2015 at 13:28, Andreas Fenkart <afenkart@gmail.com> wrote:
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

Thanks! Applied.

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4f6fbe5..0c3368e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -418,7 +418,6 @@ static inline int omap_hsmmc_have_reg(void)
>
>  #endif
>
> -static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id);
>  static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id);
>
>  static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
> @@ -440,7 +439,6 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
>                         return ret;
>
>                 host->card_detect = omap_hsmmc_card_detect;
> -               mmc_gpio_set_cd_isr(mmc, omap_hsmmc_detect);
>         }
>
>         if (gpio_is_valid(pdata->gpio_wp)) {
> @@ -1247,17 +1245,6 @@ static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -/*
> - * irq handler to notify the core about card insertion/removal
> - */
> -static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
> -{
> -       struct omap_hsmmc_host *host = dev_id;
> -
> -       mmc_detect_change(host->mmc, (HZ * 200) / 1000);
> -       return IRQ_HANDLED;
> -}
> -
>  static void omap_hsmmc_dma_callback(void *param)
>  {
>         struct omap_hsmmc_host *host = param;
> --
> 2.1.4
>
