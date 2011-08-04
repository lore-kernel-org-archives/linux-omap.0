From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPFB: make debug message more useful
Date: Thu, 04 Aug 2011 11:09:19 +0300
Message-ID: <1312445359.2143.9.camel@deskari>
References: <1309972109-23778-1-git-send-email-andy.doan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39114 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751762Ab1HDIJZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 04:09:25 -0400
In-Reply-To: <1309972109-23778-1-git-send-email-andy.doan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Doan <andy.doan@linaro.org>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, 2011-07-06 at 12:08 -0500, Andy Doan wrote:
> Make the debug message useful by printing the name of the device
> that no associated driver could be found for.
> 
> Signed-off-by: Andy Doan <andy.doan@linaro.org>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
> index 602b71a..e5a64b3 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2373,7 +2373,8 @@ static int omapfb_probe(struct platform_device *pdev)
>  		omap_dss_get_device(dssdev);
>  
>  		if (!dssdev->driver) {
> -			dev_err(&pdev->dev, "no driver for display\n");
> +			dev_err(&pdev->dev, "no driver for display: %s\n",
> +				dssdev->name);
>  			r = -ENODEV;
>  		}
>  

Thanks, applying.

 Tomi


