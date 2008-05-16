From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] TCM825x: Include invertation of image mirroring in
	configuration
Date: Fri, 16 May 2008 10:42:07 -0700
Message-ID: <20080516174207.GM23002@atomide.com>
References: <482AD555.40905@nokia.com> <12107667331990-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59179 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYEPRmG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 13:42:06 -0400
Content-Disposition: inline
In-Reply-To: <12107667331990-git-send-email-sakari.ailus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@nokia.com> [080514 06:37]:
> Add invertation of image mirroring register bits to default
> configuration.
> 
> This is useful when the camera module is e.g. mounted upside down.

Pushing today.

Tony

> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/media/video/tcm825x.c |    6 ++++++
>  drivers/media/video/tcm825x.h |    1 +
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/tcm825x.c b/drivers/media/video/tcm825x.c
> index e57a646..216638e 100644
> --- a/drivers/media/video/tcm825x.c
> +++ b/drivers/media/video/tcm825x.c
> @@ -523,6 +523,9 @@ static int ioctl_g_ctrl(struct v4l2_int_device *s,
>  	if (val < 0)
>  		return val;
>  
> +	if (vc->id == V4L2_CID_HFLIP || vc->id == V4L2_CID_VFLIP)
> +		val ^= sensor->platform_data->is_upside_down();
> +
>  	vc->value = val;
>  	return 0;
>  }
> @@ -556,6 +559,9 @@ static int ioctl_s_ctrl(struct v4l2_int_device *s,
>  	if (lvc == NULL)
>  		return -EINVAL;
>  
> +	if (vc->id == V4L2_CID_HFLIP || vc->id == V4L2_CID_VFLIP)
> +		val ^= sensor->platform_data->is_upside_down();
> +
>  	val = val << lvc->start_bit;
>  	if (tcm825x_write_reg_mask(client, lvc->reg, val))
>  		return -EIO;
> diff --git a/drivers/media/video/tcm825x.h b/drivers/media/video/tcm825x.h
> index 966765b..770ebac 100644
> --- a/drivers/media/video/tcm825x.h
> +++ b/drivers/media/video/tcm825x.h
> @@ -182,6 +182,7 @@ struct tcm825x_platform_data {
>  	int (*needs_reset)(struct v4l2_int_device *s, void *buf,
>  			   struct v4l2_pix_format *fmt);
>  	int (*ifparm)(struct v4l2_ifparm *p);
> +	int (*is_upside_down)(void);
>  };
>  
>  /* Array of image sizes supported by TCM825X.  These must be ordered from
> -- 
> 1.5.0.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
