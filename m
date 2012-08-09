From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: omapdrm: Fix DMM sparse warnings
Date: Thu, 9 Aug 2012 11:56:16 -0500
Message-ID: <CAF6AEGtVAGHd__H5_JQ0+FrYTkz7A6C4c1yr_=X_X_KbYuvM4g@mail.gmail.com>
References: <1344489296-16722-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63211 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2HIQ4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 12:56:17 -0400
Received: by vbbff1 with SMTP id ff1so164617vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Aug 2012 09:56:16 -0700 (PDT)
In-Reply-To: <1344489296-16722-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Gross <andy.gross@ti.com>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <greg@kroah.com>

On Thu, Aug 9, 2012 at 12:14 AM, Andy Gross <andy.gross@ti.com> wrote:
> Fix the following sparse warnings:
>
> drivers/staging/omapdrm/omap_dmm_tiler.c:123:13:
>    warning: symbol 'omap_dmm_irq_handler' was not declared.
>    Should it be static?
>
> drivers/staging/omapdrm/omap_dmm_tiler.c:370:24:
>    warning: Using plain integer as NULL pointer
>
> Signed-off-by: Andy Gross <andy.gross@ti.com>

Signed-off-by: Rob Clark <rob.clark@linaro.org>

> ---
>  drivers/staging/omapdrm/omap_dmm_tiler.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
> index 8619783..ec7a5c8 100644
> --- a/drivers/staging/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
> @@ -120,7 +120,7 @@ static int wait_status(struct refill_engine *engine, uint32_t wait_mask)
>         return 0;
>  }
>
> -irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
> +static irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
>  {
>         struct dmm *dmm = arg;
>         uint32_t status = readl(dmm->base + DMM_PAT_IRQSTATUS);
> @@ -367,7 +367,7 @@ struct tiler_block *tiler_reserve_1d(size_t size)
>         int num_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>
>         if (!block)
> -               return 0;
> +               return ERR_PTR(-ENOMEM);
>
>         block->fmt = TILFMT_PAGE;
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
