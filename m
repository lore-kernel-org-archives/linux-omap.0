From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Fri, 11 Nov 2011 11:41:47 +0000
Message-ID: <20111111114147.GE12410@mudshark.cambridge.arm.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:59879 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752620Ab1KKLmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 06:42:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <ming.lei@canonical.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, b-cousson@ti.com

[Adding Benoit to CC].

On Thu, Nov 10, 2011 at 09:02:14AM +0000, Paul Walmsley wrote:
> On Wed, 9 Nov 2011, Ming Lei wrote:
> > Also, current arm perf code don't handle three IRQs(one pl310 irq a=
nd=20
> > two CTI irq) inside one device correctly.
>=20
> To fix this, that ARM perf code should either be using=20
> platform_get_irq_byname(), or the hwmod hardware data will need to be=
=20
> rearranged to meet the arbitrary ordering requirement.  I'd suggest=20
> pinging Will on this issue to see what he wants to do.

The issue stems from the fact that we have to route the PMU interrupts =
to
the correct CPU manually (I think only MSM routes them as PPIs, which i=
s
clearly the correct thing to do). To do this, we expect the IRQ resourc=
es to
be laid out in CPU order. In hindsight, maybe naming the resources migh=
t
have been a good idea, but them we'd still have to generate the names u=
sing
CPU numbers when iterating through the platform device.

So although the ordering requirements are a bit of a pain, I do think i=
t's
reasonable for perf to expect that it's not being handed some random ot=
her
interrupts along with those for the PMU.

> So the clockdomain is already defined in=20
> mach-omap2/clockdomains44xx_data.c and there's code to control it - s=
ee=20
> for example clkdm_enable_idle().  But this code should not be called=20
> directly by any device driver code or driver integration code.  The t=
hing=20
> to do here is to ask Beno=EEt to release the hwmod data for the DEBUG=
SS=20
> hwmod, then someone will need to write an MFD driver for that which=20
> exposes the PMU address space to the PMU platform driver.

Benoit? Please can you chime in here?

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
