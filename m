From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/22] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 16:12:32 +0300
Message-ID: <20110711131231.GB2680@legolas.emea.dhcp.ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
 <20110711132842.10606a31@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FWV58dOTQOM6W93I"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:60910 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756792Ab1GKNMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 09:12:38 -0400
Received: by mail-gw0-f54.google.com with SMTP id 15so1845733gwb.13
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 06:12:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110711132842.10606a31@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Michael =?iso-8859-1?Q?B=FCsch?= <mb@bu3sch.de>


--FWV58dOTQOM6W93I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 11, 2011 at 01:28:42PM +0200, Michael B=FCsch wrote:
> On Mon, 11 Jul 2011 14:17:13 +0300
> Felipe Balbi <balbi@ti.com> wrote:
>=20
> > Hi Tony,
> >=20
> > here's the complete series... I'll stop playing
> > with these for a while. If you have some free time
> > to boot test on n8x0, I'd be really glad ;-)
> >=20
> > Maybe Michael could test too ??
> >=20
> > Felipe Balbi (22):
> >   cbus: tahvo: convert spinlock into mutex
> >   cbus: tahvo: move to __devinit/__devexit sections
> >   cbus: tahvo: a switch looks better
> >   cbus: tahvo: don't go over 80 columns
> >   cbus: tahvo: drop the tasklet
> >   cbus: retu: set IRQF_ONESHOT flag
> >   cbus: tahvo: git it a context structure
> >   cbus: tahvo: pass tahvo to IRQ handler
> >   cbus: tahvo: introduce __tahvo_(read/write)_reg
> >   cbus: tahvo: drop some unneded defines
> >   cbus: retu: IRQ demux optimization
> >   cbus: tahvo: give it an irq_chip
> >   cbus: tahvo: start using irq_chip
> >   cbus: tahvo: usb: fix up to use threaded irqs
> >   cbus: tahvo drop the legacy interfaces
> >   cbus: tahvo: usb: drop unused variable
> >   cbus: tahvo: no need to mask interrupts on exit
> >   cbus: tahvo: drop the get_status hack
> >   cbus: tahvo: drop more unused interfaces
> >   cbus: tahvo: pass child device pointer
> >   cbus: tahvo: drop backlight interfaces
> >   cbus: tahvo: drop static global pointer
> >=20
> >  arch/arm/mach-omap1/board-nokia770.c |    6 -
> >  arch/arm/mach-omap2/board-n8x0.c     |    6 -
> >  drivers/cbus/retu.c                  |   18 +-
> >  drivers/cbus/tahvo-usb.c             |   58 ++---
> >  drivers/cbus/tahvo.c                 |  462 ++++++++++++++++++--------=
--------
> >  drivers/cbus/tahvo.h                 |   16 +-
> >  6 files changed, 283 insertions(+), 283 deletions(-)
> >=20
>=20
> I currently lack a bit of time for testing, however I'll check it
> I can test them at some point. Don't hold your breath, though.
>=20
> Are you planning to implement a backlight driver for tahvo? I'm actually
> using the functionality that you removed in this patchset in the OpenWRT
> distribution.

if you have some extra documentation available, I could implement it
whenever I have some extra couple hours to play with this again... I
have no docs at all, but a led-tahvo.c would be really simple to get
done :-)

--=20
balbi

--FWV58dOTQOM6W93I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGva/AAoJEAv8Txj19kN1VfgH/1xxkC7gyGJufPj5IZ9utNHM
a6Pjger33/K3+A6ii/sYojtIN55SLbcaqAVltogvgudgNSiTB0ItOAOjg3/Icqvs
+5zNffJUyaYnRGpxDav5A3NbuTqVHvHZH2eMC5T8YgIAa8cO87l//kdH8OlYNAAj
pLf5x3tvZM30l5xWGBlMWD5L9jWnMurSyrRZLl/JCgfVNZwtKTf7tUXFJLrM5JkH
v4dxDaq+24ifvFMc6IUKyycUB5VijeJX6Wu9i82pWuQxTUkwjZChFKVrm3XiSlQQ
PPdGyi11MuvJvq2c5/phY0IrvBLAA146tJr305y2cwP1hwTaieHLk2zjaX8Uc0g=
=6eWv
-----END PGP SIGNATURE-----

--FWV58dOTQOM6W93I--
