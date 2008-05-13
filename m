From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] TCM825x: Include invertation of image mirroring in
 configuration
Date: Tue, 13 May 2008 14:53:10 -0500
Message-ID: <e58577b9fd992a9839d909345f4c7b54@felipebalbi.com>
References: <12106946631016-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59659 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897AbYEMTxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 15:53:14 -0400
In-Reply-To: <12106946631016-git-send-email-sakari.ailus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap@vger.kernel.org



On Tue, 13 May 2008 19:04:21 +0300, Sakari Ailus <sakari.ailus@nokia.com>
wrote:
> Add invertation of image mirroring register bits to default
> configuration.
> 
> This is useful when the camera module is e.g. mounted upside down.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/media/video/tcm825x.c |    6 ++++++
>  drivers/media/video/tcm825x.h |    1 +
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/tcm825x.c
b/drivers/media/video/tcm825x.c
> index e57a646..216638e 100644
> --- a/drivers/media/video/tcm825x.c
> +++ b/drivers/media/video/tcm825x.c
> @@ -523,6 +523,9 @@ static int ioctl_g_ctrl(struct v4l2_int_device *s,
>  	if (val < 0)
>  		return val;
> 
> +	if (vc->id == V4L2_CID_HFLIP || vc->id == V4L2_CID_VFLIP)
> +		val ^= sensor->platform_data->is_upside_down();

you didnt put any implementation of this function, but i was wondering if
bit field would be enough?

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
> diff --git a/drivers/media/video/tcm825x.h
b/drivers/media/video/tcm825x.h
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
>  /* Array of image sizes supported by TCM825X.  These must be ordered
from
> --
> 1.5.0.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

