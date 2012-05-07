From: Kevin Hilman <khilman@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 07 May 2012 10:15:41 -0700
Message-ID: <87ipg76hfm.fsf@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
	<CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
	<878vicsxef.fsf@ti.com>
	<20120403160706.GP17741@mudshark.cambridge.arm.com>
	<87ehs4pfw4.fsf@ti.com>
	<alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
	<20120404111524.GF32505@mudshark.cambridge.arm.com>
	<20120426180719.GC20186@mudshark.cambridge.arm.com>
	<4FA45580.8070802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39169 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757293Ab2EGRP3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 13:15:29 -0400
Received: by dalf4 with SMTP id f4so4945910dal.1
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 10:15:28 -0700 (PDT)
In-Reply-To: <4FA45580.8070802@ti.com> (Jon Hunter's message of "Fri, 4 May
	2012 17:17:36 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jon-hunter@ti.com> writes:

> Hi Will,
>
> On 04/26/2012 01:07 PM, Will Deacon wrote:
>> On Wed, Apr 04, 2012 at 12:15:24PM +0100, Will Deacon wrote:
>>> On Wed, Apr 04, 2012 at 12:29:49AM +0100, Paul Walmsley wrote:
>>>>
>>>> Part of the problem is that the clockdomain data for the emu_sys=20
>>>> clockdomain is wrong.  Here's something to try to fix it.  It migh=
t just=20
>>>> be enough to get it to work.
>>>
>>> Hmm, doesn't seem to work but I do see the following in dmesg when =
I try to
>>> use perf:
>>>
>>>  powerdomain: waited too long for powerdomain emu_pwrdm to complete=
 transition
>>>
>>> which is new with your patch.
>>=20
>> Sorry to nag, but does anybody have a clue where to go from here? I =
can
>> start digging in the OMAP PM code, but it's all new territory for me=
=2E
>
> I did a little playing around with this today and I think that I have=
 figured out why this was not working (see below). Please can you try t=
he following patch? I tried this on top of your series for perf/omap4.=20
>
> Paul, FYI. If this works for Will then I can re-base on top of the la=
test linux-omap and submit to the mailing list.
>
> Also, the above error about the emu_pwrdm is odd too. I noticed that =
the emu_pwrdm is always in the transitioning state. And when I say alwa=
ys, I mean that even if I check the power domain state while u-boot is =
running it is in the transitioning state. So even before the kernel sta=
rts.=20
>
> Cheers
> Jon=20
>
> From 9137ff9c1b382232de7443db0b51b7555846fb62 Mon Sep 17 00:00:00 200=
1
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Fri, 4 May 2012 16:48:45 -0500
> Subject: [PATCH] ARM: OMAP4: Disable auto enable for EMU CLKDM
>
> The flag CLKDM_CAN_HWSUP allows the clock-domain to automatically tra=
nsition
> to the enabled and disabled state. This means that as soon as we forc=
e a
> software wake-up on the clock domain, the clock domain will be allowe=
d to idle
> and put back into the hardware auto state. For the EMU clock domain t=
his is not
> what we want. We want to keep the clock domain in the software wakeup=
 state
> while the clock domain is being used and put it back in to the hardwa=
re auto
> state when we have finished using the clock domain.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

With this patch, how is the clkdm ever idled?

IIUC, your patch will get PMU interrupts working, but similarily to
previous patches in this thread, it works because it *never* allows the
EMU clkdm to idle.  This is not a mergeable solution because it will no=
t
allow CORE retention (and thus full-chip retention.)

What we need is a solution that allows the clkdm to idle, and then to b=
e
reinitialzed when it wakes up.  Due to the way (I understand) resets in
the debugss, allowing the clkdm to idle will cause a reset, so the
PMU/CTI interrupts need to be reinitialzied after wakeup.

Kevin

P.S. Please note there is also already a different fix in mainline for
the EMU clkdm data from Paul which adds the force wakeup flag and
removes the DISABLE_AUTO flag[1] (but leaves the ENABLE_AUTO flag,
because the hardware is capable.)


[1]
Author: Paul Walmsley <paul@pwsan.com>  2012-04-04 07:25:25
Committer: Paul Walmsley <paul@pwsan.com>  2012-04-04 07:25:25
Parent: c16fa4f2ad19908a47c63d8fa436a1178438c7e7 (Linux 3.3)
Branches: many (164)
=46ollows: v3.4-rc1
Precedes: omap-fixes-a-for-3.4rc, omap-fixes-a2-for-3.4rc

    ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm CLKTRCTR=
L data
   =20
    According to the 4430 ES2.0 TRM vX Table 3-744 "CM_EMU_CLKSTCTRL",
    the emu_sys clockdomain data in mainline is incorrect.
   =20
    The emu_sys clockdomain does not support the DISABLE_AUTO state, an=
d
    instead it supports the FORCE_WAKEUP state.
   =20
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
    Cc: Kevin Hilman <khilman@ti.com>
    Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Cc: Ming Lei <ming.lei@canonical.com>
    Cc: Will Deacon <will.deacon@arm.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
