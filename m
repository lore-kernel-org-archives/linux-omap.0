From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Wed, 19 Jun 2013 02:58:37 -0700
Message-ID: <20130619095837.GY5523@atomide.com>
References: <51B99B07.1050806@ti.com>
 <CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
 <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
 <51BEBDCD.3060104@ti.com>
 <87ppvlqhyy.fsf@lebrac.rtp-net.org>
 <20130617082458.GH20992@atomide.com>
 <87li69qdcs.fsf@lebrac.rtp-net.org>
 <20130617102650.GK20992@atomide.com>
 <20130618112701.GO5523@atomide.com>
 <8761xaqvrn.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29043 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933873Ab3FSJ6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 05:58:42 -0400
Content-Disposition: inline
In-Reply-To: <8761xaqvrn.fsf@lebrac.rtp-net.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Sricharan R <r.sricharan@ti.com>, Ming Lei <tom.leiming@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

* Arnaud Patard <arnaud.patard@rtp-net.org> [130619 02:52]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> Hi,
> 
> > * Tony Lindgren <tony@atomide.com> [130617 03:32]:
> >> * Arnaud Patard <arnaud.patard@rtp-net.org> [130617 02:52]:
> >> > Tony Lindgren <tony@atomide.com> writes:
> >> > 
> >> > I understand your concerns but, please, cope with reality: the clock
> >> > work is not in -next so this tends to make me think it won't reach
> >> > 3.11. We're at -rc6 after all. Telling users that their system doesn't
> >> > have any network because it was easier to maintain, is not something
> >> > they will understand imho.
> >> 
> >> Right, like I said: the idea is to have it usable with DT. And USB and
> >> Ethernet certainly are part of what I call usable. So is MMC, WLAN and
> >> DSS. I've certainly spent quite a bit of time on making sure panda works
> >> with DT, and I can assure you that fixing the USB extclock is easier than
> >> supporting the legacy boot with DT :)
> >> 
> >> This issue can also be fixed with a clock alias if we don't have DT
> >> defined clocks ready for v3.11. It may take a few days for us to have
> >> the solution. But get getting a clock to a driver certainly is not a
> >> showstopper here. After all, that's what all drivers already do.
> >
> > Care to test the last patch just posted by Roger in thread
> > " [PATCH 0/4] ARM: OMAP4: Panda USB Host support and DVI EDID fix"?
> 
> I tried to test them but they don't apply on linux-next due to some
> pinctrl changes probably missing:
> Error: arch/arm/boot/dts/omap4-panda-common.dtsi:177.14-15 syntax error
> 
> which corresponds to :
> 0x82 (PIN_INPUT_PULLDOWN | MUX_MODE4)

Oops, right, that's in Benoit's branch too for the .dts preprocessing.
Until it is merged, maybe try with Roger's earlier version of that patch
that did not yet use the macros?
 
> Also, the patch 3 (ARM: dts: omap5-uevm: Provide USB Host PHY clock)
> doesn't apply as the omap5-uevm.dts doesn't exist.

OK that's in Benoit's branch. But you won't need that one.
 
> Which tree should I use to test the patches if it's not linux-next ?
> 
> Also, you might want to know that drivers/usb/musb/omap2430.c doesn't
> build due to some typos (musb_resources vs musb_resouces).

Thanks, I think Felipe is already aware of that. 

Regards,

Tony
