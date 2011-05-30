From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] media: omap3isp: fix format string warning
Date: Mon, 30 May 2011 16:57:36 +0200
Message-ID: <201105301657.36320.laurent.pinchart@ideasonboard.com>
References: <1306652691-21102-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1306652691-21102-1-git-send-email-ohad@wizery.com>
Sender: linux-media-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On Sunday 29 May 2011 09:04:51 Ohad Ben-Cohen wrote:
> Trivially fix this:
> 
> drivers/media/video/omap3isp/isp.c: In function 'isp_isr_dbg':
> drivers/media/video/omap3isp/isp.c:394: warning: zero-length gnu_printf
> format string

Thanks for the patch, but I've already applied something similar to my tree. 
Sorry :-)

> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/media/video/omap3isp/isp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/media/video/omap3isp/isp.c
> b/drivers/media/video/omap3isp/isp.c index 472a693..a0d5e69 100644
> --- a/drivers/media/video/omap3isp/isp.c
> +++ b/drivers/media/video/omap3isp/isp.c
> @@ -391,7 +391,7 @@ static inline void isp_isr_dbg(struct isp_device *isp,
> u32 irqstatus) };
>  	int i;
> 
> -	dev_dbg(isp->dev, "");
> +	dev_dbg(isp->dev, "%s\n", __func__);
> 
>  	for (i = 0; i < ARRAY_SIZE(name); i++) {
>  		if ((1 << i) & irqstatus)

-- 
Regards,

Laurent Pinchart
