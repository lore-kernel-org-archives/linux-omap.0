From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP: fix return value check in beagle_opp_init()
Date: Tue, 02 Oct 2012 14:36:28 -0700
Message-ID: <87pq508skj.fsf@deeprootsystems.com>
References: <CAPgLHd9aJUYX_a7_iXLi5r6VEVuB0W15G9Ryw2bVzNzko2NpBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65390 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200Ab2JBVg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Oct 2012 17:36:28 -0400
Received: by pbbrr4 with SMTP id rr4so9171591pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Oct 2012 14:36:28 -0700 (PDT)
In-Reply-To: <CAPgLHd9aJUYX_a7_iXLi5r6VEVuB0W15G9Ryw2bVzNzko2NpBA@mail.gmail.com>
	(Wei Yongjun's message of "Fri, 21 Sep 2012 14:26:37 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function omap_device_get_by_hwmod_name()
> returns ERR_PTR() not NULL pointer. The NULL test in the return
> value check should be replaced with IS_ERR().
>
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, queueing this up for v3.7-rc.

Kevin

> ---
>  arch/arm/mach-omap2/board-omap3beagle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 6202fc7..a548d70 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -466,7 +466,7 @@ static void __init beagle_opp_init(void)
>  		mpu_dev = omap_device_get_by_hwmod_name("mpu");
>  		iva_dev = omap_device_get_by_hwmod_name("iva");
>  
> -		if (!mpu_dev || !iva_dev) {
> +		if (IS_ERR(mpu_dev) || IS_ERR(iva_dev)) {
>  			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
>  				__func__, mpu_dev, iva_dev);
>  			return;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
