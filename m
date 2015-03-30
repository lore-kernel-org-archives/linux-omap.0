From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/6] mmc: omap_hsmmc: simplify card/cover detect isr
Date: Mon, 30 Mar 2015 11:34:31 +0200
Message-ID: <CAPDyKFqsw9f+UKdQMyMZ3qDocC6YbwwjA8chJfWTH7+5+Gm=YQ@mail.gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
	<1425385698-6588-6-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:35697 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbC3Jeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2015 05:34:31 -0400
Received: by qcfy6 with SMTP id y6so45902082qcf.2
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2015 02:34:31 -0700 (PDT)
In-Reply-To: <1425385698-6588-6-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>

On 3 March 2015 at 13:28, Andreas Fenkart <afenkart@gmail.com> wrote:
> strip the card dectet logic from cover detect isr and vice versa
> the generic mmc_gpio_cd_irqt isr, uses 200ms on removal/insertion,
> hence that should be fine here as well
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

Thanks! Applied.

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 27 +++------------------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index ed68e55..4f6fbe5 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1239,21 +1239,11 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
>  static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id)
>  {
>         struct omap_hsmmc_host *host = dev_id;
> -       int carddetect;
>
>         sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
>
> -       if (host->card_detect) {
> -               carddetect = host->card_detect(host->dev);
> -       } else {
> -               omap_hsmmc_protect_card(host);
> -               carddetect = -ENOSYS;
> -       }
> -
> -       if (carddetect)
> -               mmc_detect_change(host->mmc, (HZ * 200) / 1000);
> -       else
> -               mmc_detect_change(host->mmc, (HZ * 50) / 1000);
> +       omap_hsmmc_protect_card(host);
> +       mmc_detect_change(host->mmc, (HZ * 200) / 1000);
>         return IRQ_HANDLED;
>  }
>
> @@ -1263,19 +1253,8 @@ static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id)
>  static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
>  {
>         struct omap_hsmmc_host *host = dev_id;
> -       int carddetect;
> -
> -       if (host->card_detect)
> -               carddetect = host->card_detect(host->dev);
> -       else {
> -               omap_hsmmc_protect_card(host);
> -               carddetect = -ENOSYS;
> -       }
>
> -       if (carddetect)
> -               mmc_detect_change(host->mmc, (HZ * 200) / 1000);
> -       else
> -               mmc_detect_change(host->mmc, (HZ * 50) / 1000);
> +       mmc_detect_change(host->mmc, (HZ * 200) / 1000);
>         return IRQ_HANDLED;
>  }
>
> --
> 2.1.4
>
