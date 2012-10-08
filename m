From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix return value check in
 realtime_counter_init()
Date: Mon, 8 Oct 2012 15:01:56 -0700
Message-ID: <20121008220156.GX13011@atomide.com>
References: <CAPgLHd_X+vT-AtkHCAmmieEtdQbVz6RcUWogY83qZyvzK_tidA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28386 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751977Ab2JHWCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 18:02:04 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd_X+vT-AtkHCAmmieEtdQbVz6RcUWogY83qZyvzK_tidA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [121007 07:00]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().

Thanks applying into omap fixes.

Tony
 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 8847d6e..44f9aa7 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -378,7 +378,7 @@ static void __init realtime_counter_init(void)
>  		return;
>  	}
>  	sys_clk = clk_get(NULL, "sys_clkin_ck");
> -	if (!sys_clk) {
> +	if (IS_ERR(sys_clk)) {
>  		pr_err("%s: failed to get system clock handle\n", __func__);
>  		iounmap(base);
>  		return;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
