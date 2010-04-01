From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH-V2] OMAP: Fix for bus width which improves SD card's peformance.
Date: Thu, 1 Apr 2010 10:41:52 -0500
Message-ID: <003c01cad1b1$da2cdbf0$544ff780@am.dhcp.ti.com>
References: <35697.192.168.10.89.1265898023.squirrel@dbdmail.itg.ti.com> <004701caab40$68b576e0$544ff780@am.dhcp.ti.com> <x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com> <v2yce9ab5791003302327hc67deb3akc7d18146534038f9@mail.gmail.com> <h2p7f9d1ffb1003310003z508e21dbqe37b6e1cad425866@mail.gmail.com> <003b01cad0f0$6ea78040$544ff780@am.dhcp.ti.com> <g2s7f9d1ffb1003312331o149df218g651c3e4349ac9a77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39945 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756850Ab0DAPmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 11:42:00 -0400
In-Reply-To: <g2s7f9d1ffb1003312331o149df218g651c3e4349ac9a77@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'kishore kadiyala' <kishorek.kadiyala@gmail.com>
Cc: 'Vimal Singh' <vimal.newwork@gmail.com>, tony@atomide.com, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.lavinen@nokia.com



> -----Original Message-----
> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
> Sent: Thursday, April 01, 2010 1:32 AM
> To: Madhusudhan
> Cc: Vimal Singh; tony@atomide.com; svenkatr@ti.com; linux-
> omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> jarkko.lavinen@nokia.com
> Subject: Re: [PATCH-V2] OMAP: Fix for bus width which improves SD car=
d's
> peformance.
>=20
> On Wed, Mar 31, 2010 at 10:07 PM, Madhusudhan <madhu.cr@ti.com> wrote=
:
> >
> >
> >> -----Original Message-----
> >> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
> >> Sent: Wednesday, March 31, 2010 2:03 AM
> >> To: Vimal Singh
> >> Cc: Madhusudhan; tony@atomide.com; svenkatr@ti.com; linux-
> >> omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> jarkko.lavinen@nokia.com
> >> Subject: Re: [PATCH-V2] OMAP: Fix for bus width which improves SD
> card's
> >> peformance.
> >>
> >> Sorry for that and here's the Updated one.
> >>
> >> From: Kishore Kadiyala <kishore.kadiyala@ti.com>
> >>
> >> This patch improves low speeds for SD cards.
> >> OMAP-MMC controller's can support maximum bus width of '8'.
> >> when bus width is mentioned as "8" in controller data,the SD
> >> stack will check whether bus width is "4" and if not it will
> >> set bus width to "1" and there by degrading performance.
> >> This patch fixes the issue and improves the performance of
> >> SD cards.
> >>
> >> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> >> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> >>
> >> ---
> >> In V2 : Appended Signed-off by Venkat and Ack by Madhu
> >>
> >> =A0Here are my experiment numbers, on a Class 6 SDHC card:
> >> =A0Read peformance is increased by 220%
> >> =A0Write Performance is increased by 52%
> >>
> >> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-
> >> =A01 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c
> >> index 83f0aff..8c97c22 100644
> >> --- a/drivers/mmc/host/omap_hsmmc.c
> >> +++ b/drivers/mmc/host/omap_hsmmc.c
> >> @@ -2092,7 +2092,7 @@ static int __init omap_hsmmc_probe(struct
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP_WAIT_WHILE_BUSY;
> >>
> >> =A0 =A0 =A0 if (mmc_slot(host).wires >=3D 8)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D (MMC_CAP_8_BIT_DATA | MMC=
_CAP_4_BIT_DATA);
> >> =A0 =A0 =A0 else if (mmc_slot(host).wires >=3D 4)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
> >>
> > Kishore,
> >
> > Since this patch is not yet pushed it makes sense to fix the readab=
ility
> > issue.
> >
> > Since 8-bit is the max how about:
> >
> > =A0=A0 =A0 =A0 =A0if (mmc_slot(host).wires =3D=3D 8)
> > =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_8_BIT_DATA=
 | MMC_CAP_4_BIT_DATA;
> > =A0=A0 =A0 =A0 =A0if (mmc_slot(host).wires =3D=3D 4)
> > =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA=
;
> >
> Madhu,
>=20
> In the above snippet, it checks whether wires are 8 or  4 and if not
> neither set's  capability  to "1".
> Does it make sense to check whether the  wires are 8,4,1 and if not
> any[8,4,1] throw error and come out.
>=20
It is good enough to just check for 8-bit and 4-bit. The 1-bit does not=
 need
any explicit check since it is default.

Regards,
Madhu

> Regards,
> Kishore
> > This would be little easy to read the code.
> >
> > Can you please repost the patch??
> >
> > Regards,
> > Madhu
> >
> >> --
> >> 1.6.3.3
> >
> >

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
