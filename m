From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Tue, 3 Sep 2013 07:06:01 -0700
Message-ID: <CA+Bv8XYp9zzoYa=-Obr3CW4KmQkB9mswaFj11pxffYqPY7Qwqw@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<20130829110534.GV10783@sirena.org.uk>
	<CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
	<20130829180101.GO10783@sirena.org.uk>
	<CA+Bv8XavoekzHM6DU3BFdq8W+XK6aGr7bvW60W3L6gR2Cu2p4Q@mail.gmail.com>
	<20130829191051.GT10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53246 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760008Ab3ICOGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 10:06:03 -0400
In-Reply-To: <20130829191051.GT10783@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 29, 2013 at 12:10 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 29, 2013 at 11:25:43AM -0700, Russ Dill wrote:
>> On Thu, Aug 29, 2013 at 11:01 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Making it write only seems to be a mistake - like I said in my other
>> > mail I'd expect you'd want bitfield updates here.  The read and modify
>> > could be done earlier by Linux though.
>
>> Updating bitfields in memory is pretty basic, but with I2C, each
>> device has its own register sizes and methods of accessing registers.
>> The first byte of an I2C sequence being a register address is pretty
>> common though. You'd need a method of defining in the device tree
>> piece how to modify bitfields.
>
> I'd not assume byte based addressing for a PMIC, it's very common but
> not universal.  The difficulties here assume putting this in the device
> tree as explicit register I/O - I do tend to agree with Kevin that this
> doesn't seem like the right abstraction.
>
>> > If it's just setting a single voltage then extracting the bitfield to
>> > update shouldn't be too hard for regmap based regulators.  Off the top
>> > of my head I'd expect either the driver for the M3 or the cpuidle driver
>> > that talks to it to be a consumer of the regulator and then go from
>> > there.
>
>> It'd be a list of bitfields. So are you suggesting a regulator_ops
>> call that would return a list of bitfield updates along with an I2C
>> controller, an I2C device address, I2C register addressing scheme (8
>> bit, 16 bit, or other) and the info for each bitfield (register size)?
>> And then each regulator driver would be updated as needed with this
>> code. Would this be a way forward? Would regmap actually tie into this
>> at all?
>
> I was thinking about the majority of regulators where setting a voltage
> would be a single bitfield update (plus ramp delay, which is going to
> need to be accounted for in the power on case).  If we need to do longer
> sequences things get a bit more tricky in terms of interface but it
> seems doable.

The sequence for TPS65217 on beaglebone is rather long, it's 8
register writes. It has to write the new value to the DCDC3 register
and the apply bit to the DCDC register, but both registers are
password locked registers. The password sequence is to write the
password register, then the register, then the password register
again, then the register again.

> regmap would tie in in that it already has a way of describing the
> format for interactions with the device so we could just reuse the same
> description, and with some work we can probably reuse the code that
> generates the bitstreams for sending to the devices too (though I don't
> immediately see a nice way of doing that).
>
> Not sure if this is worth the effort or not though, but then there's the
> whole DT as ABI thing to worry about...
>
>> This is VDD core, so its not related to cpuidle or the M3.
>
> It's related to the M3 if the M3 is managing it; you can have multiple
> consumers for a regulator so it doesn't need to be one or the other.

Ah.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
