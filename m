From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v3 4/4] OMAP_VOUT: Don't trigger updates in
 omap_vout_probe
Date: Tue, 27 Sep 2011 11:56:02 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECA548BE@dbde02.ent.ti.com>
References: <1317038365-30650-1-git-send-email-archit@ti.com>
 <1317038365-30650-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1317038365-30650-5-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> -----Original Message-----
> From: Taneja, Archit
> Sent: Monday, September 26, 2011 5:29 PM
> To: Hiremath, Vaibhav
> Cc: Valkeinen, Tomi; linux-omap@vger.kernel.org; Semwal, Sumit; linux-
> media@vger.kernel.org; Taneja, Archit
> Subject: [PATCH v3 4/4] OMAP_VOUT: Don't trigger updates in
> omap_vout_probe
> 
> Remove the code in omap_vout_probe() which calls display->driver->update()
> for
> all the displays. This isn't correct because:
> 
> - An update in probe doesn't make sense, because we don't have any valid
> content
>   to show at this time.
> - Calling update for a panel which isn't enabled is not supported by DSS2.
> This
>   leads to a crash at probe.
> 
It should not crash, do you have crash log here?

Thanks,
Vaibhav

> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/media/video/omap/omap_vout.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/video/omap/omap_vout.c
> b/drivers/media/video/omap/omap_vout.c
> index 7b8e87a..3d9c83e 100644
> --- a/drivers/media/video/omap/omap_vout.c
> +++ b/drivers/media/video/omap/omap_vout.c
> @@ -2213,14 +2213,6 @@ static int __init omap_vout_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		goto probe_err2;
> 
> -	for (i = 0; i < vid_dev->num_displays; i++) {
> -		struct omap_dss_device *display = vid_dev->displays[i];
> -
> -		if (display->driver->update)
> -			display->driver->update(display, 0, 0,
> -					display->panel.timings.x_res,
> -					display->panel.timings.y_res);
> -	}
>  	return 0;
> 
>  probe_err2:
> --
> 1.7.1
