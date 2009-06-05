From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Sat, 6 Jun 2009 07:57:16 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5372F02@zmy16exm69.ds.mot.com>
References: <87ljo68ivb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:34966 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbZFEX6B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 19:58:01 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n55Nw0Wd009035
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 16:58:00 -0700 (MST)
Received: from il27vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n55Nw0TS014497
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 18:58:00 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n55NvwIp014487
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 18:57:59 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87ljo68ivb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Sent: 2009=C4=EA6=D4=C26=C8=D5 5:35
> To: Wang Sawsd-A24013
> Cc: linux-omap@vger.kernel.org; nm@ti.com; Mike Chan
> Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status=20
> been set after irq_disable
>=20
> "Wang Sawsd-A24013" <cqwang@motorola.com> writes:
>=20
> >> Could you try this patch with your TS GPIO configured as=20
> >> level-triggered?
> >>=20
> >
> > I tried the below patch, it can solve the issue also.
> >
>=20
> Thanks for testing.
>=20
> This whole time, you're probably wondering... "why doesn't Kevin just
> add the disable and enable hooks and be done with it."  I don't think
> I've explained myself there yet so let me try to explain so I don't
> come across as refusing your original idea for no good reason other
> than being stubborn.
>=20
> We basically have the option of doing it in my proposed patch, which
> adds additional overhead to the mask/unmask hooks or we can just add
> disable/enable hooks as you did in your original patch.
>=20
> The reason I prefer not to add disable/enable hooks is to take
> advantage of the lazy disable feature.  With lazy disable, by waiting
> to actually disable, it allows us to handle potentially lost
> interrupts and this is especially important for wakeup interrupts.  A=
n
> interesting example this is interrupts that are lazy disabled during
> suspend/resume.
>=20
> For example, if a wakeup interrupt happens between the drivers
> disable_irq(), what you want is for this interrupt to cancel suspend.
> If you you implement a ->disable hook, and thus mask interrupts in HW
> immediately, you will loose this interrupt.  With lazy disable, the
> drivers ISR will not be called, but genirq will see this interrupt an=
d
> set IRQ_PENDING.  Late in the suspend path, IRQs that are IRQ_WAKEUP
> and IRQ_PENDING will cancel suspend (see
> kernel/irq/pm.c:check_wakeup_irqs())
>=20
> Another possible scenario is an interrupt that happens between HW
> resume and the drivers enable_irq() hook.  With lazy disable, this
> interrupt will be IRQ_PENDING when enable_irq() gets called and be
> triggered/handled immedately.
>=20
> Hope that helps explain my stubborness, ;)
>=20
> Of course this doesn't mean it's an absolute decision.  As always, I'=
m
> certainly open to being pursuaded that there are other better reasons
> for doing it differently.
>=20
> Kevin
>=20

Kevin, I am totally ok with your change. :-)

Why I  didn't modify mask/unmask is only because I won't to impact the =
generic
IRQ handler with overhead, but as you said, lazy irq disable is good
To not lose interrupt before suspend, we should benefit from it as much=
 as possible.

Your change is pretty good, more important is I am glad to see the issu=
e
Is understood by others and we found a solution for it, I care nothing =
about
Whether it is addressed by using my original patch or not. :-)

Thanks,
Chunqiu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
