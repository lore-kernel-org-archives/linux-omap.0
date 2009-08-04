From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [RFC PATCH] OMAP3:PM: Fix OPP scale logic
Date: Tue, 04 Aug 2009 11:00:54 +0300
Message-ID: <4A77EAB6.3070208@nokia.com>
References: <1249306912-12099-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64232 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbZHDIBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 04:01:20 -0400
In-Reply-To: <1249306912-12099-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Kevin <khilman@deeprootsystems.com>, Paul <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

ext Nishanth Menon wrote:
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index 25535a3..1ceaed8 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -240,13 +240,23 @@ static int program_opp_freq(int res, int target_level, int current_level)
>  	lock_scratchpad_sem();
>  	if (res == VDD1_OPP) {
>  		curr_opp = &curr_vdd1_opp;
> -		clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
> -		clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
> +		ret = clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
> +		if (unlikely(ret))
> +			return ret;

if we return here we're not calling unlock_scratchpad_sem(). if you remove the 
return statement the expected functionality will be achieved by the next if(ret) 
statement.

looks like you are changing the return behaviour from opp level to 0/1. You 
should explain this in a function header comment.

> +
> +		ret = clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
> +		if (unlikely(ret))
> +			/* reset the dpll1 if failed */
> +			clk_set_rate(dpll1_clk, mpu_opps[current_level].rate);
>  #ifndef CONFIG_CPU_FREQ
> -		/*Update loops_per_jiffy if processor speed is being changed*/
> -		loops_per_jiffy = compute_lpj(loops_per_jiffy,
> -			mpu_opps[current_level].rate/1000,
> -			mpu_opps[target_level].rate/1000);
> +		else
> +			/*
> +			 * Update loops_per_jiffy if processor speed
> +			 * is being changed
> +			 */
> +			loops_per_jiffy = compute_lpj(loops_per_jiffy,
> +				mpu_opps[current_level].rate/1000,
> +				mpu_opps[target_level].rate/1000);
>  #endif
>  	} else {
>  		curr_opp = &curr_vdd2_opp;
> @@ -257,7 +267,7 @@ static int program_opp_freq(int res, int target_level, int current_level)
>  	}
>  	if (ret) {
>  		unlock_scratchpad_sem();
> -		return current_level;
> +		return ret;
>  	}
>  #ifdef CONFIG_PM
>  	omap3_save_scratchpad_contents();
> @@ -265,7 +275,7 @@ static int program_opp_freq(int res, int target_level, int current_level)
>  	unlock_scratchpad_sem();
>  
>  	*curr_opp = target_level;
> -	return target_level;
> +	return ret;
>  }
>  
>  static int program_opp(int res, struct omap_opp *opp, int target_level,
> @@ -289,13 +299,35 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
>  					current_level);
>  #ifdef CONFIG_OMAP_SMARTREFLEX
>  		else
> -			sr_voltagescale_vcbypass(t_opp, c_opp,
> +			ret = sr_voltagescale_vcbypass(t_opp, c_opp,
>  				opp[target_level].vsel,
>  				opp[current_level].vsel);
> +		if (ret) {
> +			int ret1 = 0;
> +			/*
> +			 * If something did not work, put me back to old state.
> +			 * Recover the other guy if at least 1 prev iteration
> +			 * had run
> +			 */
> +			if (i && raise)
> +				ret1 = sr_voltagescale_vcbypass(c_opp, t_opp,
> +					opp[current_level].vsel,
> +					opp[target_level].vsel);
> +			else if (i)
> +				ret1 = program_opp_freq(res, current_level,
> +						target_level);
> +			/*
> +			 * If I could not reset my old state back.. system
> +			 * is no longer in a controlled state.. bug me
> +			 */
> +			if (unlikely(ret1))
> +				BUG();
> +			break;
> +		}
>  #endif
>  	}
>  
> -	return ret;
> +	return (res == PRCM_VDD1) ?  curr_vdd1_opp : curr_vdd2_opp;
>  }
>  
>  int resource_set_opp_level(int res, u32 target_level, int flags)

