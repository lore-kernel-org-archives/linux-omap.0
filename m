From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC
Date: Mon, 12 Nov 2012 14:14:03 -0800
Message-ID: <20121112221402.GR6801@atomide.com>
References: <1352401730-4269-1-git-send-email-khilman@deeprootsystems.com>
 <20121108192834.GA2962@arwen.pp.htv.fi>
 <20121108201045.GA579@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40725 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752140Ab2KLWOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 17:14:06 -0500
Content-Disposition: inline
In-Reply-To: <20121108201045.GA579@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [121108 12:12]:
> On 21:28-20121108, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Nov 08, 2012 at 11:08:50AM -0800, Kevin Hilman wrote:
> > > From: Kevin Hilman <khilman@ti.com>
> > > 
> > > On OMAP4 boards using the TWL6030 PMIC, the sys_drm_msecure is
> > > connected to the MSECURE input of the TWL6030 PMIC.  This signal
> > > controls the secure-mode operation of the PMIC.  If its not mux'd
> > > correctly, some functionality of the PMIC will not be accessible since
> > > the PMIC will be in secure mode.
> > > 
> > > For example, if the TWL RTC is in secure mode, most of its registers
> > > are read-only, meaning (re)programming the RTC (e.g. for wakeup from
> > > suspend) will fail.
> > > 
> > > To fix, ensure the signal is properly mux'd as output when TWL is
> > > intialized.
> > > 
> > > This fix is required when using recent versions of u-boot (>= v2012.04.01)
> > > since u-boot is no longer setting the default mux for this pin.
> > > 
> > > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > > ---
> > > Based on v3.7-rc4.  Targetted as a fix for v3.7.
> > > 
> > > A correponding DT fix for this is needed as well, but that will be part of 
> > > a bigger series to get PM working with DT boot and needs to include other
> > > pins like sys_nirq1.
> > > 
> > >  arch/arm/mach-omap2/twl-common.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> > > index 635e109..96cae8b 100644
> > > --- a/arch/arm/mach-omap2/twl-common.c
> > > +++ b/arch/arm/mach-omap2/twl-common.c
> > > @@ -73,6 +73,7 @@ void __init omap4_pmic_init(const char *pmic_type,
> > >  {
> > >  	/* PMIC part*/
> > >  	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
> > > +	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
> > >  	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_data);
> > >  
> > >  	/* Register additional devices on i2c1 bus if needed */
> > 
> > not entirely related to $SUBJECT but this essentially means we're
> > dropping the security feature whenever Linux runs.
> Unless we intend to remove RTC driver in it's entirety and implement RTC
> time change update in secure driver, current twl rtc driver was never
> meant to exist with RTC time updates only in trustzone mode. Neither does
> it drop any security feature when ever Linux runs- msecure pin has not
> been used for any other purpose to my knowledge with Linux. So, this
> change does not change the status quo we are currently in,
> > 
> > Shouldn't we try to change that pin at register write boundaries so we
> > keep the secure feature enabled until we know we're going to write to
> > the HW ?
> > 
> > Maybe it could even be done later through pinctrl, perhaps ?
> That might be a better solution I agree. We might be locking down to a
> specific pin name here, which could potentially change in a future SoC.
> The right approach IMHO would be omap_gpio_mux equivalent.
> 
> Example change for OMAP5 purely from a board perspective(gerrit warning):
> http://review.omapzoom.org/#/c/23819/5/arch/arm/mach-omap2/board-omap5evm.c,unified
> 
> Further, depending on how it is hooked on a different board (not that I
> have seen any different other than msecure), it might even be hooked on
> to another GPIO, making this scenario not scaling to "theoretical board
> configuration".

Sounds like the discussion is planning for further work and not affecting
this patch. So applying into omap-for-v3.7-rc4/fixes-part2.

Regards,

Tony
