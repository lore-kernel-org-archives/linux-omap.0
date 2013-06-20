From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Thu, 20 Jun 2013 09:29:51 +0200
Message-ID: <87obb1b5ow.fsf@lebrac.rtp-net.org>
References: <51B99B07.1050806@ti.com>
	<CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
	<CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
	<51BEBDCD.3060104@ti.com> <87ppvlqhyy.fsf@lebrac.rtp-net.org>
	<20130617082458.GH20992@atomide.com>
	<87li69qdcs.fsf@lebrac.rtp-net.org>
	<20130617102650.GK20992@atomide.com>
	<20130618112701.GO5523@atomide.com>
	<8761xaqvrn.fsf@lebrac.rtp-net.org>
	<20130619095837.GY5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:33660 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3FTHao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 03:30:44 -0400
In-Reply-To: <20130619095837.GY5523@atomide.com> (Tony Lindgren's message of
	"Wed, 19 Jun 2013 02:58:37 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, Ming Lei <tom.leiming@gmail.com>

Tony Lindgren <tony@atomide.com> writes:

Hi,

> * Arnaud Patard <arnaud.patard@rtp-net.org> [130619 02:52]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> Hi,
>> 
>> > * Tony Lindgren <tony@atomide.com> [130617 03:32]:
>> >> * Arnaud Patard <arnaud.patard@rtp-net.org> [130617 02:52]:
>> >> > Tony Lindgren <tony@atomide.com> writes:
>> >> > 
>> >> > I understand your concerns but, please, cope with reality: the clock
>> >> > work is not in -next so this tends to make me think it won't reach
>> >> > 3.11. We're at -rc6 after all. Telling users that their system doesn't
>> >> > have any network because it was easier to maintain, is not something
>> >> > they will understand imho.
>> >> 
>> >> Right, like I said: the idea is to have it usable with DT. And USB and
>> >> Ethernet certainly are part of what I call usable. So is MMC, WLAN and
>> >> DSS. I've certainly spent quite a bit of time on making sure panda works
>> >> with DT, and I can assure you that fixing the USB extclock is easier than
>> >> supporting the legacy boot with DT :)
>> >> 
>> >> This issue can also be fixed with a clock alias if we don't have DT
>> >> defined clocks ready for v3.11. It may take a few days for us to have
>> >> the solution. But get getting a clock to a driver certainly is not a
>> >> showstopper here. After all, that's what all drivers already do.
>> >
>> > Care to test the last patch just posted by Roger in thread
>> > " [PATCH 0/4] ARM: OMAP4: Panda USB Host support and DVI EDID fix"?
>> 
>> I tried to test them but they don't apply on linux-next due to some
>> pinctrl changes probably missing:
>> Error: arch/arm/boot/dts/omap4-panda-common.dtsi:177.14-15 syntax error
>> 
>> which corresponds to :
>> 0x82 (PIN_INPUT_PULLDOWN | MUX_MODE4)
>
> Oops, right, that's in Benoit's branch too for the .dts preprocessing.
> Until it is merged, maybe try with Roger's earlier version of that patch
> that did not yet use the macros?
>  

Right. I've changed the missing macros with their values and now, it
compiles and I can even ping the board, so works for me.

Thanks,
Arnaud
