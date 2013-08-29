From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 08:42:11 -0700
Message-ID: <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<20130829110534.GV10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:38215 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3H2PmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 11:42:22 -0400
In-Reply-To: <20130829110534.GV10783@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 29, 2013 at 4:05 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 27, 2013 at 06:05:34PM -0700, Russ Dill wrote:
>> On Tue, Aug 27, 2013 at 3:44 PM, Kevin Hilman <khilman@linaro.org> wrote:
>
>> > The framework already has a concept of suspend voltage, suspend mode
>> > etc.  Maybe it needs some generalizing so low-level platform code could
>> > query the framework for the sequence so it can be done late in platform
>> > idle/suspend paths.  Especially for regmap drivers, this seems feasible.
>
>> Yes, my main hesitation for going down this path is possible lack of
>> support for such an interface upstream.
>
> Someone is going to have to walk me through the context for me to fully
> understand what this is all about - what's the problem?
>
> Generally for suspend if the sequencing is being done by the processor
> it's been handled by the drivers for the components in question.  For
> sequencing beyond that you're into hardware features which aren't all
> that regular sadly and often aren't controllable either.  It sounds like
> this is the latter case but the thing that manages some of the late
> power down stages does so using a firmware we can rewrite?

So the AM335X processor has a small M3 coprocessor attached to it. The
M3 coprocessor is in charge of performing many of the sleep and resume
transition steps. It has a 16k code space for firmware. The CM3
coprocessor has access to most of the same registers the primary
AM335X processor has access to (PM registers, clock registers, I2C
controller, etc).

For the deepest sleep modes, the core power supply can have its
voltage reduced, but only after several steps by the CM3 coprocessor
have been performed. The core power supply voltage must be reduced by
the CM3 coprocessor. The core regulator is controlled by I2C on all
the AM335X platforms that I am aware of, but different platforms have
different I2C regulators.

The path I'm taking in this patchset is to just put the board specific
I2C sequences necessary for the CM3 coprocessor to write out into the
devicetree. I've made it as generic as I can so that other platforms
with similar issues can reuse the bindings. Because of the limitations
of the firmware size and the desire not to have some sort of byte
code, this is a write only sequence.

Kevin Hilman is suggesting some way to query the regulator framework
for this sequence. There would be some call to the regulator framework
that would return a series of I2C commands that would be necessary to
program a regulator to a specific voltage. It would be called twice,
once for the suspend voltage, once for the resume voltage. The
regulator framework would then call into the driver that sets that
voltage, and by some method query the driver for the necessary I2C
sequence, either by some special new call, or some regmap magic.
