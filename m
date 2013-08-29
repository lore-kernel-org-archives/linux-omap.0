From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 09:31:55 -0700
Message-ID: <CA+Bv8XYbpqQAYwJ3=vkP0gXDMTp7_VNVzB0NXLG6GHDi=Z1img@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<20130829110534.GV10783@sirena.org.uk>
	<CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
	<20130829154929.GJ10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:52915 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab3H2Qb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 12:31:56 -0400
In-Reply-To: <20130829154929.GJ10783@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 29, 2013 at 8:49 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 29, 2013 at 08:29:37AM -0700, Kevin Hilman wrote:
>> On Thu, Aug 29, 2013 at 4:05 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Someone is going to have to walk me through the context for me to fully
>> > understand what this is all about - what's the problem?
>
>> The basic problem is how to have low-level platform code (or possibly
>> firmware) send commands to a regulator to scale voltage.  This has to
>> happen *very* late in the suspend process, so having the drivers do it
>> themselves is not feasible.
>
> Why does it have to happen this late and are the sequences definitely
> fixed ones not ones that could depend on the system state at the time
> we suspend?  It'd help to know what exactly is being controlled here...

On all am335x platforms, the lower operating point for core voltage
cannot be reached without first disabling the DDR controller, and
programming it into a lower power mode. For DDR3 platforms, no such
lower power mode is available and the lower operating point for core
voltage can only be reached with the memory controller disabled.

It certainly is possible that some bizarre I2C regulator may mix in
regulator voltage and some other state into one I2C register. In the
case of such a platform, setting the lower operating point would not
be supported.

>> The proposal in this series is to define the i2c commands sequence to
>> be sent to the regulator in the i2c node of the DT.  The
>> platform-specific code then reads the sequence from the DT and sends
>> the commands (or in in the case of the current series, passes the
>> sequence to some firmware on a microcontroller which does the
>> sequence.)
>
> Surely specifying things in terms of the actual sequence would be better
> than trying to specify the I2C commands if you want this to be done from
> Linux?  If the firmware has to cope directly then this would require the
> firmware to understand what it's doing of course.

I'm not sure what you mean by "actual sequence". Maybe if I show you a
couple examples, it will be more clear:

This is for the AM335X-EVM which has a TPS65910. The first byte is the
number of bytes to write, the second byte is the I2C device to write
those bytes to, the third byte happens to be a register address on the
TPS65910, and the 4th byte happens to be the value for 0.95V and 1.1V
respectively.

/* Set OPP50 (0.95V) for VDD core on TPS65910 */
sleep_sequence = /bits/ 8 <
        0x02 0x2d 0x25 0x1f /* Set VDD2 to 0.95V */
>;

/* Set OPP100 (1.10V) for VDD core on TPS65910 */
wake_sequence = /bits/ 8 <
        0x02 0x2d 0x25 0x2b /* Set VDD2 to 1.1V */
>;

These next sequences are for the Beaglebone which has a different
PMIC. The format is the same, but the PMIC requires an unlock sequence
to be performed for certain registers and it also requires an
additional step to apply DCDC changes:

/* Set OPP50 (0.95V) for VDD core on TPS65217 */
sleep_sequence = /bits/ 8 <
        0x02 0x24 0x0b 0x6d /* Password unlock 1 */
        0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
        0x02 0x24 0x0b 0x6d /* Password unlock 2 */
        0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
        0x02 0x24 0x0b 0x6c /* Password unlock 1 */
        0x02 0x24 0x11 0x86 /* Apply DCDC changes */
        0x02 0x24 0x0b 0x6c /* Password unlock 2 */
        0x02 0x24 0x11 0x86 /* Apply DCDC changes */
>;

/* Set OPP100 (1.10V) for VDD core on TPS65217 */
wake_sequence = /bits/ 8 <
        0x02 0x24 0x0b 0x6d /* Password unlock 1 */
        0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
        0x02 0x24 0x0b 0x6d /* Password unlock 2 */
        0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
        0x02 0x24 0x0b 0x6c /* Password unlock 1 */
        0x02 0x24 0x11 0x86 /* Apply DCDC changes */
        0x02 0x24 0x0b 0x6c /* Password unlock 2 */
        0x02 0x24 0x11 0x86 /* Apply DCDC changes */
>;
