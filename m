From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 0/2] OMAP: use physmap-flash
Date: Wed, 09 Dec 2009 12:07:17 +0200
Message-ID: <1260353237.19669.1258.camel@localhost>
References: <20091208192111.GA32268@localhost.localdomain>
	 <20091208183320.GV24013@atomide.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29437 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbZLIKHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 05:07:35 -0500
In-Reply-To: <20091208183320.GV24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, 'David Woodhouse' <dwmw2@infradead.org>

On Tue, 2009-12-08 at 10:33 -0800, Tony Lindgren wrote:
> * Ladislav Michl <Ladislav.Michl@seznam.cz> [091208 10:20]:
> > There is nothing special on omapflash driver, so it can be replaced=
 with
> > physmap-flash. First patch in serie does exactly this and second on=
e removes
> > drivers/mtd/maps/omap_nor.c and associated Kconfig option. I'd like=
 to have
> > either ack or merge into mtd git tree by mtd maintainers for that s=
econd part.
>=20
> Nice work! Ack from me to merge all this via the MTD tree.
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
> =20
> >  arch/arm/mach-omap1/flash.c                          |   33 ++
> >  arch/arm/plat-omap/include/plat/flash.h              |   16 +
> >  arch/arm/mach-omap1/Makefile                         |    2=20
> >  arch/arm/mach-omap1/board-fsample.c                  |    9=20
> >  arch/arm/mach-omap1/board-h2.c                       |    9=20
> >  arch/arm/mach-omap1/board-h3.c                       |    9=20
> >  arch/arm/mach-omap1/board-innovator.c                |    9=20
> >  arch/arm/mach-omap1/board-osk.c                      |    9=20
> >  arch/arm/mach-omap1/board-palmte.c                   |    9=20
> >  arch/arm/mach-omap1/board-palmtt.c                   |    9=20
> >  arch/arm/mach-omap1/board-palmz71.c                  |   10=20
> >  arch/arm/mach-omap1/board-perseus2.c                 |    9=20
> >  arch/arm/mach-omap1/board-sx1.c                      |   11=20
> >  arch/arm/mach-omap1/board-voiceblue.c                |    9=20
> >  arch/arm/mach-omap2/board-2430sdp.c                  |    7=20
> >  arch/arm/mach-omap2/board-h4.c                       |    7=20
> >  drivers/mtd/maps/Kconfig                             |    9=20
> >  drivers/mtd/maps/Makefile                            |    1=20
> >  drivers/mtd/maps/omap_nor.c                          |  188 ------=
-----------
> >  19 files changed, 112 insertions(+), 253 deletions(-)

I think this should be merged via the omap tree, not mtd (CCed dwmw2).

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
