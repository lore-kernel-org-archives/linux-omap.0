From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Mon, 5 May 2014 17:12:37 -0700
Message-ID: <20140506001237.GK25949@atomide.com>
References: <1397924056-6462-1-git-send-email-manabian@gmail.com>
 <CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
 <20140421153539.GB23945@atomide.com>
 <CAGhQ9VyFQgcOw8y97R6HR1apXo-89JyktADxR6jb1EJipXqqjA@mail.gmail.com>
 <CAGhQ9VxCA_VnO18zWgtWUExNE6YJd+krNEVLtyZTpyY6hRyHUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46637 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756974AbaEFAMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 20:12:41 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9VxCA_VnO18zWgtWUExNE6YJd+krNEVLtyZTpyY6hRyHUg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

Sorry for dropping the ball on this one, got distracted with various
other fixes for a while.

* Joachim Eastwood <manabian@gmail.com> [140421 09:16]:
> On 21 April 2014 18:12, Joachim  Eastwood <manabian@gmail.com> wrote:
> > On 21 April 2014 17:35, Tony Lindgren <tony@atomide.com> wrote:
> >> * Joachim Eastwood <manabian@gmail.com> [140419 09:25]:
> >>> On 19 April 2014 18:14, Joachim Eastwood <manabian@gmail.com> wrote:
> >>> > This was introduced in 43a348ea53eb5fd79 but hasn't caused
> >>> > any harm since it don't have any users yet.
> >>>
> >>> Or maybe I am confused about this macro.
> >>>
> >>> Tony which offset from the OMAP4 TRM should be used?
> >>>
> >>> Under section 18.6.8 there are is a column with address offset. Is
> >>> this the number you want in the macro?
> >>
> >> Oh I see, the offsets in the TRM in this case are from the base
> >> of the wkup module padconf base instead of listing the physical
> >> address for the register. Ideally the value would be what the
> >> documentation lists in the "Table 18-9. Device Wake-Up Control
> >> Module Pad Configuration Register Fields" with 2 added to it for
> >> the upper registers as we're using 16-bit register address.
> >> In any case something that's relatively easy to verify against
> >> the documentation. But that seems to vary between the physical
> >> address and the offset, so we need to specify some mask there.
> >>
> >> Something like below (untested) should do the trick as long as
> >> we never have padconf reg areas larger than 0xfff. We may want to
> >> allow defining a custom mask for the macro if needed depending
> >> how the documentation is defining the mux tables for.
> >>
> >> --- a/include/dt-bindings/pinctrl/omap.h
> >> +++ b/include/dt-bindings/pinctrl/omap.h
> >> @@ -51,9 +51,9 @@
> >>
> >>  /*
> >>   * Macros to allow using the absolute physical address instead of the
> >> - * padconf registers instead of the offset from padconf base.
> >> + * padconf register offset from padconf register base.
> >>   */
> >> -#define OMAP_IOPAD_OFFSET(pa, offset)  (((pa) & 0xffff) - (offset))
> >> +#define OMAP_IOPAD_OFFSET(pa, offset)   (((pa) & 0xfff) - ((offset) & 0xfff))
> >>
> >>  #define OMAP2420_CORE_IOPAD(pa, val)   OMAP_IOPAD_OFFSET((pa), 0x0030) (val)
> >>  #define OMAP2430_CORE_IOPAD(pa, val)   OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
> >
> > This give the same result as my patch so it's okay for me. Checked the
> > resulting dtb's and they are equivalent.
> >
> > Your patch will also have an effect on some of the others macros but I
> > assume that is okey.

Yeah looks like the above won't work as the padconf value can easily
be larger than the 0xfff masked offset.. For example OMAP3_CORE1_IOPAD
at 0x48002030 would become 0x030 and the value for it can be up to
0x238. And we really want the macros to behave the same way for
everything rather than obfuscate the calculation even further.

I guess we could add few new macros, but looks like am335x is using
yet another way of documenting these so it may be endless patching.
 
> For reference my var-som-om44.dtsi now looks like this:
> http://slexy.org/raw/s213OvSZfF

OK sorry just noticed you're using it already while was about to
apply your patches. Care to update that series again to not use the
macro, or by adding the offsets? 
 
> > Will this be sent as a fix for 3.15?

No since it won't work properly :)

Regards,

Tony
