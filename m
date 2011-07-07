From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] TWL6040 MFD and followups
Date: Thu, 7 Jul 2011 22:36:05 +0300
Message-ID: <20110707193604.GB1311@legolas.emea.dhcp.ti.com>
References: <5898202.Q4JP1WeJj2@barack>
 <20110707182947.GM5783@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kncZREqT6Wt3NQEl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:54402 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855Ab1GGTgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 15:36:10 -0400
Received: by mail-bw0-f44.google.com with SMTP id 17so1194202bwb.3
        for <linux-omap@vger.kernel.org>; Thu, 07 Jul 2011 12:36:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110707182947.GM5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>, "Girdwood, Liam" <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--kncZREqT6Wt3NQEl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 07, 2011 at 11:29:47AM -0700, Tony Lindgren wrote:
> * P=E9ter Ujfalusi <peter.ujfalusi@ti.com> [110707 04:43]:
> > Hello Tony,
> >=20
> > As it has been discussed I'm sending this pull request, which includes =
the
> > following series (all patch acked-by the corresponding maintainer):
> > 1. v6 of MFD/ASoC/Input: TWL4030/TWL60X0 changes (18 patch)
> > 2. v3 of MFD/input/ASoC: twl6040: irq registration changes (5 patch)
> > 3. v1 of ASoC/MFD: twl6040: PLL handling changes (6 patch)
> > 4. ASoC: twl6040: Add back support for legacy mode (single patch)
> >=20
> > The first series starts with a cleanup in the mach-omap2 directory
> > (twl-common.c file created), and that is the reason we agreed that you
> > are going to take this pull request.
> > The rest of the changes are well contained, and should not cause merge
> > conflict for 3.1. We have not sent patches for these components, so the
> > changes to these are coming from one source.
> >=20
> > As you have requested I have created the series on top of your
> > devel-cleanup branch.
>=20
> Thanks. Can you please add one more branch for cleanup only for me to
> pull at your commit b252b0efb605b92a2f5d118e294d088d89cfd286
> (OMAP3: Move common regulator configuration to twl-common)?
>=20
> That way I can first pull that into cleanup and send that to Arnd.
> Then we can do a separate twl-asoc branch so the cleanup stays
> separate from new code.
>=20
> I don't think there's a way for me to do a pull that ends at certain
> commit with git.. Or at least I don't know how to do that short of
> git reset --hard of some branch at that commit.

after a git fetch <url>, you already have the objects locally, so git
merge <commit-id> should work just fine.

If you look at what git pull does, it basically does a fetch followed by
a merge of FETCH_HEAD (by default).

--=20
balbi

--kncZREqT6Wt3NQEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOFgqkAAoJEAv8Txj19kN1qTkIAIsQ4Ljkt1qTTKXQ/7SExejl
mT/6S0tvalBQY9pancIv2OBHrOmQX5aXTa2r3+KbZYzmzNt7HtWNavMjlk5bQB7H
mci9Q8uPsrqK15/716zwVBi5XmK7iosbGWhegpZ6R3NVLWaV1IUNE2yT16n7YGOi
u1/mAO0Etzugj+oTVYNfsNu2xPIBCGFLoJljcuVG5/mLmlO6DqCxKlMWgrUcGQ3O
nVWJoRW3X3pA5DCxqlnU0Qs3YnTzUa8eDl9NRTc0di2RUsq6vckXN2FF1ERH3JJV
9phgAh0bFK0+xEsxFFPZRDAZFnMZUir9eLTWMKsQR097HTS84ooe7NBvaP5Rgvs=
=tzet
-----END PGP SIGNATURE-----

--kncZREqT6Wt3NQEl--
