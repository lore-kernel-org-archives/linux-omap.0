From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH RESEND] fbdev: omapfb: remove unused variable
Date: Wed, 26 Jul 2017 16:27:30 +0200
Message-ID: <10646277.hB6jvi1uWb@amdc3058>
References: <CGME20170726135825epcas4p3c5326b3893927c4be0db0fde076d0799@epcas4p3.samsung.com>
        <20170726135816.2216688-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170726135816.2216688-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

On Wednesday, July 26, 2017 03:57:55 PM Arnd Bergmann wrote:
> Removing the default display name left a harmless warning:
> 
> fbdev/omap2/omapfb/dss/core.c: In function 'omap_dss_probe':
> fbdev/omap2/omapfb/dss/core.c:196:30: error: unused variable 'pdata' [-Werror=unused-variable]
> 
> This removes the now-unused variable as well.
> 
> Fixes: 278cba7eaf54 ("drm: omapdrm: Remove unused default display name support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Originally submitted on June 9, no reply other than the Reviewed-by tag.
> The patch is still needed

It is not lost and will be queued for 4.13 fbdev fixes pull request.

[ The guilty commit went through DRM tree and pulling it into fbdev
  tree just to fix the warning was not feasible.. ]

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
> index eecf695c16f4..09e5bb013d28 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
> @@ -193,7 +193,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
>  
>  static int __init omap_dss_probe(struct platform_device *pdev)
>  {
> -	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
>  	int r;
>  
>  	core.pdev = pdev;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
