From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Tue, 27 Aug 2013 18:05:34 -0700
Message-ID: <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:62844 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3H1BFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Aug 2013 21:05:35 -0400
In-Reply-To: <87txiasqhk.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@kernel.org>

On Tue, Aug 27, 2013 at 3:44 PM, Kevin Hilman <khilman@linaro.org> wrot=
e:
> [+Mark Brown for regulator suspend sequence ideas]
>
> Russ Dill <Russ.Dill@ti.com> writes:
>
>> On Wed, Aug 14, 2013 at 6:38 AM, Jan L=C3=BCbbe <jlu@pengutronix.de>=
 wrote:
>>> On Tue, 2013-08-13 at 15:20 -0700, Russ Dill wrote:
[snip]
>>> Shouldn't the TPS driver know how to generate this sequence? It see=
ms
>>> fragile to do voltage adjustments behind the back of the regulator
>>> framework and the TPS driver. The wake-sequence values should match=
 the
>>> (in-memory) regulator configuration on resume (which may have been
>>> changed by DVFS).
>>
>> The sequence is both PMIC specific and board specific. Additionally,
>> the PMICs used aren't am335x specific. It would be nice to have the
>> regulator framework and the driver write all this out, but the
>> sequence is written out by the Cortex-M3 processor running some PM
>> firmware. Even if the code was changed to run on the A8, it'd have t=
o
>> run from a small piece of SRAM.
>
> So, why/how was the decision made to use the M3 instead of the MPU
> running from SRAM?
>
> As a firmware minimalist, I obviously prefer to do this from the MPU
> side.  But also, because the M3 is reset every suspend sequence, this
> becomes rather heavy to do from the M3.

After the feedback Vaibhav Bedia received on v2 of his suspend/resume
patchset for am335x, he decided to move many of the operations from
sleep33xx.S into the M3 firmware.

See the commit message here:
http://arago-project.org/git/projects/?p=3Dam33x-cm3.git;a=3Dcommit;h=3D=
a972ce2f6

I need to wait until after the PLLs are put into bypass, which is now
done in the M3 firmware. It also ends up being a lot easier to write
the I2C writer code there in C rather than in assembly in sleep33xx.S.

> Currently voltage scaling is only being proposed for suspend in this
> series, but in theory it's possible from idle as well.  Doing this fr=
om
> the MPU/SRAM seems much better suited for idle.

The M3 firmware will also handle any cpuidle modes deeper than just
putting SDRAM into self refresh. This is actually the only way of
doing things like turning the MPU domain off on am335x.

>> As far as DVFS, I'm not aware of any DVFS implementations that muck
>> with VDD CORE.
>>
>>> The CM3 driver needs to figure out where the core regulator is conn=
ected
>>> using using either DT or the regulator framework and ask the TPS (v=
ia a
>>> new interface) for register writes for sleep/wake sequences. Then t=
hose
>>> sequences will actually match the correct voltages configured using
>>> DT/DVFS.
>>
>> That seems like it'd add a lot of complexity to the regulator
>> subsystem, as well as all the PMIC and other I2C regulators that any
>> users of these device tree properties may end up using for not a lot
>> of gain. There would be two separate code paths for any used
>> I2C regulator or PMIC for setting voltages.
>
> Added Mark for his thoughts on this, but seems like complexity that t=
he
> regulator framework might need to grow anyways.
>
> The framework already has a concept of suspend voltage, suspend mode
> etc.  Maybe it needs some generalizing so low-level platform code cou=
ld
> query the framework for the sequence so it can be done late in platfo=
rm
> idle/suspend paths.  Especially for regmap drivers, this seems feasib=
le.

Yes, my main hesitation for going down this path is possible lack of
support for such an interface upstream.

> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
