From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [RFC 33/42] drivers/video/omap2: don't check resource with
 devm_ioremap_resource
Date: Sat, 11 May 2013 14:37:22 +0900
Message-ID: <002e01ce4e09$9c849590$d58dc0b0$@samsung.com>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-34-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27324 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab3EKFhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 May 2013 01:37:24 -0400
In-reply-to: <1368173847-5661-34-git-send-email-wsa@the-dreams.de>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Cc: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday, May 10, 2013 5:17 PM, Wolfram Sang wrote:
> 
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/omap2/vrfb.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
> index 5261229..f346b02 100644
> --- a/drivers/video/omap2/vrfb.c
> +++ b/drivers/video/omap2/vrfb.c
> @@ -353,11 +353,6 @@ static int __init vrfb_probe(struct platform_device *pdev)
>  	/* first resource is the register res, the rest are vrfb contexts */
> 
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem) {
> -		dev_err(&pdev->dev, "can't get vrfb base address\n");
> -		return -EINVAL;
> -	}
> -
>  	vrfb_base = devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(vrfb_base))
>  		return PTR_ERR(vrfb_base);
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

