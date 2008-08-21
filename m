From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 19:11:37 +0300 (EEST)
Message-ID: <20080821.191137.256717219.Hiroshi.DOYU@nokia.com>
References: <13B9B4C6EF24D648824FF11BE896716203621E71D9@dlee02.ent.ti.com>
	<20080821.104149.169747270.Hiroshi.DOYU@nokia.com>
	<13B9B4C6EF24D648824FF11BE89671620364E2B470@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29439 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYHUQLx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 12:11:53 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620364E2B470@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com
Cc: tony@atomide.com, felipe.contreras@gmail.com, h-kanigeri2@ti.com, soni.trilok@gmail.com, vpasam@ti.com, linux-omap@vger.kernel.org, siarhei.siamashka@nokia.com, x00omar@ti.com, grgupta@ti.com

Hi Richard,

From: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 07:34:56 -0500

> 
> > From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> ...
> > > A few quick comments:
> > >
> > > - First off, I do like the idea of virtual clocks for grouping.  I
> > > did do this for OMAP2 for completely internal and dependent root
> > > clocks.  I also thought it might be nice to extend clock frame work
> > > to allow external clock registration (say for a codec chip).  In our
> > > local tree I did even add it.  One main issue was the internal clock
> > > structure is supposed to be opaque and you need to set internals to
> > > add a clock node.
> >
> > Can I find your OMAP2 implementation in omapzoom for virtual clock?
> 
> Guess not.  The flag for OMAP2 is still there in linux-omap clock.h
> for virt_prcm_set but the implementation of it evolved to just using
> custom recalc/rate/round functions.  Today the flag just would tell
> a user something is funny about the clock but no rules are enforced.
> 
> Actually in looking at this does bring up another very relevant
> question.
> 
> For a combined clock especially like the IVA-system, how do you do
> set_rate/round_rate/get_rate/set_parent so it is meaningful?
>
> For virt_prcm_set the MPU clock rate is used as in index.  For OMAP2
> for most cases there are very strict rules about speed ratio's. As
> such if you know the speed for 1 clock you can set the group.
> mpu_rate isn't perfect but it is good enough.
> 
> You need operations for more than enable/disable.
> 
> How do you set parent to your timer in your example?  How do you
> query individual other clocks rate?

I think that, in this virtual clock, frequency changing will be done
in the totally different path(just in a normal clock tree). This
virtual clock resides in an independent clock tree and supposed to be
used aggressively just to turn on/off clocks(enable/disable), which
drivers use, for saving power consumption. So the relationship between
"clk" and "vclk" may be similar to "struct device" and "struct class"
in the linux driver-model, which means that, the former is based on
H/W connection and the latter is based on functionality. Of course
there is a possibility that other clk methods can be overwritten, but
it's has to be used for different purpose than a normal clock does,
not to break the H/W clock tree consistency.

Also, making a connection among virtual clocks(parenting) can be done
by overwriting "set_parent" for vclk, which is original set NULL, if
necessary.

A virtual clock is composed of clocks which are called "child", but
they are not children actually, from the clock framework point of
view. These clocks reside in a H/W clock tree and a virtual clock just
provide operation to handle them at once, from completely independent
(virtual)clock (tree), for device driver.

In the previous example,

>    dsp_clocks(v)
>    |
>    |-- peripheral_clocks(v)
>    |     |
>    |     |-- gpt5(v)
>    |     |    |- gpt5_ick(r)
>    |     |    `- gpt5_fck(r)
>    |
>    |-- ....
>    ..

Virtually we can make the connection between "dsp_clocks",
"peripheral_clocks" and "gpt5", if we overwrite set_parent for
vclk. but there's no connection between gpt5(virt) and gpt5_*(real)
from the clock framework point of view.

(v) -> (v) OK
(r) -> (r) OK
(v) -> (r) NG : cause inconsistency on h/w clock tree.

v: virtual clock
r: real clock
some flags can be used to prevent the above inconsistency.

Probably original "virt_prcm_set" might have a wider solution,
though....

      Hiroshi DOYU


