From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: am3517: geting MMC working
Date: Thu, 26 Jul 2012 16:31:07 -0700
Message-ID: <20120726233107.GA21273@animalcreek.com>
References: <5007AF7C.1010902@visionsystems.de>
 <CAMQu2gx83tx66kQtF9v_v6yaw-L6v8QMc9u3bokX68ZhzC0tiA@mail.gmail.com>
 <5007B721.9070305@visionsystems.de>
 <CANfBPZ8tfApLcL2WGsP6jgwv7zafywJp7oHQ6E=xBYN8KYyeww@mail.gmail.com>
 <5007C215.7020904@visionsystems.de>
 <CANfBPZ9PcEWUUuFWBD3p9hk6FEEyUJh9cfM3hojayk+Wdycs5A@mail.gmail.com>
 <alpine.DEB.2.00.1207191532560.14390@utopia.booyaka.com>
 <CANrkHUasORhcujiUixhBLJ3_QuUEX3iR5mYn1LMqdk70sMWCsg@mail.gmail.com>
 <50090B30.3070206@visionsystems.de>
 <50091045.7060102@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50852 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab2GZXbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 19:31:08 -0400
Content-Disposition: inline
In-Reply-To: <50091045.7060102@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, Paul Walmsley <paul@pwsan.com>, "S, Venkatraman" <svenkatr@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Porter, Matt" <mporter@ti.com>

On Fri, Jul 20, 2012 at 10:01:09AM +0200, Yegor Yefremov wrote:
> Am 20.07.2012 09:39, schrieb Yegor Yefremov:
> > Am 20.07.2012 09:28, schrieb T Krishnamoorthy, Balaji:
> >> On Fri, Jul 20, 2012 at 3:08 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >>> On Thu, 19 Jul 2012, S, Venkatraman wrote:
> >>>
> >>>> >From this, one can only infer that the card is not responding at all,
> >>>> and all attempts
> >>>> are returning with a timeout (CTO=Command Time Out).
> >>> Looks to me like the card is responding to CMD8, CMD55, ACMD41, and CMD0.
> >>> It's only CMD52 and CMD5 that are timing out.  Aren't those timeouts
> >>> expected with a SD memory card?
> >> yes, those timeouts are expected for SD card.
> >> The failure is due to irq not received/missing for last CMD0.
> >> Hi Yegor, Can you provide details for the SD card being used.
> > 
> > This is Apacer 2GB. In 3.3-rc7 I have no problems with it. Should I enable debugging in 3.3-rc7 and post the output?
> 
> I found the solution:
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e4fc88c..0ab26ab 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -359,7 +359,7 @@ static void omap3_pm_idle(void)
>  {
>  	local_fiq_disable();
>  
> -	if (omap_irq_pending())
> +	if (omap_irq_pending() || !omap3_has_io_wakeup())
>  		goto out;
>  
>  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> 
> I've seen this hack for some on the mailing list. I think
> Mark A. Greer introduced it, but I don't remember for sure.
> Can this patch be applied as it is or there are some infrastructure
> changes required?

[Oops, I thought I sent this days ago.]

Hi Yegor.

Yep, it was me.  That change is unacceptable though, see:

	http://www.spinics.net/lists/arm-kernel/msg168865.html

You were testing on linux-omap/master?  If so, hmmm, I thought
that branch would work.  For now, you can try adding 'nohlt'
to the cmdline but that's a bit of a sledgehammer...

Mark
