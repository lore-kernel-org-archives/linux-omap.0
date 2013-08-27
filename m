From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Tue, 27 Aug 2013 15:44:55 -0700
Message-ID: <87txiasqhk.fsf@linaro.org>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62793 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab3H0Wo6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Aug 2013 18:44:58 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so5418527pab.24
        for <linux-omap@vger.kernel.org>; Tue, 27 Aug 2013 15:44:58 -0700 (PDT)
In-Reply-To: <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	(Russ Dill's message of "Wed, 14 Aug 2013 15:21:20 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>, devicetree@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>

[+Mark Brown for regulator suspend sequence ideas]

Russ Dill <Russ.Dill@ti.com> writes:

> On Wed, Aug 14, 2013 at 6:38 AM, Jan L=C3=BCbbe <jlu@pengutronix.de> =
wrote:
>> On Tue, 2013-08-13 at 15:20 -0700, Russ Dill wrote:
>>> The purpose and method of executing these sequences is left up to e=
ach
>>> platform. In the case of the am33xx, the CM3 firmware writes out th=
e
>>> simple I2C sequences.
>>>
>>> Each sequence is a series of I2C write commands. The first byte is =
the
>>> length of the write, the second byte the I2C device to address, and
>>> the following bytes are the message.
>>
>>>         /* Set OPP100 (1.10V) for VDD core */
>>>         wake_sequence =3D /bits/ 8 <
>>>                 0x02 0x2d 0x25 0x2b /* Set VDD2 to 1.1V */
>>>         >;
>>>
>>>         tps: tps@2d {
>>>                 reg =3D <0x2d>;
>>>         };
>>
>>> In the above example, the sequence "0x25 0x1f" is written to the I2=
C
>>> device at address 0x2d (the TPS65910 PMIC). The PMIC interprets tha=
t
>>> as a write to a register at address 0x25.
>>
>>> I'd really like to get some feedback on the devicetree bindings.

Well the first comment (also made by others) is that the DT should be
describing the hardware, and by that rule, the wake/sleep sequences are
not properties of the i2c node but rather properties of the pmic.
You've pointed out the inconveniences caused by that, but I'm not sure
that those are enough to break the basic DT rules there.  I'll leave it
to the DT reviewers to make that decision.

>> Shouldn't the TPS driver know how to generate this sequence? It seem=
s
>> fragile to do voltage adjustments behind the back of the regulator
>> framework and the TPS driver. The wake-sequence values should match =
the
>> (in-memory) regulator configuration on resume (which may have been
>> changed by DVFS).
>
> The sequence is both PMIC specific and board specific. Additionally,
> the PMICs used aren't am335x specific. It would be nice to have the
> regulator framework and the driver write all this out, but the
> sequence is written out by the Cortex-M3 processor running some PM
> firmware. Even if the code was changed to run on the A8, it'd have to
> run from a small piece of SRAM.

So, why/how was the decision made to use the M3 instead of the MPU
running from SRAM?

As a firmware minimalist, I obviously prefer to do this from the MPU
side.  But also, because the M3 is reset every suspend sequence, this
becomes rather heavy to do from the M3.=20

Currently voltage scaling is only being proposed for suspend in this
series, but in theory it's possible from idle as well.  Doing this from
the MPU/SRAM seems much better suited for idle.

> As far as DVFS, I'm not aware of any DVFS implementations that muck
> with VDD CORE.
>
>> The CM3 driver needs to figure out where the core regulator is conne=
cted
>> using using either DT or the regulator framework and ask the TPS (vi=
a a
>> new interface) for register writes for sleep/wake sequences. Then th=
ose
>> sequences will actually match the correct voltages configured using
>> DT/DVFS.
>
> That seems like it'd add a lot of complexity to the regulator
> subsystem, as well as all the PMIC and other I2C regulators that any
> users of these device tree properties may end up using for not a lot
> of gain. There would be two separate code paths for any used
> I2C regulator or PMIC for setting voltages.

Added Mark for his thoughts on this, but seems like complexity that the
regulator framework might need to grow anyways. =20

The framework already has a concept of suspend voltage, suspend mode
etc.  Maybe it needs some generalizing so low-level platform code could
query the framework for the sequence so it can be done late in platform
idle/suspend paths.  Especially for regmap drivers, this seems feasible=
=2E

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
