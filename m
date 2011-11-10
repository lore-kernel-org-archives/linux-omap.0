From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Thu, 10 Nov 2011 02:02:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com> <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1224306982-1320915734=:4195"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38622 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab1KJJCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 04:02:16 -0500
In-Reply-To: <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1224306982-1320915734=:4195
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Ming Lei,

just a few quick comments for now -

On Wed, 9 Nov 2011, Ming Lei wrote:

> On Tue, Nov 8, 2011 at 11:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
>=20
> >> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] =3D {
> >> + =A0 =A0 { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_START },
> >> + =A0 =A0 { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_START },
> >> + =A0 =A0 { .irq =3D -1 }
> >> +};
> >
> > Are you sure these are part of the emulation IP? =A0We already have tho=
se
>=20
> I am not sure, I just figure out one way to make omap4 pmu work. Since th=
ere
> are few descriptions in TRM about it, it is a hacking based on [1], :-)
>=20
> > IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.
>=20
> I just see it, but looks like the "mpu" hwmod isn't populated as omap_dev=
ice,
> so the CTI irqs aren't requested now.

Okay.  Maybe you can probably add some code in mach-omap2/devices.c to=20
build an omap_device for this for right now?  I am not 100% sure whether=20
those cti0/1 interrupts should be associated with the MPU or with the=20
DEBUGSS but Beno=EEt might be able to answer this.

> Also, current arm perf code don't handle three IRQs(one pl310 irq and=20
> two CTI irq) inside one device correctly.

To fix this, that ARM perf code should either be using=20
platform_get_irq_byname(), or the hwmod hardware data will need to be=20
rearranged to meet the arbitrary ordering requirement.  I'd suggest=20
pinging Will on this issue to see what he wants to do.

> So any suggestion about CTI IRQs connecting to which hwmod, so that they =
can
> be found by pmu driver?
>=20
> >> +/*emu hwmod*/
> >> +static struct omap_hwmod omap44xx_emu_hwmod =3D {
> >> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "emu",
> >> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_emu_hwmod_class,
> >> + =A0 =A0 .clkdm_name =A0 =A0 =3D "emu_sys_clkdm",
> >> + =A0 =A0 .prcm =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM_E=
MU_CLKSTCTRL_OFFSET,
> >
> > This doesn't look right either: EMU is a clockdomain, not an IP block.
>=20
> I defined the 'emu' hwmod to control the clock state transition of the EM=
U
> clock domain by writing to CLKTRCTRL.CM_EMU_CLKSTCTRL with standard
> hwmod interface(_enable / _idle). Is there any other neat way to do it?

So the clockdomain is already defined in=20
mach-omap2/clockdomains44xx_data.c and there's code to control it - see=20
for example clkdm_enable_idle().  But this code should not be called=20
directly by any device driver code or driver integration code.  The thing=
=20
to do here is to ask Beno=EEt to release the hwmod data for the DEBUGSS=20
hwmod, then someone will need to write an MFD driver for that which=20
exposes the PMU address space to the PMU platform driver.

But also proper dependency support in hwmod enable/idle operations will be=
=20
needed to enable the instrumentation and emulation interconnects when the=
=20
DEBUGSS is enabled.  This has been on my plate for a few months, it's good=
=20
to have another reason to prioritize it. =20


- Paul
--155748971-1224306982-1320915734=:4195--
