From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Thu, 04 Jun 2009 14:38:03 -0700
Message-ID: <87fxeffzno.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D5372B95@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:56273 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbZFDViG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 17:38:06 -0400
Received: by pzk1 with SMTP id 1so430906pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 14:38:07 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D5372B95@zmy16exm69.ds.mot.com> (Wang Sawsd-A's message of "Fri\, 5 Jun 2009 03\:42\:42 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

"Wang Sawsd-A24013" <cqwang@motorola.com> writes:

> =20
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Wang=20
>> Sawsd-A24013
>> Sent: 2009=E5=B9=B46=E6=9C=885=E6=97=A5 1:43
>> To: Kevin Hilman
>> Cc: linux-omap@vger.kernel.org; nm@ti.com; Mike Chan
>> Subject: RE: [PATCH] OMAP2/3 Avoid GPIO pending irq status=20
>> been set after irq_disable
>>=20
>>=20
>>=20
>> > -----Original Message-----
>> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
>> > Sent: 2009=E5=B9=B46=E6=9C=885=E6=97=A5 1:04
>> >=20
>> > Dumb question: Why use level?  Why not use falling edge for this?
>> >=20
>> A good question, :-) We did use edge interrupt before, see=20
>> the reason below.
>>=20
>> > > The issue is, after the touch driver calls irq_disable,=20
>> since it is
>> > > empty unless
>> > > Set the IRQ_DISABLED flag, so next time only the generic handler
>> > > function
>> > > handle_level_irq is called, this handler just ack to OMAP=20
>> > GPIO IRQ that
>> > > is
>> > > To clear the IRQ status and mask the GPIO on OMAP side,=20
>> but since NO
>> > > Touch driver IRQ action is called, so the touch Controller=20
>> > can not gets
>> > > acknowledged, then the interrupt line will be always driven=20
>> > low by the
>> > > external controller,=20
>> >=20
>> > If the GPIO is set to be edge triggered, the fact that it=20
>> is still low
>> > won't matter, the genirq layer will have noticed a pending=20
>> interrupt.
>> >=20
>> If we use edge interrupt here, the potential issue is still=20
>> existing, and also
>> We are liky to lose the interrupt.
>> After irq_disable and before HW suspend, if the interrupt=20
>> line is driven low,
>> Then OMAP GPIO can catch this edge transition, so the IRQ is set,
>> Then the handle_edge_irq will clear the IRQ staus and mask the IRQ.
>> Since the controller is not ACKed, then the interrupt line is=20
>> always driven low,
>> Then from then on, no edge can happen, and no more Touch=20
>> interrupt can happen
>> Even when irq_enable is called, though we have the prepare=20
>> for idle hooks,
>> But that only work when the edge transition happens after=20
>> that prepare call,
>> Since it saves the GPIO data IN at that time, if the input=20
>> level already changes
>> Before that time, then the workaround does not work.=20
>>=20
>> We ever made another patch to not only compare the data in,=20
>> but also check
>> It is rising or falling edge, and check the CURRENT input=20
>> level to decide whether to
>> Use LEVEL detect to manually trigger the interrupt, it works=20
>> fine with our HW.
>> But later on, touch cotroller driver is updated to use level=20
>> detect, then we
>> Met this issue. I think the patch we made to workaround the=20
>> edge int lost is also needed
>> In current pm branch, currently we may still face the issue I=20
>> mentioned above.
>
> I rechecked the code, seems the issue will not be there since
> The handle_edge_irq can resend irq during resume time, then

Yes, I was actually replying to ask you to check why the retrigger
wasn't happening in your kernel. =20

> I checked our issue log and found, the reason that we lose
> The edge interrupt is because we were using omapzoom kernel

I was starting to think you were not actually using the linux-omap
kernel (looks like I was right.)

> And put PER to fully HW supervised mode and we didn't use
> The prepare idle hooks in our idle function call, then the issues
> Happens when PER is in RET/OFF state but the touch interrupt happens.
>
> With linux-omap kernel, seems using edge interrupt can just workaroun=
d
> The touch issue,=20

Good.

>but I think the issue is still there, we can not expect All the GPIO
>interrupts to be edge type, and we can not expect all the edge
>Interrupts to fire only once, with open platforms, every kind of
>peripherals We may use,=20

I completely agree.  You have definitely found a robustness problem in
the GPIO core that will be relatively easy to run into in the future.

>the change to root fix this problem should be still clearing The
>level/edge detection when irq_disable is called. This will not cause
>Extra interrupt loss since we still have the prepare/resume hooks to
>check Gpio input and retrigger the interrupts.

What do you think about disabling the level/edge detection when
disable_irq_wake() is called instead?  This seems more logical
and expected.

Kevin

P.S., are you wanting to use your touchscreen as a wakeup source?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
