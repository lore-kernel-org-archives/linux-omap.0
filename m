From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Thu, 20 Jun 2013 23:01:31 -0700
Message-ID: <20130621060131.GH5523@atomide.com>
References: <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
 <51BEBDCD.3060104@ti.com>
 <87ppvlqhyy.fsf@lebrac.rtp-net.org>
 <20130617082458.GH20992@atomide.com>
 <87li69qdcs.fsf@lebrac.rtp-net.org>
 <20130617102650.GK20992@atomide.com>
 <20130618112701.GO5523@atomide.com>
 <8761xaqvrn.fsf@lebrac.rtp-net.org>
 <20130619095837.GY5523@atomide.com>
 <87obb1b5ow.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38290 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161146Ab3FUGBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jun 2013 02:01:36 -0400
Content-Disposition: inline
In-Reply-To: <87obb1b5ow.fsf@lebrac.rtp-net.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, Ming Lei <tom.leiming@gmail.com>

* Arnaud Patard <arnaud.patard@rtp-net.org> [130620 00:36]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> Hi,
> 
> > * Arnaud Patard <arnaud.patard@rtp-net.org> [130619 02:52]:
> >> Tony Lindgren <tony@atomide.com> writes:
> >> 
> >> Hi,
> >> 
> >> > * Tony Lindgren <tony@atomide.com> [130617 03:32]:
> >> >> * Arnaud Patard <arnaud.patard@rtp-net.org> [130617 02:52]:
> >> >> > Tony Lindgren <tony@atomide.com> writes:
> >> >> > 
> >> >> > I understand your concerns but, please, cope with reality: the clock
> >> >> > work is not in -next so this tends to make me think it won't reach
> >> >> > 3.11. We're at -rc6 after all. Telling users that their system doesn't
> >> >> > have any network because it was easier to maintain, is not something
> >> >> > they will understand imho.
> >> >> 
> >> >> Right, like I said: the idea is to have it usable with DT. And USB and
> >> >> Ethernet certainly are part of what I call usable. So is MMC, WLAN and
> >> >> DSS. I've certainly spent quite a bit of time on making sure panda works
> >> >> with DT, and I can assure you that fixing the USB extclock is easier than
> >> >> supporting the legacy boot with DT :)
> >> >> 
> >> >> This issue can also be fixed with a clock alias if we don't have DT
> >> >> defined clocks ready for v3.11. It may take a few days for us to have
> >> >> the solution. But get getting a clock to a driver certainly is not a
> >> >> showstopper here. After all, that's what all drivers already do.
> >> >
> >> > Care to test the last patch just posted by Roger in thread
> >> > " [PATCH 0/4] ARM: OMAP4: Panda USB Host support and DVI EDID fix"?
> >> 
> >> I tried to test them but they don't apply on linux-next due to some
> >> pinctrl changes probably missing:
> >> Error: arch/arm/boot/dts/omap4-panda-common.dtsi:177.14-15 syntax error
> >> 
> >> which corresponds to :
> >> 0x82 (PIN_INPUT_PULLDOWN | MUX_MODE4)
> >
> > Oops, right, that's in Benoit's branch too for the .dts preprocessing.
> > Until it is merged, maybe try with Roger's earlier version of that patch
> > that did not yet use the macros?
> >  
> 
> Right. I've changed the missing macros with their values and now, it
> compiles and I can even ping the board, so works for me.

Good to hear thanks. Sounds like we should have things mostly working
with DT in mainline kernel by v3.11-rc1. I'm sure some minor fixes
will be needed as more people start using it, but they should be
all fixable either by binding changes, or by initializing missing things
using platform data.

Regards,

Tony
