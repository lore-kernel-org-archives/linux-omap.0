From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v4 4/5] OMAP_VOUT: Add support for DSI panels
Date: Thu, 29 Sep 2011 16:59:31 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECA5512D@dbde02.ent.ti.com>
References: <1317221368-3301-1-git-send-email-archit@ti.com>
 <1317221368-3301-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1317221368-3301-5-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Taneja, Archit
> Sent: Wednesday, September 28, 2011 8:19 PM
> To: Hiremath, Vaibhav
> Cc: Valkeinen, Tomi; linux-omap@vger.kernel.org; Semwal, Sumit; linux-
> media@vger.kernel.org; Taneja, Archit
> Subject: [PATCH v4 4/5] OMAP_VOUT: Add support for DSI panels
> 
> Add support for DSI panels. DSI video mode panels will work directly. For
> command mode panels, we will need to trigger updates regularly. This isn't
> done
> by the omap_vout driver currently. It can still be supported if we connect
> a
> framebuffer device to the panel and configure it in auto update mode.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/media/video/omap/omap_vout.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/omap/omap_vout.c
> b/drivers/media/video/omap/omap_vout.c
> index 6bc2620..65374b5 100644
> --- a/drivers/media/video/omap/omap_vout.c
> +++ b/drivers/media/video/omap/omap_vout.c
> @@ -590,6 +590,7 @@ static void omap_vout_isr(void *arg, unsigned int
> irqstatus)
>  	do_gettimeofday(&timevalue);
> 
>  	switch (cur_display->type) {
> +	case OMAP_DISPLAY_TYPE_DSI:
>  	case OMAP_DISPLAY_TYPE_DPI:
>  		if (mgr_id == OMAP_DSS_CHANNEL_LCD)
>  			irq = DISPC_IRQ_VSYNC;

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav


> --
> 1.7.1
