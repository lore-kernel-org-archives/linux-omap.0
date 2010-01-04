From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Date: Mon, 4 Jan 2010 12:40:05 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C02E97E9@dbde02.ent.ti.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	 <20091228214846.GP3512@atomide.com>
 <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45136 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068Ab0ADHK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 02:10:27 -0500
In-Reply-To: <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of S, =
Venkatraman
> Sent: Monday, January 04, 2010 12:33 PM
> To: Tony Lindgren
> Cc: Russell King - ARM Linux; Shilimkar, Santosh; Kevin Hilman; linux=
-omap@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [Patch v4] OMAP: sDMA driver: descriptor autoloading fea=
ture
>=20
> On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
> >> Here is the most updated version of the patch (thanks to Russell's
> >> review). This patch is applicable to OMAP4xxx as well as OMAP3630
> >> Reference to previous posts
> >> v1 =A0http://marc.info/?l=3Dlinux-omap&m=3D125012097403050&w=3D2
> >> v2 =A0http://marc.info/?l=3Dlinux-omap&m=3D125137152606644&w=3D2
> >> v3 =A0http://patchwork.kernel.org/patch/45408/
> >
> > Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
> > use this feature? Or some other driver?
> >
> > Regards,
> >
> > Tony
>=20
> I am about to start working on omap_hsmmc to use the descriptor load
> feature. If the DMA changes are acceptable, I can post the driver
> patch as well.

I don't think doing this for hsmmc makes any sense considering, the IC =
in which DMA descriptor
is available( OMAP3630 and OMAP4), the HSMMC controller is already equi=
pped with its dedicated=20
DMA controller (ADMA)

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
