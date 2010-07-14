From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] OMAP: DSS2: Fix error path in omap_dsi_update()
Date: Wed, 14 Jul 2010 11:01:01 -0500
Message-ID: <4C3DDF3D.7010609@ti.com>
References: <1279109510-12992-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41612 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab0GNQBH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jul 2010 12:01:07 -0400
In-Reply-To: <1279109510-12992-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Taneja, Archit had written, on 07/14/2010 07:11 AM, the following:
> In the case of an error on calling dsi_update_screen_l4(), a
> successful framedone callback is still sent to panel-taal. An
> error should be returned to taal_update() instead.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> v2: This fixes a compilation warning seen after
> builing with v1.
> 
> v1:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31715.html
> 
>  drivers/video/omap2/dss/dsi.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index a6e0f64..b3fa3a7
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -2920,7 +2920,12 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
>  
>  		dsi_update_screen_dispc(dssdev, x, y, w, h);
dont need the error check here?
>  	} else {
> -		dsi_update_screen_l4(dssdev, x, y, w, h);
> +		int r;
> +
> +		r = dsi_update_screen_l4(dssdev, x, y, w, h);
> +		if (r)
no print for warning developer/user? is this error expected?
> +			return r;
> +
>  		dsi_perf_show("L4");
>  		callback(0, data);
>  	}


-- 
Regards,
Nishanth Menon
