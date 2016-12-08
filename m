From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Thu, 8 Dec 2016 12:26:57 -0800
Message-ID: <20161208202656.GH4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <87lgvqkb6f.fsf@linux.intel.com>
 <20161208153734.GF4264@atomide.com>
 <87a8c6pavm.fsf@linux.intel.com>
 <20161208182521.GA4920@atomide.com>
 <20161208184425.GB4920@atomide.com>
 <8737hy8c1s.fsf@linux.intel.com>
 <20161208193208.GE4920@atomide.com>
 <87fulyuqs6.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87fulyuqs6.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 12:10]:
> 
> Hi,
> 
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> >> nothing against it. Would be nice if TI could confirm this is needed and
> >> check if other families might also need it.
> >
> > But as we currently are not using the WRAPRESET bit, the reset
> > function is nop except for the delay. So this just papers over
> > the problem with the delay. We are not really resetting anything
> > until WRAPRESET and probably also CORE_SW_RESET reset are used.
> >
> > I'm now thinking the original $subject patch for dwc3-omap.c
> > is the way to go for the fix. Or possibly even writing to the
> > CORE_SW_RESET bit in dwc3-omap.c probe. The driver needs to be
> > able to initialize the hardware no matter what it's state is
> > in probe :)
> 
> in theory, yeah. In practice, this doesn't work always. For starters,
> we'd probably loose connection to host while handing over IP from
> e.g. u-boot to kernel.
> 
> Not to mention tht with dwc3 we can't simply read EP registers and
> figure out what's the state of the EP. EP registers are a command
> interface to some HW-based command parser/processor. IOW, we can't
> extrapolate internal state machine from a read of the registers.
> 
> All this to say, that we rely on properly reset HW from probe(). At
> least in the context of dwc3 :-)

Yeah I agree we should reset it properly also from PM point of view
to get things into sane state after the bootloader.

> > Then later on we can add separate resets for the wrapper module
> > and dwc3 core. But that's way too intrusive for a fix for sure.
> 
> yeah, that's something for v4.11. Let's go with your fix that just
> clears interrupts early on. Once proper resets are added, then we should
> revert that change.

OK

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
