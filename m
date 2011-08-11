From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
	implementations
Date: Thu, 11 Aug 2011 16:07:18 +0100
Message-ID: <20110811150718.GA4924@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk> <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk> <20110811141528.GL28500@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110811141528.GL28500@legolas.emea.dhcp.ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 11, 2011 at 05:15:31PM +0300, Felipe Balbi wrote:
> On Tue, Aug 09, 2011 at 09:08:01AM +0100, Russell King - ARM Linux wrote:
> > diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> > index 166a7a3..15e8970 100644
> > --- a/arch/arm/include/asm/gpio.h
> > +++ b/arch/arm/include/asm/gpio.h
> > @@ -4,4 +4,14 @@
> >  /* not all ARM platforms necessarily support this API ... */
> >  #include <mach/gpio.h>
> >  
> > +#ifdef __ARM_GPIOLIB_TRIVIAL
> > +/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
> > +#include <asm-generic/gpio.h>
> > +
> > +/* The trivial gpiolib dispatchers */
> > +#define gpio_get_value  __gpio_get_value
> > +#define gpio_set_value  __gpio_set_value
> > +#define gpio_cansleep   __gpio_cansleep
> > +#endif
> 
> could that be a selectable symbol ? Something like:
> 
> CONFIG_HAS_ARM_TRIVIAL_GPIO
> 
> then on Kconfig you just:
> 
> select HAS_ARM_TIVIAL_GPIO or something ?

That makes things more complicated, because that involves digging through
a lot of platform code in a couple of places to work out exactly when we
need this - and it crosses the boundary to arch/sh too.

So I'd prefer to keep this simple.

The long-term goal is to remove that symbol entirely, but in order to do
that we need to kill of the "optimized" on-board SoC stuff in those (few)
gpio.h which don't have the symbol selected.  This is rather necessary to
progress towards the consolidated kernel.  (Re-inventing gpiolib by moving
them out of line isn't a good idea...)
