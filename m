From: Niilo Minkkinen <ext-niilo.1.minkkinen@nokia.com>
Subject: Re: [PATCH] OMAP3: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 17:09:52 +0300
Message-ID: <1245852592.6022.12.camel@niilo-u810>
References: <1245803237-30891-1-git-send-email-khilman@deeprootsystems.com>
	 <1245826423.6022.5.camel@niilo-u810>	<87zlbx4vjb.fsf@deeprootsystems.com>
	 <1245851402.6022.11.camel@niilo-u810>  <87k5314tem.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25530 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbZFXOMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 10:12:43 -0400
In-Reply-To: <87k5314tem.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-06-24 at 16:07 +0200, ext Kevin Hilman wrote:
> Niilo Minkkinen <ext-niilo.1.minkkinen@nokia.com> writes:
> 
> > On Wed, 2009-06-24 at 15:21 +0200, ext Kevin Hilman wrote:
> >> Niilo Minkkinen <ext-niilo.1.minkkinen@nokia.com> writes:
> >> 
> >> > On Wed, 2009-06-24 at 02:27 +0200, ext Kevin Hilman wrote:
> >> >> Rather than simply setting force-idle mode on boot, do a reset of the
> >> >> OTG module.  This really ensures that any bootloader/bootstrap code
> >> >> that leaves it active will not prevent future retention.  After reset,
> >> >> OTG module will be in force-idle, force-standby mode.
> >> >> 
> >> >> In addition, ensure that the iclk is enabled before attempting a write
> >> >> to the module SYSCONFIG register.
> >> >> 
> >> >> Problem reported by Mike Chan <mikechan@google.com>
> >> >> 
> >> >> Tested-by: Mike Chan <mikechan@google.com>
> >> >> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> >> >> ---
> >> >> If no comments/issues, this will be applied to PM branch and
> >> >> backported to pm-2.6.29.
> >> >> 
> >> >>  arch/arm/mach-omap2/usb-musb.c |   21 ++++++++++++++++++---
> >> >>  1 files changed, 18 insertions(+), 3 deletions(-)
> >> >> 
> >> >> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> >> >> index d85296d..85731b8 100644
> >> >> --- a/arch/arm/mach-omap2/usb-musb.c
> >> >> +++ b/arch/arm/mach-omap2/usb-musb.c
> >> >> @@ -32,12 +32,27 @@
> >> >>  #include <mach/usb.h>
> >> >>  
> >> >>  #define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
> >> >> +#define OTG_SYSC_SOFTRESET BIT(1)
> >> >>  
> >> >>  static void __init usb_musb_pm_init(void)
> >> >>  {
> >> >> -	/* Ensure force-idle mode for OTG controller */
> >> >> -	if (cpu_is_omap34xx())
> >> >> -		omap_writel(0, OTG_SYSCONFIG);
> >> >> +	struct clk *iclk;
> >> >> +
> >> >> +	if (!cpu_is_omap34xx())
> >> >> +		return;
> >> >> +
> >> >> +	iclk = clk_get(NULL, "hsotgusb_ick");
> >> >> +	if (WARN_ON(!iclk))
> >> >> +		return;
> >> >> +
> >> >> +	clk_enable(iclk);
> >> >> +
> >> >> +	/* Reset OTG controller.  After reset, it will be in
> >> >> +	 * force-idle, force-standby mode. */
> >> >> +	omap_writel(OTG_SYSC_SOFTRESET, OTG_SYSCONFIG);
> >> >
> >> > Do you think, this is safe to do w/o waiting reset to be finished
> >> > like :  ?
> >> >
> >> > +       omap_writel( SOFTRST, OTG_SYSCONFIG );  /* acquire RESET */
> >> > +       start = jiffies;
> >> > +       timeout = start + msecs_to_jiffies(10); /* max 10 ms */
> >> > +       while (!time_after(jiffies, timeout)) /* wait until RESET OK */
> >> > +               if ( omap_readl(OTG_SYSSTATUS) & RESETDONE )
> >> > +                       break;
> >> 
> >> I thought about waiting for reset, but I decided that it wasn't
> >> necessary to wait since I wasn't going to write any other values
> >> after.  Why hold up the boot process when nothing else will be
> >> writing?
> >> 
> >> Kevin
> >> 
> >
> > Sure you are right.
> > Thing I don't know, how near is the next access to musb ...
> 
> Next access of MUSB isn't until the driver starts, and even then,
> there should be a clk_get(), clk_enable() before any other access to
> the MUSB regs.
> 
> Kevin
> 

Ok. This clears things.
Sorry for consuming bandwidth.

-niilo-

> > In my tests, this wait hasn't take even 1 ms (in units of jiffies), so I
> > don't know duration of it.
> > My comment anyhow can be think as a face-up.
> >
> > -niilo-
> >
> >> > SOFTRST & RESETDONE already defined in omap2430.h
> >> >
> >> >> +
> >> >> +	clk_disable(iclk);
> >> >> +	clk_put(iclk);
> >> >>  }
> >> >>  
> >> >>  #ifdef CONFIG_USB_MUSB_SOC
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

