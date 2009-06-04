From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Fri, 5 Jun 2009 01:43:06 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5372B8F@zmy16exm69.ds.mot.com>
References: <87r5y0gcc4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:17010 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZFDRnt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:43:49 -0400
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n54HhoB3004139
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 10:43:50 -0700 (MST)
Received: from il06vts03.mot.com (il06vts03.mot.com [129.188.137.143])
	by il06exr03.mot.com (8.13.1/Vontu) with SMTP id n54Hhn5x004653
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 12:43:49 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id n54Hhm5f004647
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 12:43:49 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87r5y0gcc4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Sent: 2009=C4=EA6=D4=C25=C8=D5 1:04
>=20
> Dumb question: Why use level?  Why not use falling edge for this?
>=20
A good question, :-) We did use edge interrupt before, see the reason b=
elow.

> > The issue is, after the touch driver calls irq_disable, since it is
> > empty unless
> > Set the IRQ_DISABLED flag, so next time only the generic handler
> > function
> > handle_level_irq is called, this handler just ack to OMAP=20
> GPIO IRQ that
> > is
> > To clear the IRQ status and mask the GPIO on OMAP side, but since N=
O
> > Touch driver IRQ action is called, so the touch Controller=20
> can not gets
> > acknowledged, then the interrupt line will be always driven=20
> low by the
> > external controller,=20
>=20
> If the GPIO is set to be edge triggered, the fact that it is still lo=
w
> won't matter, the genirq layer will have noticed a pending interrupt.
>=20
If we use edge interrupt here, the potential issue is still existing, a=
nd also
We are liky to lose the interrupt.
After irq_disable and before HW suspend, if the interrupt line is drive=
n low,
Then OMAP GPIO can catch this edge transition, so the IRQ is set,
Then the handle_edge_irq will clear the IRQ staus and mask the IRQ.
Since the controller is not ACKed, then the interrupt line is always dr=
iven low,
Then from then on, no edge can happen, and no more Touch interrupt can =
happen
Even when irq_enable is called, though we have the prepare for idle hoo=
ks,
But that only work when the edge transition happens after that prepare =
call,
Since it saves the GPIO data IN at that time, if the input level alread=
y changes
Before that time, then the workaround does not work.=20

We ever made another patch to not only compare the data in, but also ch=
eck
It is rising or falling edge, and check the CURRENT input level to deci=
de whether to
Use LEVEL detect to manually trigger the interrupt, it works fine with =
our HW.
But later on, touch cotroller driver is updated to use level detect, th=
en we
Met this issue. I think the patch we made to workaround the edge int lo=
st is also needed
In current pm branch, currently we may still face the issue I mentioned=
 above.

But think more generically, the kernel should be robust enough to handl=
e such cases,
We can not let driver to do the workaround since it is specially OMAP p=
latform issue,
Even we have the patch to workaround the edge GPIO IRQ lost issue, but =
the
IRQ staus maybe set again if the interrupt line is driven a second edge=
=2E
The generic handler will only be called once after irq_disable is calle=
d, and
If the interrupt happens more than once after that, then we still face =
the issue that
The IRQ status is set and pending there and prevent LPM.

I tried to summarize the root cause that we need this change, I think i=
t can be simply
Two points:
1: on OMAP, GPIO IRQ status may be set as long as LEVEL/EDGE=20
detect register is configured, regardless of IRQEN or WKEN
2: Pending GPIO IRQ status will impact LPM transition

Hope this can explain more on this patch.

Thanks,
Chunqiu


> > if we check the IRQ status for that GPIO pin, we
> > will find
> > The IRQ is always set. This will prevent PER enterring RET/OFF stat=
e
> > since GPIO
> > Will not acknowledge the IDLE request. The main purpose of=20
> the second
> > patch
> > Is to clear the level/edge detect registers for OMAP GPIO=20
> when their IRQ
> > is
> > Disabled, this can ensure the GPIO IRQ status will not be set and
> > prevent LPM.
>=20
> Thanks for the very clear explanation.  I'm pretty sure I understand
> what is going on now.
>=20
> I need to think some more about what you describe below, but=20
> am curious
> what you think about using edge triggered GPIOs instead of level.
>=20
See the above explanation


> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
