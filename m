From: Levi Pearson <levipearson@gmail.com>
Subject: Re: omap4 pandaboard: clock input for TiWi module inactive
Date: Wed, 13 Mar 2013 10:12:20 -0600
Message-ID: <CAEYbN3Sh+ECYO6jYXNQ6oz5s=y4v44Se8JtUx994eLSJSnjZQA@mail.gmail.com>
References: <CAEYbN3QotnnAUU=7c7=r1sHDnZ5VhgNfXfP6ANf3+ssCzmEa=A@mail.gmail.com>
	<513D9CB7.2010402@ti.com>
	<513DA92F.7020908@ti.com>
	<CAEYbN3T97W=74nMG4x4tVECRkff2RSasapvZQowpUwhJtUd=JQ@mail.gmail.com>
	<51403905.3020102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44808 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392Ab3CMQMW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 12:12:22 -0400
Received: by mail-wg0-f47.google.com with SMTP id dr13so1148217wgb.14
        for <linux-omap@vger.kernel.org>; Wed, 13 Mar 2013 09:12:21 -0700 (PDT)
In-Reply-To: <51403905.3020102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Coelho, Luciano" <coelho@ti.com>, linux-omap@vger.kernel.org, Balaji T Krishnamoorthy <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

On Wed, Mar 13, 2013 at 2:29 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 03/12/2013 05:33 PM, Levi Pearson wrote:
>> I spent some more time looking at clk-twl6030.c, and it seems it just turns the
>> twl6030 chip on when you ask it to enable the clock, and as far as I
>> can tell that
>> happens based on module dependencies?  There aren't any explicit references to
>> it that I can find, so I'm not entirely sure how a clk-twl6040 would
>> cause a clock
>> to be enabled.
>
> The clk-twl6040 is not really a good example for you start with. We only need
> it to turn on in order to get the clock on the output. But the principle is
> the same at the end. you need to enable/disable the clock from twl6030...
>

Well, it's at least a nice minimal example of how to interface with the clk API.

>> I looked into the early boot clock setup code, and that does look a lot less
>> straightforward.
>
> Yes, this is what I thought for the twl6040 clock integration with McPDM. It
> turned out a bit more complicated.
> At boot time you do not have the twl clock driver loaded.
> You have the clock tree already defined.
> When you boot further you add the clock for twl6040.

I can't see where exactly this is done, though.  I think I'm just
going to have to
poke around the clock trees for other platforms or something to see how it's
normally done, but unfortunately my time to work on this is pretty limited too!

> You want to hook it up with the existing clock tree - to set it as parent of
> one of the clock root (which you already modified to not to be the root clock).
> I shall work, but it does not:
> for external chips we need to do the configuration/enable in clk_prepare time
> (because they are over i2c).
> So the driver goes and asks for a clock (which supposed to be at the end
> rooted to this new external clock).
> Nothing happens.
> The relevant clock tree has been already got prepared earlier so new prepare
> will not going to go down to the root, leaving the root clock disabled.
>
> I'm still looking a way to somehow fix this, but my time is limited right now.

Is it possible to do static config on the clocks to create the basic
structure during
the early boot phase, and then add the dynamic control functions to
the structure
later after i2c has been set up?  See below for more details, but TWL6030 is the
parent of all 32k clocks on the board, it just enables some of them by
default when
it's powered on.  Seems like that should be reflected in the early set
up structure.

>> There are already a few 32k clocks listed there, and
>> I *think* they
>> all source from the twl6040; do they just come up automatically at power-on?
>> From what I can tell, clk32kg is just a gated fork of the regular 32k
>> clock that is
>> available at boot from twl6040.  I am surprised it doesn't come on by default.
>
> I have not checked the schematics, but it could be that we have crystal 32K on
> board as well. TWL6030 can gate some of it's 32K outputs and this is the case
> with WiLink on PandaBoard.

There is a crystal 32k; it's connected directly to TWL6030 via OSC32KIN and
OSC32KOUT.  There are also 3 gated outputs:
  * CLK32K_AUD  <- this goes to TWL6040 as the CLK32K input of its PLL block
  * CLK32K_MAIN  <- this goes to OMAP4430's SYS32K input
  * CLK32K_GATE  <- this is goes to WL172x chip's SLOW_CLK input

And those are all the 32k clocks on the board.  No one gets a 32k clock except
through TWL6030, though I guess there may be some internal 32k clock gating
inside the OMAP. The question in the back of my mind is why CLK32K_AUD and
CLK32K_MAIN are enabled by default in the power modes we use but
CLK32K_GATE is not.  Or... maybe it is and we are specifically disabling it
somewhere?

>> I also don't have a TRM for twl6040 that matches up with what twl-regulator.c is
>> doing to enable the clk32kg output; it looks like it's adding it to
>> one of the power
>> modes, but I'm not entirely sure how the registers it's writing to work, so my
>> confidence level in being able to get it transplanted to a separate
>> driver has lowered
>> quite a bit.
>
> I'm not sure if I have twl6030 TRM either, but I can try to come up with a
> basic driver for the twl6030 clocks.

I actually found a TRM for it on google, but the register addresses in
the code don't
seem to match up with what's documented in the TRM I have.  Wouldn't
be the first
time that external docs didn't list all the registers....

---

     --Levi
