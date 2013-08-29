From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 12:11:42 -0700
Message-ID: <874na8xqfl.fsf@linaro.org>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<87ppsw7cgq.fsf@linaro.org>
	<CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52686 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab3H2TLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 15:11:47 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so846883pdj.3
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 12:11:46 -0700 (PDT)
In-Reply-To: <CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
	(Russ Dill's message of "Thu, 29 Aug 2013 09:10:51 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Russ Dill <Russ.Dill@ti.com> writes:

> On Thu, Aug 29, 2013 at 8:17 AM, Kevin Hilman <khilman@linaro.org> wr=
ote:
>> Russ Dill <Russ.Dill@ti.com> writes:
>>
>>> On Tue, Aug 27, 2013 at 3:44 PM, Kevin Hilman <khilman@linaro.org> =
wrote:
>>>> [+Mark Brown for regulator suspend sequence ideas]
>>>>
>>>> Russ Dill <Russ.Dill@ti.com> writes:
>>>>
>>>>> On Wed, Aug 14, 2013 at 6:38 AM, Jan L=C3=BCbbe <jlu@pengutronix.=
de> wrote:
>>>>>> On Tue, 2013-08-13 at 15:20 -0700, Russ Dill wrote:
>>> [snip]
>>>>>> Shouldn't the TPS driver know how to generate this sequence? It =
seems
>>>>>> fragile to do voltage adjustments behind the back of the regulat=
or
>>>>>> framework and the TPS driver. The wake-sequence values should ma=
tch the
>>>>>> (in-memory) regulator configuration on resume (which may have be=
en
>>>>>> changed by DVFS).
>>>>>
>>>>> The sequence is both PMIC specific and board specific. Additional=
ly,
>>>>> the PMICs used aren't am335x specific. It would be nice to have t=
he
>>>>> regulator framework and the driver write all this out, but the
>>>>> sequence is written out by the Cortex-M3 processor running some P=
M
>>>>> firmware. Even if the code was changed to run on the A8, it'd hav=
e to
>>>>> run from a small piece of SRAM.
>>>>
>>>> So, why/how was the decision made to use the M3 instead of the MPU
>>>> running from SRAM?
>>>>
>>>> As a firmware minimalist, I obviously prefer to do this from the M=
PU
>>>> side.  But also, because the M3 is reset every suspend sequence, t=
his
>>>> becomes rather heavy to do from the M3.
>>>
>>> After the feedback Vaibhav Bedia received on v2 of his suspend/resu=
me
>>> patchset for am335x, he decided to move many of the operations from
>>> sleep33xx.S into the M3 firmware.
>>>
>>> See the commit message here:
>>> http://arago-project.org/git/projects/?p=3Dam33x-cm3.git;a=3Dcommit=
;h=3Da972ce2f6
>>
>> Was this feedback on the public lists?  That patch has never been po=
sted
>> to linux-omap AFAICT.
>>
>>> I need to wait until after the PLLs are put into bypass, which is n=
ow
>>> done in the M3 firmware. It also ends up being a lot easier to writ=
e
>>> the I2C writer code there in C rather than in assembly in sleep33xx=
=2ES.
>>
>> hmm, (carefully) written functions in C can still be copied to SRAM.=
  I
>> dont' see that as an obstacle.
>>
>>>> Currently voltage scaling is only being proposed for suspend in th=
is
>>>> series, but in theory it's possible from idle as well.  Doing this=
 from
>>>> the MPU/SRAM seems much better suited for idle.
>>>
>>> The M3 firmware will also handle any cpuidle modes deeper than just
>>> putting SDRAM into self refresh. This is actually the only way of
>>> doing things like turning the MPU domain off on am335x.
>>
>> Yes, it will have to handle the MPU/interconnect off parts but other
>> than that, that's the only thing it *has* to do (well, and handle wa=
keup
>> from the deep state.)  The rest of the stuff being piled into the M3=
 is
>> a result of software/firmware design decisions AFAICT.  As I predict=
ed
>> when I first saw this SoC design, the firmware is getting bigger and
>> bigger.  Initially it was argued that it would be tiny, and only han=
dle
>> the things it had to do.  Now it's growing due to "convenience".  IM=
O,
>> this is a bad trend, and one that will make this code more and more
>> difficult to maintain upstream (assuming that's a goal.)
>
> Do you mean upstream as in the firmware upstream, or upstream as in
> the kernel upstream? Upstream kernel is really easy to maintain
> because sleep33xx.S just puts the SDRAM into self-refresh.

I mean making the kernel "simple" at the price of more complicated (and
much less reviewed) firmware code is a bad trend.  I understand the
desire to move this stuff into firmware and bypass the kernel review
process, but I predict it will backfire.

> The code to perform these transitions is going to exist, either in
> kernel or in firmware. If you are looking for this to be maintainable
> C code that is copied into SRAM, it will need to be built much like a
> firmware, with it's elf sections being copied into SRAM properly.=20

You're making it too complicated.  No need for ELF, etc.

So the argument for moving much of the stuff from the kernel (in the
patch you referenced above) was that the "assembly code is quite big an=
d
folks have found it hard to review and fixup issues in this dense piece
of code."  (interestingly, it was moved to firmware where it will see
even less review, but that's off topic.)

My idea was that if reviewing assembly is the issue, why not carefully
write a self-contained C function that can be copied to SRAM.  It might
need a little stub in SRAM to setup the stack etc., but it should be
quite doable.  That eliminates the problem cited as the reason for the
move to M3.

> I'm not sure how much it complicates things, but the code needs to be
> able to run with the MMU on and MMU off. The C code would be a
> minimalized duplication of much of what is already in
> mach-omap2. Because you are proposing to split this up between A8 and
> M3, much of that code would then be duplicated again within the M3
> firmware.
>
> And don't forget that am335x is just the first platform with such a P=
M scheme.

IMO, all the more reason to handle it in Linux, not in platform-specifi=
c firmware.

> Because the M3 firmware already has to manage power domains, hwmods,
> plls, and clockdomains, adding or removing which ones it handles
> doesn't really change the size or complexity of the firmware.=20

No, but it significantly complicates its interaction with Linux, which
also has to know about all these things already.  IMO, as I've stated
from the very beginning of this SoC, there should be a very clean split=
=2E
M3 should only handle the minimum, what the MPU simply cannot do
(MPU/interconnect off, wakeup).  MPU/Linux should handle the rest.

> In fact, because so much of the code is common code, moving this into
> kernel would just mean making two copies of the firmware with
> different steps to be run, one for the A8 SRAM, one for the M3.

Maybe I'm getting confused, but the more you talk about the linux and
the firmware doing the same code, the more I think the firmware is
(trying) to do too much.  If this is going to be understandable (and
maintainable), there needs to be a clean split of roles between the MPU
and the M3.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
