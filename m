From: Levi Pearson <levipearson@gmail.com>
Subject: Re: omap4 pandaboard: clock input for TiWi module inactive
Date: Tue, 12 Mar 2013 10:33:06 -0600
Message-ID: <CAEYbN3T97W=74nMG4x4tVECRkff2RSasapvZQowpUwhJtUd=JQ@mail.gmail.com>
References: <CAEYbN3QotnnAUU=7c7=r1sHDnZ5VhgNfXfP6ANf3+ssCzmEa=A@mail.gmail.com>
	<513D9CB7.2010402@ti.com>
	<513DA92F.7020908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:49063 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933107Ab3CLQdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 12:33:12 -0400
Received: by mail-wg0-f45.google.com with SMTP id dq12so29535wgb.24
        for <linux-omap@vger.kernel.org>; Tue, 12 Mar 2013 09:33:11 -0700 (PDT)
In-Reply-To: <513DA92F.7020908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Coelho, Luciano" <coelho@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>

On Mon, Mar 11, 2013 at 3:51 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 03/11/2013 09:58 AM, Roger Quadros wrote:

>
> IMHO the 'hack' in the twl-regulator should not have been removed before we
> provide proper support for the clocks via the common clock framework.
>

I was surprised that this happened in the first place, but I guess it
really wasn't
obvious that it was still in use.

>
> We should have the clock driver under drivers/clk/ via clk-twl6030.c driver
> for all the clocks twl6030 provides and use that in drivers (updating the
> clock tree as well).
>

I spent some more time looking at clk-twl6030.c, and it seems it just turns the
twl6030 chip on when you ask it to enable the clock, and as far as I
can tell that
happens based on module dependencies?  There aren't any explicit references to
it that I can find, so I'm not entirely sure how a clk-twl6040 would
cause a clock
to be enabled.

>>> If for whatever reason the commits cannot be reverted, would creating
>>> a driver like drivers/clk/clk-twl6040.c that enabled the twl6030's
>>> clock output be a suitable alternative?  I'd be willing to take a stab
>>> at writing it if there's not something like that in the works already.
>
> If you can take this it would be great. It is still in my to-do list to
> integrate the clk-twl6040 clock with the omap-mcpdm driver. I already got
> working code, but it is not working in a way I would really wanted to be.
> Integrating external clock to the SoC's clock tree does not seams to be that
> straight forward: at boot time when the clock tree is initialized the external
> chip is yet to be probed -> the root clock is not there, but later on for some
> reason I can not get the CCF to enable the clock tree correctly.

I looked into the early boot clock setup code, and that does look a lot less
straightforward.  There are already a few 32k clocks listed there, and
I *think* they
all source from the twl6040; do they just come up automatically at power-on?
>From what I can tell, clk32kg is just a gated fork of the regular 32k
clock that is
available at boot from twl6040.  I am surprised it doesn't come on by default.

I also don't have a TRM for twl6040 that matches up with what twl-regulator.c is
doing to enable the clk32kg output; it looks like it's adding it to
one of the power
modes, but I'm not entirely sure how the registers it's writing to work, so my
confidence level in being able to get it transplanted to a separate
driver has lowered
quite a bit.

---

--Levi
