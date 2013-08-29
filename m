From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 11:25:43 -0700
Message-ID: <CA+Bv8XavoekzHM6DU3BFdq8W+XK6aGr7bvW60W3L6gR2Cu2p4Q@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<20130829110534.GV10783@sirena.org.uk>
	<CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
	<20130829180101.GO10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:37438 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315Ab3H2SZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 14:25:44 -0400
In-Reply-To: <20130829180101.GO10783@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Kevin Hilman <khilman@linaro.org>

On Thu, Aug 29, 2013 at 11:01 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 29, 2013 at 08:42:11AM -0700, Russ Dill wrote:
>
>> The path I'm taking in this patchset is to just put the board specific
>> I2C sequences necessary for the CM3 coprocessor to write out into the
>> devicetree. I've made it as generic as I can so that other platforms
>> with similar issues can reuse the bindings. Because of the limitations
>> of the firmware size and the desire not to have some sort of byte
>> code, this is a write only sequence.
>
> Making it write only seems to be a mistake - like I said in my other
> mail I'd expect you'd want bitfield updates here.  The read and modify
> could be done earlier by Linux though.

Updating bitfields in memory is pretty basic, but with I2C, each
device has its own register sizes and methods of accessing registers.
The first byte of an I2C sequence being a register address is pretty
common though. You'd need a method of defining in the device tree
piece how to modify bitfields.

>> Kevin Hilman is suggesting some way to query the regulator framework
>> for this sequence. There would be some call to the regulator framework
>> that would return a series of I2C commands that would be necessary to
>> program a regulator to a specific voltage. It would be called twice,
>> once for the suspend voltage, once for the resume voltage. The
>> regulator framework would then call into the driver that sets that
>> voltage, and by some method query the driver for the necessary I2C
>> sequence, either by some special new call, or some regmap magic.
>
> If it's just setting a single voltage then extracting the bitfield to
> update shouldn't be too hard for regmap based regulators.  Off the top
> of my head I'd expect either the driver for the M3 or the cpuidle driver
> that talks to it to be a consumer of the regulator and then go from
> there.

It'd be a list of bitfields. So are you suggesting a regulator_ops
call that would return a list of bitfield updates along with an I2C
controller, an I2C device address, I2C register addressing scheme (8
bit, 16 bit, or other) and the info for each bitfield (register size)?
And then each regulator driver would be updated as needed with this
code. Would this be a way forward? Would regmap actually tie into this
at all?

This is VDD core, so its not related to cpuidle or the M3.

> Just putting the sequence directly into the device tree doesn't feel
> like the right abstraction.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
