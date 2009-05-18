From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 14:40:18 +0100
Message-ID: <20090518134018.GI3067@n2100.arm.linux.org.uk>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com> <20090518121113.GB3067@n2100.arm.linux.org.uk> <94a0d4530905180546p47c887afj109b3b60cdd24a00@mail.gmail.com> <20090518130233.GD3067@n2100.arm.linux.org.uk> <94a0d4530905180621r35eebdf2o2f9b0b3e107e77a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54669 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZERNk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:40:27 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530905180621r35eebdf2o2f9b0b3e107e77a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, May 18, 2009 at 04:21:19PM +0300, Felipe Contreras wrote:
> On Mon, May 18, 2009 at 4:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, May 18, 2009 at 03:46:07PM +0300, Felipe Contreras wrote:
> >> On Mon, May 18, 2009 at 3:11 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > The real problem here seems to be the TI DSP bridge code, and if=
 that's
> >> > the case why can't we just avoid registering IVA2 if the TI DSP =
bridge
> >> > code is enabled. =A0That solves your stated problem without crea=
ting
> >> > additional management issues.
> >>
> >> The bridgedriver is expected to move and use iommu eventually, but=
 not
> >> right now, so I guess the iva2 device should be registered only if
> >> MPU_BRIDGE_IOMMU is defined.
> >>
> >> But then what's the point of having the isp iommu device if the ca=
mera
> >> driver is disabled? Wouldn't that be wasting resources? Then if CA=
MERA
> >> is not defined the isp device should not be registered either.
> >
> > So have something like:
> >
> > config OMAP_IOMMU
> > =A0 =A0 =A0 =A0tristate
> >
> > and then have both MPU_BRIDGE_IOMMU and the camera support (and wha=
tever
> > else) select it. =A0That way, you only end up with the IOMMU suppor=
t code
> > built into the kernel if you have users of it.
> >
> > These low-level internal services drivers really don't need to be
> > publically visible in the configuration system.
>=20
> Yeap, that needs to be done too.
>=20
> > As for the run-time size, that's truely minimal.
>=20
> I thought creating iommu devices involved some kind of overhead,
> allocating some resources probably. That's why the iva2 iommu device
> conflicts with tidspbridge custom mmu.

I believe I've already said how to handle that - in fact it's in the
quoted messages at the top of this mail.

> >> And finally if none of the two are enabled then you don't really
> >> iommu. By having omap_iommu_add all the dependencies would be hand=
led
> >> automatically, right? 'modprobe bridgedriver' would load iommu.
> >
> > Think about it - the dependencies _already_ have to be there to use
> > the iommu services.
>=20
> Ok, yes, for iommu, but not for omap3-iommu which is a separate modul=
e.

That is a point, but I think it's a relatively minor one.  We could
get around that by ensuring that omap3-iommu is always built-in if
we have the possibility of iommu support, and leave iommu as a module.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
