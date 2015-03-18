From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/omap: tiler: add hibernation callback
Date: Wed, 18 Mar 2015 12:04:38 -0400
Message-ID: <CAF6AEGvdsQGDP8dLxU8ew1JQ9xmAf66zCwfRVW2-TTdXK5Va-Q@mail.gmail.com>
References: <1424887700-5909-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:34522 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbbCRQEi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 12:04:38 -0400
Received: by qcaz10 with SMTP id z10so42226324qca.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2015 09:04:38 -0700 (PDT)
In-Reply-To: <1424887700-5909-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, "Menon, Nishanth" <nm@ti.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On Wed, Feb 25, 2015 at 1:08 PM,  <grygorii.strashko@linaro.org> wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Setting a dev_pm_ops resume callback but not a set of
> hibernation handler means that pm function will not be
> called upon hibernation.
> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
> assigns the suspend and hibernation handlers and move
> omap_dmm_resume under CONFIG_PM_SLEEP to avoid build warnings.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> index 56c6055..afb8cfc 100644
> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> @@ -941,7 +941,7 @@ error:
>  }
>  #endif
>
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int omap_dmm_resume(struct device *dev)
>  {
>         struct tcm_area area;
> @@ -965,12 +965,10 @@ static int omap_dmm_resume(struct device *dev)
>
>         return 0;
>  }
> -
> -static const struct dev_pm_ops omap_dmm_pm_ops = {
> -       .resume = omap_dmm_resume,
> -};
>  #endif
>
> +SIMPLE_DEV_PM_OPS(omap_dmm_pm_ops, NULL, omap_dmm_resume);
> +
>  #if defined(CONFIG_OF)
>  static const struct of_device_id dmm_of_match[] = {
>         { .compatible = "ti,omap4-dmm", },
> @@ -986,9 +984,7 @@ struct platform_driver omap_dmm_driver = {
>                 .owner = THIS_MODULE,
>                 .name = DMM_DRIVER_NAME,
>                 .of_match_table = of_match_ptr(dmm_of_match),
> -#ifdef CONFIG_PM
>                 .pm = &omap_dmm_pm_ops,
> -#endif
>         },
>  };
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
