From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Wed, 9 Mar 2011 06:35:50 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06518F@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
 <87bp1lv8uc.fsf@ti.com>
 <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:39152 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab1CIGgt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 01:36:49 -0500
In-Reply-To: <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, ilkka.koskinen@nokia.com, charu@ti.com, wim@iguana.be



> -----Original Message-----
> From: ext Paul Walmsley [mailto:paul@pwsan.com]
> Sent: 9. maaliskuuta 2011 1:02
> To: Jokiniemi Kalle (Nokia-MS/Tampere)
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; tony@atomide.com; b-
> cousson@ti.com; Koskinen Ilkka (Nokia-MS/Tampere); Charulatha
> Varadarajan; wim@iguana.be
> Subject: Re: [PATCH 0/2] omap_wdt: fix interface clock handling
> 
> Hi,
> 
> On Tue, 8 Mar 2011, Kevin Hilman wrote:
> 
> > Kalle Jokiniemi <kalle.jokiniemi@nokia.com> writes:
> >
> > > The runtime PM does not offer enough granularity to control
> > > individual clocks separately as needed. Current pm implementation of
> > > omap_wdt blocks the CORE power domain from idling in OMAP SoC, as it
> > > keeps the interface clock of the watchdog always on. This causes
> > > severe power leakage in devices where the omap watchdog is in active
> > > use.
> >
> > The iclk remains active because it's in hardware-controlled auto-idle
> > mode.
> 
> ... and we think that the interface clock never enters auto-idle because the
> WDT doesn't SIdleAck to the PRCM until the special sequence has been
> written to the WDT registers to disable it.  So even if its *CLKEN bits are set to
> zero, the WDT prevents the system from going idle.
> 
> > I believe if you set the WDT hwmod to software-supported idle
> > (OCPIF_SWSUP_IDLE), the runtime PM idle (which calls omap_device idle,
> > then omap_hwmod_idle) should also gate the interface clock.
> 
> Agreed.
> 
> Kalle, since you requested patches, here's one that implements Kevin's first
> suggestion.  I will reply to your second patch with its equivalent for PM
> runtime.  The patches have been compile-tested only.  Perhaps you could
> see if they solve your problem?

Thanks Paul, I'll try these out.

- Kalle

> 
> 
> regards,
> 
> - Paul
> 
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
>  4 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index 1611f74..df4950d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -974,6 +974,7 @@ static struct omap_hwmod_ocp_if
> omap2420_l4_wkup__wd_timer2 = {
>  	.clk		= "mpu_wdt_ick",
>  	.addr		= omap2420_wd_timer2_addrs,
>  	.addr_cnt	= ARRAY_SIZE(omap2420_wd_timer2_addrs),
> +	.flags		= OCPIF_SWSUP_IDLE,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 809424f..21fc908 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1074,6 +1074,7 @@ static struct omap_hwmod_ocp_if
> omap2430_l4_wkup__wd_timer2 = {
>  	.clk		= "mpu_wdt_ick",
>  	.addr		= omap2430_wd_timer2_addrs,
>  	.addr_cnt	= ARRAY_SIZE(omap2430_wd_timer2_addrs),
> +	.flags		= OCPIF_SWSUP_IDLE,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 457df3e..7ae2dab 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1234,6 +1234,7 @@ static struct omap_hwmod_ocp_if
> omap3xxx_l4_wkup__wd_timer2 = {
>  	.clk		= "wdt2_ick",
>  	.addr		= omap3xxx_wd_timer2_addrs,
>  	.addr_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_addrs),
> +	.flags		= OCPIF_SWSUP_IDLE,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7b72316..2038813 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -4901,6 +4901,7 @@ static struct omap_hwmod_ocp_if
> omap44xx_l4_wkup__wd_timer2 = {
>  	.clk		= "l4_wkup_clk_mux_ck",
>  	.addr		= omap44xx_wd_timer2_addrs,
>  	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_addrs),
> +	.flags		= OCPIF_SWSUP_IDLE,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> --
> 1.7.2.3

