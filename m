From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
Date: Wed, 2 Apr 2008 09:47:28 +0530
Message-ID: <000c01c89478$77f4d6e0$438918ac@ent.ti.com>
References: <20080331014640.GA14188@ubuntu-workstation> <47F14D61.5030109@indt.org.br> <20080401005137.GA22520@ubuntu-workstation> <004901c8940b$20f1fca0$438918ac@ent.ti.com> <20080401161617.GA28624@ubuntu-workstation> <47F2D774.2060308@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59517 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbYDBER5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 00:17:57 -0400
In-Reply-To: <47F2D774.2060308@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Francisco Alecrim' <francisco.alecrim@indt.org.br>, linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: Francisco Alecrim [mailto:francisco.alecrim@indt.org.br]=20
> Sent: Wednesday, April 02, 2008 6:17 AM
> To: Madhusudhan Chikkature Rajashekar; linux-omap@vger.kernel.org
> Subject: Re: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
>=20
> ext Seth Forshee wrote:
> > On Tue, Apr 01, 2008 at 08:44:47PM +0530, Madhusudhan=20
> Chikkature Rajashekar wrote:
> >  =20
> >> Hi,
> >>
> >> I did not see any board level code to power up the second=20
> slot along with this patch.
> >> Where is the code that enables 1.8V to the second slot?
> >>    =20
> >
> > I am working with a custom board that isn't supported in=20
> the git repo, and I
> > don't have access to any other board that I could test such=20
> changes with.
> > These are just the chages I found were necessary to support=20
> the 1.8V-only
> > host, regardless of whatever board support is needed.
>=20
> That's the same problem here!! I have a custom board too!! However,=20
> pushing patches [1] and [2] we will be able to enable the second=20
> controller with some modifications in board-sdp-mmc.c.

Yes. That=92s what I meant. Some changes in the sdp board file would be=
 required to
Enable power to slot2 through triton LDOs. Currently I am tied up with =
some work,
I will patch that when I get some time unless someone else sends a patc=
h by then.

>=20
> [1] - OMAP: HSMMC: Fixes for 1.8V MMC2 interface
> [2] - [PATCH 1/1] PLAT: OMAP: Add device configuration to=20
> support second=20
> HSMMC slot on OMAP 2430 and 3430 boards.
>=20
> --=20
> Francisco Keppler Silva Alecrim - INdT
> Phone: +55 92 2126-1017
> Mobile: +55 92 9152-7000
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
