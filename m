From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix return value check in
 omap_device_build_from_dt()
Date: Wed, 21 Aug 2013 00:19:01 -0700
Message-ID: <20130821071901.GR7656@atomide.com>
References: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55249 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752318Ab3HUHTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 03:19:13 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Kevin,

* Wei Yongjun <weiyj.lk@gmail.com> [130704 06:48]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().

Looks like this is still pending, care to take this?

Tony
 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/omap_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 5cc9287..28e70c0 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -155,7 +155,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  	}
>  
>  	od = omap_device_alloc(pdev, hwmods, oh_cnt);
> -	if (!od) {
> +	if (IS_ERR(od)) {
>  		dev_err(&pdev->dev, "Cannot allocate omap_device for :%s\n",
>  			oh_name);
>  		ret = PTR_ERR(od);
> 
