From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Thu, 30 Sep 2010 01:24:05 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF2DAF55@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>	<87d3rxblfu.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF48@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF49@dbde02.ent.ti.com>
	<87bp7gz7by.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF53@dbde02.ent.ti.com>
 <87vd5oxrr0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39580 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab0I2Tyb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 15:54:31 -0400
In-Reply-To: <87vd5oxrr0.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, September 30, 2010 1:11 AM
> To: Nayak, Rajendra
> Cc: Raja, Govindraj; Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha
> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
> 
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> Sent: Thursday, September 30, 2010 12:49 AM
> >> To: Nayak, Rajendra; Raja, Govindraj
> >> Cc: Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha
> >> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
> >>
> >> "Nayak, Rajendra" <rnayak@ti.com> writes:
> >>
> >> [...]
> >>
> >> >
> >> > I forgot to mention, there are similar WARN's that I see on 2430sdp even with UART
> >> >
> >>
> >> Govidraj, can you look into these UART issues please?
> >>
> >> Looks like you might need to double check the bitfields and the
> >> module_offs for both of these.
> >
> > Btw, the WARN's come only for UART3 and the error at hwmod init shows that
> > maybe _wait_target_ready fails.
> >
> > [    0.000000] NR_IRQS:402
> > [    0.000000] Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
> > [    0.000000] omap_hwmod: uart3: cannot be enabled (3)
> >
> 
> UART3 on 24xx is in CM_IDLEST2_CORE, and the 2430 hwmod data has it in
> CM_IDLEST1_CORE.
> 
> Can you test the change below?  I don't have a 2430, and it appears that
> this is already correct in the 2420 hwmod data.
> 
> Kevin
> 
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 92f4ec0..5b61f7c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -449,9 +449,9 @@ static struct omap_hwmod omap2430_uart3_hwmod = {
>  	.prcm		= {
>  		.omap2 = {
>  			.module_offs = CORE_MOD,
> -			.prcm_reg_id = 1,
> +			.prcm_reg_id = 2,
>  			.module_bit = OMAP24XX_EN_UART3_SHIFT,
> -			.idlest_reg_id = 1,
> +			.idlest_reg_id = 2,
>  			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
>  		},
>  	},

This does seem to fix the issue on 2430. I don't see the error at hwmod init
or the WARN's later.
