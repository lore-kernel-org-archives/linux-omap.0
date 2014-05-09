From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Fri, 9 May 2014 14:57:47 +0200
Message-ID: <CAGhQ9Vw+cR-cKQ-w3psZPOWOqwugntXq-9g5=4cZV-ijQZecTQ@mail.gmail.com>
References: <1397924056-6462-1-git-send-email-manabian@gmail.com>
	<CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
	<20140421153539.GB23945@atomide.com>
	<CAGhQ9VyFQgcOw8y97R6HR1apXo-89JyktADxR6jb1EJipXqqjA@mail.gmail.com>
	<CAGhQ9VxCA_VnO18zWgtWUExNE6YJd+krNEVLtyZTpyY6hRyHUg@mail.gmail.com>
	<20140506001237.GK25949@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:64426 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbaEIM5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 08:57:48 -0400
Received: by mail-ve0-f171.google.com with SMTP id oz11so5125994veb.2
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2014 05:57:48 -0700 (PDT)
In-Reply-To: <20140506001237.GK25949@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 6 May 2014 02:12, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Sorry for dropping the ball on this one, got distracted with various
> other fixes for a while.
>
> * Joachim Eastwood <manabian@gmail.com> [140421 09:16]:
>> On 21 April 2014 18:12, Joachim  Eastwood <manabian@gmail.com> wrote:
>> > On 21 April 2014 17:35, Tony Lindgren <tony@atomide.com> wrote:
>> >> * Joachim Eastwood <manabian@gmail.com> [140419 09:25]:
>> >>> On 19 April 2014 18:14, Joachim Eastwood <manabian@gmail.com> wrote:
>> >>> > This was introduced in 43a348ea53eb5fd79 but hasn't caused
>> >>> > any harm since it don't have any users yet.
>> >>>
>> >>> Or maybe I am confused about this macro.
>> >>>
>> >>> Tony which offset from the OMAP4 TRM should be used?
>> >>>
>> >>> Under section 18.6.8 there are is a column with address offset. Is
>> >>> this the number you want in the macro?
>> >>
>> >> Oh I see, the offsets in the TRM in this case are from the base
>> >> of the wkup module padconf base instead of listing the physical
>> >> address for the register. Ideally the value would be what the
>> >> documentation lists in the "Table 18-9. Device Wake-Up Control
>> >> Module Pad Configuration Register Fields" with 2 added to it for
>> >> the upper registers as we're using 16-bit register address.
>> >> In any case something that's relatively easy to verify against
>> >> the documentation. But that seems to vary between the physical
>> >> address and the offset, so we need to specify some mask there.
>> >>
>> >> Something like below (untested) should do the trick as long as
>> >> we never have padconf reg areas larger than 0xfff. We may want to
>> >> allow defining a custom mask for the macro if needed depending
>> >> how the documentation is defining the mux tables for.
>> >>
>> >> --- a/include/dt-bindings/pinctrl/omap.h
>> >> +++ b/include/dt-bindings/pinctrl/omap.h
>> >> @@ -51,9 +51,9 @@
>> >>
>> >>  /*
>> >>   * Macros to allow using the absolute physical address instead of the
>> >> - * padconf registers instead of the offset from padconf base.
>> >> + * padconf register offset from padconf register base.
>> >>   */
>> >> -#define OMAP_IOPAD_OFFSET(pa, offset)  (((pa) & 0xffff) - (offset))
>> >> +#define OMAP_IOPAD_OFFSET(pa, offset)   (((pa) & 0xfff) - ((offset) & 0xfff))
>> >>
>> >>  #define OMAP2420_CORE_IOPAD(pa, val)   OMAP_IOPAD_OFFSET((pa), 0x0030) (val)
>> >>  #define OMAP2430_CORE_IOPAD(pa, val)   OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
>> >
>> > This give the same result as my patch so it's okay for me. Checked the
>> > resulting dtb's and they are equivalent.
>> >
>> > Your patch will also have an effect on some of the others macros but I
>> > assume that is okey.
>
> Yeah looks like the above won't work as the padconf value can easily
> be larger than the 0xfff masked offset.. For example OMAP3_CORE1_IOPAD
> at 0x48002030 would become 0x030 and the value for it can be up to
> 0x238. And we really want the macros to behave the same way for
> everything rather than obfuscate the calculation even further.
>
> I guess we could add few new macros, but looks like am335x is using
> yet another way of documenting these so it may be endless patching.
>
>> For reference my var-som-om44.dtsi now looks like this:
>> http://slexy.org/raw/s213OvSZfF
>
> OK sorry just noticed you're using it already while was about to
> apply your patches. Care to update that series again to not use the
> macro, or by adding the offsets?

hm, I'd rather add offsets than remove the macro's now.

How about we introduce a mask parameter in to the OMAP_IOPAD_OFFSET macro?
Something like this:
#define OMAP_IOPAD_OFFSET(pa, offset, mask) (((pa) & mask) - ((offset) & mask))

#define OMAP4_CORE_IOPAD(pa, val) OMAP_IOPAD_OFFSET((pa), 0x0040, 0xfff) (val)

#define OMAP4_WKUP_IOPAD(pa, val) OMAP_IOPAD_OFFSET((pa), 0xe040, 0xfff) (val)

Of course we need to fix the other users as well.


One other possibility is to use my original patch in this mail or just
create a OMAP4_IOPAD with offset 0x040 which will on OMAP4 work for
both core and wkup.

What do you think?

regards
Joachim Eastwood
