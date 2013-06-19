From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Wed, 19 Jun 2013 11:45:16 +0200
Message-ID: <8761xaqvrn.fsf@lebrac.rtp-net.org>
References: <20130612171407.GM8164@atomide.com> <51B98F1E.1000006@ti.com>
	<51B99B07.1050806@ti.com>
	<CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
	<CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
	<51BEBDCD.3060104@ti.com> <87ppvlqhyy.fsf@lebrac.rtp-net.org>
	<20130617082458.GH20992@atomide.com>
	<87li69qdcs.fsf@lebrac.rtp-net.org>
	<20130617102650.GK20992@atomide.com>
	<20130618112701.GO5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:50195 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933755Ab3FSJqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 05:46:17 -0400
In-Reply-To: <20130618112701.GO5523@atomide.com> (Tony Lindgren's message of
	"Tue, 18 Jun 2013 04:27:01 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sricharan R <r.sricharan@ti.com>, Ming Lei <tom.leiming@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

Tony Lindgren <tony@atomide.com> writes:

Hi,

> * Tony Lindgren <tony@atomide.com> [130617 03:32]:
>> * Arnaud Patard <arnaud.patard@rtp-net.org> [130617 02:52]:
>> > Tony Lindgren <tony@atomide.com> writes:
>> > 
>> > I understand your concerns but, please, cope with reality: the clock
>> > work is not in -next so this tends to make me think it won't reach
>> > 3.11. We're at -rc6 after all. Telling users that their system doesn't
>> > have any network because it was easier to maintain, is not something
>> > they will understand imho.
>> 
>> Right, like I said: the idea is to have it usable with DT. And USB and
>> Ethernet certainly are part of what I call usable. So is MMC, WLAN and
>> DSS. I've certainly spent quite a bit of time on making sure panda works
>> with DT, and I can assure you that fixing the USB extclock is easier than
>> supporting the legacy boot with DT :)
>> 
>> This issue can also be fixed with a clock alias if we don't have DT
>> defined clocks ready for v3.11. It may take a few days for us to have
>> the solution. But get getting a clock to a driver certainly is not a
>> showstopper here. After all, that's what all drivers already do.
>
> Care to test the last patch just posted by Roger in thread
> " [PATCH 0/4] ARM: OMAP4: Panda USB Host support and DVI EDID fix"?

I tried to test them but they don't apply on linux-next due to some
pinctrl changes probably missing:
Error: arch/arm/boot/dts/omap4-panda-common.dtsi:177.14-15 syntax error

which corresponds to :
0x82 (PIN_INPUT_PULLDOWN | MUX_MODE4)

Also, the patch 3 (ARM: dts: omap5-uevm: Provide USB Host PHY clock)
doesn't apply as the omap5-uevm.dts doesn't exist.

Which tree should I use to test the patches if it's not linux-next ?

Also, you might want to know that drivers/usb/musb/omap2430.c doesn't
build due to some typos (musb_resources vs musb_resouces).

Arnaud

