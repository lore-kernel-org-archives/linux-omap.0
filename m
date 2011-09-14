From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
 gic_arch_extn
Date: Wed, 14 Sep 2011 08:21:17 -0700
Message-ID: <20110914152116.GM24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
 <20110913203616.GG24252@atomide.com>
 <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39641 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753572Ab1INPVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 11:21:20 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [110913 22:01]:
> Tony,
> On Wed, Sep 14, 2011 at 2:06 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:23]:
> >> OMAP WakeupGen is the interrupt controller extension used along
> >> with ARM GIC to wake the CPU out from low power states on
> >> external interrupts.
> >>
> >> The WakeupGen unit is responsible for generating wakeup event
> >> from the incoming interrupts and enable bits. It is implemented
> >> in MPU always ON power domain. During normal operation,
> >> WakeupGen delivers external interrupts directly to the GIC.
> > ...
> >
> >> + =C2=A0 =C2=A0 /*
> >> + =C2=A0 =C2=A0 =C2=A0* Override GIC architecture specific functio=
ns to add
> >> + =C2=A0 =C2=A0 =C2=A0* OMAP WakeupGen interrupt controller along =
with GIC
> >> + =C2=A0 =C2=A0 =C2=A0*/
> >> + =C2=A0 =C2=A0 gic_arch_extn.irq_mask =3D wakeupgen_mask;
> >> + =C2=A0 =C2=A0 gic_arch_extn.irq_unmask =3D wakeupgen_unmask;
> >> + =C2=A0 =C2=A0 gic_arch_extn.irq_set_wake =3D wakeupgen_set_wake;
> >> + =C2=A0 =C2=A0 gic_arch_extn.flags =3D IRQCHIP_MASK_ON_SUSPEND;
> >
> > As I've commented before, there should not be any need to tweak
> > the wakeupgen registers for each interrupt during the runtime.
> >
> And I gave you all the reasons why it needs to be done this way.

Hmm, I don't think you ever answered the main question:

Why would you need to write the wakeupgen registers for every
interrupt during the runtime instead of arming them only when
entering idle?
=20
> > AFAIK the wakeupgen registers only need to be armed every time
> > before entering idle.
> >
> No that doesn't work and it completely hacky approach.

And how is writing the registers over and over again unnecessarily
a non-hacky approach?

> This problem is for all SOC's using A9 SMP and GIC and every soc
> has an architecture specific interrupt controller extension. And that
> was the reason the GIC arch_extn was proposed.
> It's just another IRQCHIP and works seamlessly being part of the
> framework.  And it will also initialized with primary IRQCHIP( GIC).

Sure, but I don't know if there is really a need for for that?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
