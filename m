From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Sat, 16 Apr 2011 14:09:29 +0100
Message-ID: <20110416130929.GL4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59666 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab1DPNJv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Apr 2011 09:09:51 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Apr 16, 2011 at 09:01:26PM +0800, Haojian Zhuang wrote:
> On Fri, Apr 15, 2011 at 9:06 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > This is work in progress.
> >
> > We have two SoCs using SRAM, both with their own allocation systems=
,
> > and both with their own ways of copying functions into the SRAM.
> >
> > Let's unify this before we have additional SoCs re-implementing thi=
s
> > obviously common functionality themselves.
> >
> > Unfortunately, we end up with code growth through doing this, but t=
hat
> > will become a win when we have another SoC using this (which I know
> > there's at least one in the pipeline).
> >
> > One of the considerations here is that we can easily convert sram-p=
ool.c
> > to hook into device tree stuff, which can tell the sram allocator:
> > =A0 =A0 =A0 =A0- physical address of sram
> > =A0 =A0 =A0 =A0- size of sram
> > =A0 =A0 =A0 =A0- allocation granularity
> > and then we just need to ensure that it is appropriately mapped.
> >
> > This uses the physical address, and unlike Davinci's dma address us=
age,
> > it always wants to have the physical address, and will always retur=
n
> > the corresponding physical address when passed that pointer.
> >
> > OMAP could probably do with some more work to make the omapfb and o=
ther
> > allocations use the sram allocator, rather than hooking in before t=
he
> > sram allocator is initialized - and then further cleanups so that w=
e
> > have an initialization function which just does
> >
> > sram_create(phys, size)
> > =A0 =A0 =A0 =A0virt =3D map sram(phys, size)
> > =A0 =A0 =A0 =A0create sram pool(virt, phys, size, min_alloc_order)
> >
> > Another question is whether we should allow multiple SRAM pools or =
not -
> > this code does allow multiple pools, but so far we only have one po=
ol
> > per SoC. =A0Overdesign? =A0Maybe, but it prevents SoCs wanting to d=
uplicate
> > it if they want to partition the SRAM, or have peripheral-local SRA=
Ms.
> >
> > Lastly, uio_pruss should probably take the SRAM pool pointer via
> > platform data so that it doesn't have to include Davinci specific
> > includes.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>=20
> This common sram driver is good for us. It can benefit us on DMA usag=
e.
> I just have one question on SRAM for storing instruction. We still ne=
ed to
> copy code into SRAM and flush cache & TLB with this SRAM driver.

There is the fncpy API for copying code to other regions of memory,
including SRAM.  The fncpy API is explicitly designed to cope with
Thumb 2 and provide an appropriate function pointer for such code.

Such code needs to be position independent to cope with multiple SRAM
users, and also possible variability of SRAM mapping which may (eventua=
lly)
exist when DT comes along.

> TCM driver can allocate code into SRAM section in link stage. It need=
s to
> update link file and virtual memory layout. Is it worth to make SRAM =
driver
> support this behavior? The case of using SRAM as memory for instructi=
on
> is switching frequency or entering/exiting low power mode in PXA sili=
cons.

This is more or less the same scenario which OMAP is using its SRAM
for, although that's explicitly SRAM and not TCM.

I don't think we need position dependent code requiring fixup for
these applications as such things tend to be fairly easily coded in a
position independent way.

Also note that C functions can't be copied because C produces position
dependent code, and we have no way of extracting the relocation
dependencies from such code.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
