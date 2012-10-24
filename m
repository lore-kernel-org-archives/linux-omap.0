From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: AM33XX: Fix configuration of dmtimer parent clock
 by dmtimer driver
Date: Tue, 23 Oct 2012 19:01:31 -0700
Message-ID: <20121024020130.GD5605@atomide.com>
References: <1350500155-22525-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:25178 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755566Ab2JXCBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 22:01:36 -0400
Content-Disposition: inline
In-Reply-To: <1350500155-22525-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>

* Jon Hunter <jon-hunter@ti.com> [121017 11:57]:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Add dmtimer clock aliases for AM33XX devices so that the parent clock for
> the dmtimer can be set correctly by the dmtimer driver. Without these clock
> aliases the dmtimer driver will fail to find the parent clocks for the dmtimer.
> 
> Verified that DMTIMERs can be successfully requested on AM335x beagle bone.
> 
> Original patch was provided by Vaibhav Hiremath [1]. Changelog and
> additional verification performed by Jon Hunter.
> 
> [1] http://marc.info/?l=linux-omap&m=134693631608018&w=2
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Tested-by: Jon Hunter <jon-hunter@ti.com>

Thanks applying into omap-for-v3.7-rc2/fixes.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/clock33xx_data.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
> index 114ab4b..1a45d6b 100644
> --- a/arch/arm/mach-omap2/clock33xx_data.c
> +++ b/arch/arm/mach-omap2/clock33xx_data.c
> @@ -1073,6 +1073,8 @@ static struct omap_clk am33xx_clks[] = {
>  	CLK(NULL,	"gfx_fck_div_ck",	&gfx_fck_div_ck,	CK_AM33XX),
>  	CLK(NULL,	"sysclkout_pre_ck",	&sysclkout_pre_ck,	CK_AM33XX),
>  	CLK(NULL,	"clkout2_ck",		&clkout2_ck,	CK_AM33XX),
> +	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick,	CK_AM33XX),
> +	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck,	CK_AM33XX),
>  };
>  
>  int __init am33xx_clk_init(void)
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
