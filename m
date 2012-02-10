From: Kevin Hilman <khilman@ti.com>
Subject: Re: ARM: OMAP2xxx: PM: remove obsolete timer disable code in the suspend path
Date: Fri, 10 Feb 2012 11:26:53 -0800
Message-ID: <87y5saxzeq.fsf@ti.com>
References: <alpine.DEB.2.00.1202092007540.17520@utopia.booyaka.com>
	<alpine.DEB.2.00.1202100140430.2553@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43772 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758542Ab2BJT04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 14:26:56 -0500
Received: by pbbrq13 with SMTP id rq13so2095337pbb.12
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 11:26:55 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1202100140430.2553@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 10 Feb 2012 01:42:09 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robherring2@gmail.com, tony@atomide.com

Paul Walmsley <paul@pwsan.com> writes:

> On Thu, 9 Feb 2012, Paul Walmsley wrote:
>
>> 
>> Remove omap_{read,write}l() from the 24xx PM code.  The clocksource
>> code should now handle what this was supposed to do.
>> 
>> Tested on N800 -- but it's hard to say whether this fixes anything.
>> OMAP24xx static suspend path is currently broken, and this patch
>> doesn't change that.
>> 
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Rob Herring <robherring2@gmail.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>
> Just realized that a stray change made it into the patch that was posted.
> Below is a version with the stray change removed.  It applies on 
> Tony's v3.3-rc3 testing branch, plus the OMAP2420 serial fix patch that 
> was posted earlier.
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Fri, 10 Feb 2012 01:40:04 -0700
> Subject: [PATCH v2] ARM: OMAP2xxx: PM: remove obsolete timer disable code 
> in the suspend path
>
> Remove omap_{read,write}l() from the 24xx PM code.  The clocksource
> code should now handle what this was supposed to do.
>
> Tested on N800 -- but it's hard to say whether this fixes anything.
> OMAP24xx static suspend path is currently broken, and this patch
> doesn't change that.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Kevin Hilman <khilman@ti.com>

> ---
>  arch/arm/mach-omap2/pm24xx.c |   22 +---------------------
>  1 files changed, 1 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index 23de98d..18eda53 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -254,26 +254,6 @@ static int omap2_pm_begin(suspend_state_t state)
>  	return 0;
>  }
>  
> -static int omap2_pm_suspend(void)
> -{
> -	u32 wken_wkup, mir1;
> -
> -	wken_wkup = omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> -	wken_wkup &= ~OMAP24XX_EN_GPT1_MASK;
> -	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
> -
> -	/* Mask GPT1 */
> -	mir1 = omap_readl(0x480fe0a4);
> -	omap_writel(1 << 5, 0x480fe0ac);
> -
> -	omap2_enter_full_retention();
> -
> -	omap_writel(mir1, 0x480fe0a4);
> -	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
> -
> -	return 0;
> -}
> -
>  static int omap2_pm_enter(suspend_state_t state)
>  {
>  	int ret = 0;
> @@ -281,7 +261,7 @@ static int omap2_pm_enter(suspend_state_t state)
>  	switch (state) {
>  	case PM_SUSPEND_STANDBY:
>  	case PM_SUSPEND_MEM:
> -		ret = omap2_pm_suspend();
> +		omap2_enter_full_retention();
>  		break;
>  	default:
>  		ret = -EINVAL;
