From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3evm: touchscreen delays on pm branch
Date: Fri, 27 Nov 2009 15:20:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9180@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
	 <4B0F9045.6030404@ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com>
 <1259312859.19138.4.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34397 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbZK0Jux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 04:50:53 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAR9ourc001026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 03:50:59 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAR9ou0I019646
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 15:20:56 +0530 (IST)
In-Reply-To: <1259312859.19138.4.camel@boson>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Dasgupta, Romit 
> Sent: Friday, November 27, 2009 2:38 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: RE: omap3evm: touchscreen delays on pm branch
> 
> On Fri, 2009-11-27 at 14:11 +0530, Premi, Sanjeev wrote:
> > > -----Original Message-----
> > > From: Dasgupta, Romit 
> > > Sent: Friday, November 27, 2009 2:10 PM
> > > To: Premi, Sanjeev
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: omap3evm: touchscreen delays on pm branch
> > > 
> > > Premi, Sanjeev wrote:
> > > > Hi,
> > > > 
> > > > I am finding the response of touchscreen on the 
> omap3evm very slow.
> > > > 
> > > > Here is my test:
> > > > On console, I run : watch -n2 "cat /proc/interrupts"
> > > > Then, I tap the touchscreen approximately once per 
> second. However,
> > > > (usually) no interrupts are registered. As I increase 
> the frequency
> > > > of 'taps' more and more interrupts are registered. But still not
> > > > matching exact taps.
> > > > 
> > > > However, when I keep the cpu busy with "cat /dev/zero > 
> /dev/null &"
> > > > each tap is recognized.
> > > > 
> > > Do you see this even if we don't enable OFF?
> > > 
> > Yes. Sleep_while_idle=0; enable_off_mode=0
> > ~sanjeev
> 
> Hopefully you have the same TSC driver. Nevertheless, can you 
> please try
> this (just to see if clock domain idling is causing any 
> problem or not):

It is the same driver at SDP3430. I had earlier tried removing
cpuidle altogether and did not see this issue. I too believe that
issue is caused by clocks being going to (auto)idle.

But then, Hemanth should be seeing the same behavior.

~sanjeev

> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index 1cfa5a6..79710a1 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -248,7 +248,8 @@ void omap_init_power_states(void)
>  			cpuidle_params_table[OMAP3_STATE_C2].threshold;
>  	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
>  	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
> -	omap3_power_states[OMAP3_STATE_C2].flags = 
> CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[OMAP3_STATE_C2].flags = 
> CPUIDLE_FLAG_TIME_VALID |
> +				CPUIDLE_FLAG_CHECK_BM;
>  
>  	/* C3 . MPU CSWR + Core inactive */
>  	omap3_power_states[OMAP3_STATE_C3].valid =
> 
> 

