From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Wed, 9 Mar 2011 14:06:32 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06553E@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
 <87bp1lv8uc.fsf@ti.com>
 <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
 <alpine.DEB.2.00.1103081605460.15132@utopia.booyaka.com>
 <9D0D31AA57AAF5499AFDC63D6472631B0652E1@008-AM1MPN1-036.mgdnok.nokia.com>
 <4D775041.9030606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:42656 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932409Ab1CIOGs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 09:06:48 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, khilman@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, ilkka.koskinen@nokia.com, charu@ti.com, wim@iguana.be



> -----Original Message-----
> From: Jokiniemi Kalle (Nokia-MS/Tampere)
> Sent: 9. maaliskuuta 2011 13:33
> > -----Original Message-----
> > From: Jokiniemi Kalle (Nokia-MS/Tampere)
> > > -----Original Message-----
> > > From: ext Cousson, Benoit [mailto:b-cousson@ti.com]
> > >
> > > In theory, you should not have to disable the interface clock at all.
> > > Assuming that the smartidle is working properly, the iclk should be
> > > gated during clock domain transition automagically.
> > > The only thing that can prevent that is potentially a wrong setting
> > > in the clockactivity bits? It should be 0x2, meaning fclk is active
> > > but iclk can be
> > gated.
> >
> > Just trying that out now :)
> 
> Nope, did not work. Tried this with both paul's second patch and without:
> 
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1251,6 +1251,7 @@ static struct omap_hwmod_class_sysconfig
> omap3xxx_wd_timer_sysc = {
>  			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
>  			   SYSC_HAS_AUTOIDLE |
> SYSC_HAS_CLOCKACTIVITY),
>  	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.clockact	= CLOCKACT_TEST_ICLK,
>  	.sysc_fields    = &omap_hwmod_sysc_type1,
>  };
> 
> I am quite puzzled why it does not just work as it is. The GPTIMER1 is very
> similar to this (uses same interface clock: wkup_l4_ick) and it has iclk
> usecount of 1 in the clock tree same as the wdtimer2 iclk. So the clock
> framework allows the gptimer1 to disable interface clock on idle transition,
> but not for wdtimer2. HW bug?
> 
> I wonder what is different with direct iclk control, since the iclk bit is still
> enabled with this approach as well. Maybe the clock framework does some
> different tricks in case there are no users for a certain clock...

Well, the difference is that the iclk enable bit is toggled to disabled, but now I'm very puzzled why I still see it as enabled in the PRCM register dump... One last lead is that the reverted pm-runtime patch actually puts the WDTIMER2 into force idle mode rather than smart idle mode. Have to try this one, maybe that helps.

- Kalle

> 
> - Kalle
> 
> 
> >
> > - Kalle
> >
> > >
> > > Regards,
> > > Benoit
