From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: Use devm_kcalloc() in vrfb_probe()
Date: Thu, 11 May 2017 16:27:19 +0200
Message-ID: <1672837.1nPA5UjCzD@amdc3058>
References: <CGME20170426092018epcas4p343e69e32255faa796e7c55c3e89e40f2@epcas4p3.samsung.com>
 <4a7b1751-4319-4bde-cf26-2de2a4096c68@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <4a7b1751-4319-4bde-cf26-2de2a4096c68@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

On Wednesday, April 26, 2017 11:20:07 AM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 26 Apr 2017 11:08:30 +0200
> 
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "devm_kcalloc".
> 
> * Replace the specification of a data structure by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/video/fbdev/omap2/omapfb/vrfb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/vrfb.c b/drivers/video/fbdev/omap2/omapfb/vrfb.c
> index f346b02eee1d..54b51a7a290a 100644
> --- a/drivers/video/fbdev/omap2/omapfb/vrfb.c
> +++ b/drivers/video/fbdev/omap2/omapfb/vrfb.c
> @@ -358,11 +358,7 @@ static int __init vrfb_probe(struct platform_device *pdev)
>  		return PTR_ERR(vrfb_base);
>  
>  	num_ctxs = pdev->num_resources - 1;
> -
> -	ctxs = devm_kzalloc(&pdev->dev,
> -			sizeof(struct vrfb_ctx) * num_ctxs,
> -			GFP_KERNEL);
> -
> +	ctxs = devm_kcalloc(&pdev->dev, num_ctxs, sizeof(*ctxs), GFP_KERNEL);

This change makes the resulting binary larger by 24 bytes (probably
because of the need to have an additional function argument) and
I don't see an improvement from a security POV (pdev->num_resources
is based on the size of static tables from arch/arm/mach-omap2/fb.c).

I'm sorry but I'm not applying this patch.

>  	if (!ctxs)
>  		return -ENOMEM;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
