From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 16 May 2009 10:54:17 +0100
Message-ID: <20090516095417.GI15328@n2100.arm.linux.org.uk>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com> <20090505124700.4583.69988.stgit@oreo.research.nokia.com> <20090516092036.GD15328@n2100.arm.linux.org.uk> <94a0d4530905160238g21db0519u2e0ad7a46c6e07b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43003 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbZEPJy3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:54:29 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530905160238g21db0519u2e0ad7a46c6e07b9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Sat, May 16, 2009 at 12:38:23PM +0300, Felipe Contreras wrote:
> On Sat, May 16, 2009 at 12:20 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, May 05, 2009 at 03:47:00PM +0300, Hiroshi DOYU wrote:
> >> +static struct resource omap3_iommu_res[] =3D {
> >> + =A0 =A0 { /* Camera ISP MMU */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_MMU1=
_BASE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_MM=
U1_BASE + MMU_REG_SIZE - 1,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE=
_MEM,
> >> + =A0 =A0 },
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_MMU1=
_IRQ,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE=
_IRQ,
> >> + =A0 =A0 },
> >> + =A0 =A0 { /* IVA2.2 MMU */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_MMU2=
_BASE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_MM=
U2_BASE + MMU_REG_SIZE - 1,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE=
_MEM,
> >> + =A0 =A0 },
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP3_MMU2=
_IRQ,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE=
_IRQ,
> >> + =A0 =A0 },
> >> +};
> >> +#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)
> >
> > This looks all very convoluted. =A0Why not do something like:
> >
> > static unsigned long iommu_base[] =3D {
> > =A0 =A0 =A0 =A0OMAP3_MMU1_BASE,
> > =A0 =A0 =A0 =A0OMAP3_MMU2_BASE,
> > };
> >
> > static int iommu_irq[] =3D {
> > =A0 =A0 =A0 =A0OMAP3_MMU1_IRQ,
> > =A0 =A0 =A0 =A0OMAP3_MMU2_IRQ,
> > };
>=20
> All your comments are pretty similar to my reorganize patch:
> http://marc.info/?l=3Dlinux-omap&m=3D124172711303076&w=3D2

=2E.. which hasn't been posted to linux-arm-kernel, and so I won't see =
it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
