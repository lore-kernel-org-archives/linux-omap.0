From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 18:33:12 +0200
Message-ID: <CABxcv=kLOD7OQxPBxSaEBPzVW7bN2qRj09S=yozUg8OUL+7wCQ@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53566EBA.808@ti.com>
	<CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
	<CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
	<7hr44mpxk6.fsf@paris.lan>
	<CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com>
	<CABxcv==7bisHnock37_Ai-k-n+u57Mk6YoAFvBV-XA+cEj+x+Q@mail.gmail.com>
	<20140424154248.GB22987@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44249 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758447AbaDXQdO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 12:33:14 -0400
Received: by mail-wi0-f173.google.com with SMTP id z2so1391824wiv.0
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 09:33:13 -0700 (PDT)
In-Reply-To: <20140424154248.GB22987@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hello Tony,

On Thu, Apr 24, 2014 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [140424 08:37]:
>> Hello,
>>
>> On Thu, Apr 24, 2014 at 5:25 PM, Nishanth Menon <nm@ti.com> wrote:
>> > On Thu, Apr 24, 2014 at 10:16 AM, Kevin Hilman <khilman@linaro.org> wrote:
>> >> Linus Walleij <linus.walleij@linaro.org> writes:
>> >>
>> >>> On Tue, Apr 22, 2014 at 5:52 PM, Javier Martinez Canillas
>> >>> <javier@dowhile0.org> wrote:
>> >>>
>> >>>> I've revised the patch again and I couldn't find the reason why
>> >>>> certain boards are failing to boot.
>> >>>>
>> >>>> I can't reproduce this issue since I only have a DM3730 IGEPv2 board
>> >>>> which boots fine but I should have access to an AM3354 IGEP Aquila
>> >>>> board which is similar to the am335x-evmsk so I may be able to debug
>> >>>> it.
>> >>>
>> >>> It would really REALLY appreciate if some of the people maintaining
>> >>> and using OMAP1 would help Javier out in this refactoring operation.
>> >>>
>> >>> I'd really *hate* to have to drop his patches because of a lack of
>> >>> boards. This refactoring is necessary to handle the exploding
>> >>> multitude of GPIO drivers moving forward.
>> >>>
>> >>> We even tried to get an Innovator to boot just to be able to refactor
>> >>> OMAP stuff but fell short on some special JTAG reflash snag so
>> >>> we are dependent on maintainers to help out here :-/
>> >>
>> >> Unfortunately, my OMAP1 (omap5912/OSK[1]) died last year and I haven't been
>> >> able to get it booting again.  I wonder if Spectrum Digital still has
>> >> these available?  Their websites[1] says "call for price."
>> >>
>> >> Kevin
>> >>
>> >> [1] http://www.spectrumdigital.com/product_info.php?products_id=39
>> >
>> >
>> > Perhaps dumb question: but are there folks who really care about omap1
>> > boot anymore in upstream? should it be time to deprecate it - say for
>> > 3.17 or so?
>> >
>> > Regards,
>> > Nishanth Menon
>>
>> I know that at least Aaro Koskinen (cc'ed here) still uses mainline on
>> OMAP1 boards and he is always very helpful when is asked to test some
>> changes on this platform.
>>
>> Having said that I also wonder if at least we should split omap
>> drivers to have separate support for DT-only (or in a path to be) and
>> non-DT (and with no work towards migration) platforms. Since trying to
>> support both DT and legacy booting is each time more hard.
>
> It really should not matter what the configuration data for the
> drivers is. Both platform_data and DT data should be easily supported.
>

Yes, I think I expressed myself badly. I actually meant platforms that
keep evolving vs platforms that nobody is active developing on them
and is unlikely that will ever use the newer
infrastructure/API/whatever that is added on the different subsystems.

In the GPIO OMAP driver example we have a lot of #ifdefery to separate
OMAP1 and OMAP2+ code since OMAP1 does not support sparse IRQ (and
probably never will) so it can't dynamically allocate IRQ numbers and
I've seen similar things in other OMAP drivers.

But yes, the maintenance burden is not that much either, I was just
thinking aloud if splitting these drivers would make sense or not.

> And we're moving towards using platform_get_irq() and other functions
> for drivers anyways as that's generic for all the drivers no matter
> what the driver data source is.
>
> Regards,
>
> Tony

Best regards,
Javier
