From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] drm/omap: tiler: add hibernation callback
Date: Wed, 18 Mar 2015 16:56:07 +0200
Message-ID: <55099207.3060006@linaro.org>
References: <1424887700-5909-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33161 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbbCRO4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 10:56:13 -0400
Received: by lbnq5 with SMTP id q5so3411064lbn.0
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2015 07:56:12 -0700 (PDT)
In-Reply-To: <1424887700-5909-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>
Cc: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>

Hi All,

On 02/25/2015 08:08 PM, grygorii.strashko@linaro.org wrote:
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
> ---
>   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> index 56c6055..afb8cfc 100644
> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> @@ -941,7 +941,7 @@ error:
>   }
>   #endif
>
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>   static int omap_dmm_resume(struct device *dev)
>   {
>   	struct tcm_area area;
> @@ -965,12 +965,10 @@ static int omap_dmm_resume(struct device *dev)
>
>   	return 0;
>   }
> -
> -static const struct dev_pm_ops omap_dmm_pm_ops = {
> -	.resume = omap_dmm_resume,
> -};
>   #endif
>
> +SIMPLE_DEV_PM_OPS(omap_dmm_pm_ops, NULL, omap_dmm_resume);
> +
>   #if defined(CONFIG_OF)
>   static const struct of_device_id dmm_of_match[] = {
>   	{ .compatible = "ti,omap4-dmm", },
> @@ -986,9 +984,7 @@ struct platform_driver omap_dmm_driver = {
>   		.owner = THIS_MODULE,
>   		.name = DMM_DRIVER_NAME,
>   		.of_match_table = of_match_ptr(dmm_of_match),
> -#ifdef CONFIG_PM
>   		.pm = &omap_dmm_pm_ops,
> -#endif
>   	},
>   };
>
>

Any comments on this?

-- 
regards,
-grygorii
