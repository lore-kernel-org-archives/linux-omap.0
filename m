From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 10:47:04 -0700
Message-ID: <CA+Bv8Xb38bwby78Q--nEGffBknj5ZD98x0OuRX5N1EFNjbh7zA@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<20130829110534.GV10783@sirena.org.uk>
	<CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
	<20130829154929.GJ10783@sirena.org.uk>
	<CA+Bv8XYbpqQAYwJ3=vkP0gXDMTp7_VNVzB0NXLG6GHDi=Z1img@mail.gmail.com>
	<20130829173022.GN10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:62288 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab3H2RrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 13:47:21 -0400
In-Reply-To: <20130829173022.GN10783@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 29, 2013 at 10:30 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 29, 2013 at 09:31:55AM -0700, Russ Dill wrote:
>> On Thu, Aug 29, 2013 at 8:49 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Why does it have to happen this late and are the sequences definitely
>> > fixed ones not ones that could depend on the system state at the time
>> > we suspend?  It'd help to know what exactly is being controlled here...
>
>> On all am335x platforms, the lower operating point for core voltage
>> cannot be reached without first disabling the DDR controller, and
>> programming it into a lower power mode. For DDR3 platforms, no such
>> lower power mode is available and the lower operating point for core
>> voltage can only be reached with the memory controller disabled.
>
> So this is done from cpuidle rather than system suspend.

It is done for system suspend. It isn't possible to do this in a
cpuidle use case as the memory controller would need to come out of
idle automatically to service DMA requests.

>> It certainly is possible that some bizarre I2C regulator may mix in
>> regulator voltage and some other state into one I2C register. In the
>> case of such a platform, setting the lower operating point would not
>> be supported.
>
> This isn't particularly bizzare, there is no technical reason why a
> register in the PMIC has to be given over completely to setting the
> voltage and indeed there are PMICs in mainline right now which don't do
> that - if you've got 16 bit registers it's probably not going to take
> the entire 16 bits to encode the voltage range.
>
>> > Surely specifying things in terms of the actual sequence would be better
>> > than trying to specify the I2C commands if you want this to be done from
>> > Linux?  If the firmware has to cope directly then this would require the
>> > firmware to understand what it's doing of course.
>
>> I'm not sure what you mean by "actual sequence". Maybe if I show you a
>> couple examples, it will be more clear:
>
> I mean describe the intended sequence of events in the system rather
> than the raw register commands to accomplish them.

I'm still not sure what you mean.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
