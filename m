From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Mon, 24 Jun 2013 01:06:37 +0200
Message-ID: <CAAwP0s1DkMu8Vfka43hS4Wj-927q=O5u-coyFsPBgy3qtA_vjw@mail.gmail.com>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com> <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
 <20130516214430.GN5600@atomide.com> <20130520174621.GI10378@atomide.com>
 <20130605223355.EDC113E10E4@localhost> <20130606155341.GL3331@atomide.com> <20130623221605.GA3150@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54148 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3FWXG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jun 2013 19:06:58 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so22319001iec.7
        for <linux-omap@vger.kernel.org>; Sun, 23 Jun 2013 16:06:57 -0700 (PDT)
In-Reply-To: <20130623221605.GA3150@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jgchunter@gmail.com>

On Mon, Jun 24, 2013 at 12:16 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Thu, Jun 06, 2013 at 08:53:41AM -0700, Tony Lindgren wrote:
>> * Grant Likely <grant.likely@secretlab.ca> [130605 15:39]:
>> > On Mon, 20 May 2013 10:46:21 -0700, Tony Lindgren <tony@atomide.com> wrote:
>> > > * Tony Lindgren <tony@atomide.com> [130516 14:50]:
>> > > > * Aaro Koskinen <aaro.koskinen@iki.fi> [130516 14:05]:
>> > > > > On Thu, May 16, 2013 at 11:09:34AM -0700, Tony Lindgren wrote:
>> > > > > > * Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
>> > > > > > > I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
>> > > > > > >
>> > > > > > > [    2.264221] retu-mfd 2-0001: Retu v3.2 found
>> > > > > > > [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
>> > > > > > > [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
>> > > > > > >
>> > > > > > > The error is coming from regmap code. According to git bisect, it is
>> > > > > > > caused by:
>> > > > > > >
>> > > > > > >   commit ede4d7a5b9835510fd1f724367f68d2fa4128453
>> > > > > > >   Author: Jon Hunter <jon-hunter@ti.com>
>> > > > > > >   Date:   Fri Mar 1 11:22:47 2013 -0600
>> > > > > > >
>> > > > > > >       gpio/omap: convert gpio irq domain to linear mapping
>> > > > > > >
>> > > > > > > The commit does not anymore revert cleanly, and I haven't yet tried
>> > > > > > > crafting a manual revert, so any fix proposals/ideas are welcome...
>> > > > > >
>> > > > > > Hmm this might be a bit trickier to fix. Obviously the real solution
>> > > > > > is to convert omap1 to SPARSE_IRQ like we did for omap2+.
>> > > > > >
>> > > > > > For the -rc cycle, it might be possible to fix this by adding a
>> > > > > > different irq_to_gpio() and gpio_to_irq() functions for omap1.
>> > > > >
>> > > > > The commit reverts cleanly if we also revert
>> > > > > 3513cdeccc647d41c4a9ff923af17deaaac04a66 (gpio/omap: optimise interrupt
>> > > > > service routine), which seems to be just some minor optimization. The
>> > > > > result is below, and with it 770 works again.
>> > > >
>> > > > Hmm in this case it seems that we should just fix it rather than go back
>> > > > to the old code, so let's take a look at that first.
>> > >
>> > > Does the following fix it for you or do we need to fix something else
>> > > there too?
>> > >
>> >
>> > Hi Tony,
>> >
>> > Do you want me to apply this fix? It sounds like it solves the symptoms,
>> > but I'd like to know more about what the root cause is.
>> >
>> > Send me your s-o-b line and I'll apply the patch
>>
>> Yes sorry was meaning to send it as a proper patch, but got distracted.
>> Please go ahead and apply it thanks:
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> What is the status of this patch? We're already at 3.10-rc7 and GPIO
> IRQs are still broken on OMAP1.
>
> A.
>

Hello,

There is a problem with this patch.

Currently with DeviceTree, using an OMAP GPIO as an IRQ is broken
since before a driver can request the IRQ line, the GPIO bank has to
be enabled and also the GPIO line has to be setup and configured as
input with gpio_request().

This means that when defining:

                gpio6: gpio@49058000 {
                        compatible = "ti,omap3-gpio";
                        reg = <0x49058000 0x200>;
                        interrupts = <34>;
                        ti,hwmods = "gpio6";
                        gpio-controller;
                        #gpio-cells = <2>;
                        interrupt-controller;
                        #interrupt-cells = <2>;
                };

                interrupt-parent = <&gpio6>;
                interrupts = <16 8>;

The GPIO is correctly mapped as an IRQ but a call to gpio_request() is
never made and thus a all to request_irq() from the driver of the
device using the GPIO-IRQ line fails.

I posted the following patches that adds a custom .map function
handler that calls gpio_request() automatically when an OMAP GPIO line
is mapped as an IRQ:

[v2,1/2] gpio/omap: don't create an IRQ mapping for every GPIO on DT [1].
[v2,2/2] gpio/omap: auto request GPIO as input if used as IRQ via DT [2].

Now, this won't work if we revert to the legacy domain mapping. Of
course we can came with a different solution but it will even more
hack-ish than the one I posted.

So I think that the correct solution is to add SPARSE_IRQ support to
omap1 and not reverting Jon's patch. Of course this may not be
possible since we are so close to 3.10 and most OMAP patches already
merged for 3.11 but we should definitely try to have this at least for
3.12. Otherwise we won't be able to move to DT-only booting for
OMAP2+.

Thanks a lot and best regards,
Javier

[1]: https://patchwork.kernel.org/patch/2764821/
[2]: https://patchwork.kernel.org/patch/2764811/
