From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omapfb: Fix argument of blank operation.
Date: Wed, 26 Nov 2008 09:35:47 -0800
Message-ID: <20081126173546.GQ11997@atomide.com>
References: <1227641052-6510-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52155 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbYKZRfq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 12:35:46 -0500
Content-Disposition: inline
In-Reply-To: <1227641052-6510-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@nokia.com> [081125 11:24]:
> The blank operation should receive FB_BLANK_POWERDOWN, not
> VESA_POWERDOWN.

Here's my canned fbdev reply for this tread too:

Guys, please take this discussion to fbdev mailing list and cc
linux-omap list. I'm not going to push any more omap fbdev patches,
so please send the patches against mainline kernel to fbdev list.

Regards,

Tony


> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> ---
>  drivers/video/omap/omapfb_main.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index 3bb4247..c8db8b2 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -348,7 +348,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
>  
>  	omapfb_rqueue_lock(fbdev);
>  	switch (blank) {
> -	case VESA_NO_BLANKING:
> +	case FB_BLANK_UNBLANK:
>  		if (fbdev->state == OMAPFB_SUSPENDED) {
>  			if (fbdev->ctrl->resume)
>  				fbdev->ctrl->resume();
> @@ -359,7 +359,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
>  				do_update = 1;
>  		}
>  		break;
> -	case VESA_POWERDOWN:
> +	case FB_BLANK_POWERDOWN:
>  		if (fbdev->state == OMAPFB_ACTIVE) {
>  			fbdev->panel->disable(fbdev->panel);
>  			if (fbdev->ctrl->suspend)
> @@ -1842,7 +1842,7 @@ static int omapfb_suspend(struct platform_device *pdev, pm_message_t mesg)
>  	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
>  
>  	if (fbdev != NULL)
> -		omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
> +		omapfb_blank(FB_BLANK_POWERDOWN, fbdev->fb_info[0]);
>  	return 0;
>  }
>  
> @@ -1852,7 +1852,7 @@ static int omapfb_resume(struct platform_device *pdev)
>  	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
>  
>  	if (fbdev != NULL)
> -		omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
> +		omapfb_blank(FB_BLANK_UNBLANK, fbdev->fb_info[0]);
>  	return 0;
>  }
>  
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
