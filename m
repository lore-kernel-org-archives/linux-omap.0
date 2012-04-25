From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 25 Apr 2012 18:44:37 +0300
Message-ID: <1335368681.6356.16.camel@koala>
References: <1334652536-4442-1-git-send-email-ivan.djelic@parrot.com>
	 <1335365341.6356.5.camel@koala> <20120425152310.GR3739@atomide.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+Mt5edcrmWCUlDGUCrIi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59663 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2DYPoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 11:44:44 -0400
Received: by lbbgf7 with SMTP id gf7so203441lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 08:44:42 -0700 (PDT)
In-Reply-To: <20120425152310.GR3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ivan Djelic <ivan.djelic@parrot.com>


--=-+Mt5edcrmWCUlDGUCrIi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-04-25 at 08:23 -0700, Tony Lindgren wrote:
> Hi,
>=20
> * Artem Bityutskiy <dedekind1@gmail.com> [120425 07:52]:
> > On Tue, 2012-04-17 at 10:48 +0200, Ivan Djelic wrote:
> > > This patch adds a simple BCH ecc computation api, similar to the
> > > existing Hamming ecc api. It is intended to be used by the MTD layer.
> > > It implements the following features:
> > >=20
> > > - support 4-bit and 8-bit ecc computation
> > > - do not protect user bytes in spare area, only data area is protecte=
d
> > > - ecc for an erased NAND page (0xFFs) is also a sequence of 0xFFs
> > >=20
> > > This last feature is obtained by adding a constant polynomial to
> > > the hardware computed ecc. It allows to correct bitflips in blank pag=
es
> > > and is extremely useful to support filesystems such as UBIFS, which e=
xpect
> > > erased pages to contain only 0xFFs.
> > >=20
> > > This api has been tested on an OMAP3630 board.
> > >=20
> > > Signed-off-by: Ivan Djelic <ivan.djelic@parrot.com>
> >=20
> > Hi Tony,
> >=20
> > what do you think about merging this patch? This is the enabler for
> > making UBIFS actually usable on OMAP platforms which use BCH ECC. There
> > are 2 other MTD patches which depend on this - so I wonder if it is
> > easier to merge this one via the MTD tree, providing it has your/others=
'
> > ack(s).
>=20
> Looks OK to me, however there are other pending GPMC patches to convert
> it to a platform device device driver. Need to look those closer though.
> Anyways, it's best that I queue them to avoid merge conflicts.

Sure.

> Do you these for other changes for UBIFS?

Not in UBIFS, but in drivers/mtd/nand/omap2.c - Ivan sent another patch
which adds BCH support to to omap2.c, was sent to linux-omap, subject
"[PATCH] mtd: nand: omap: add support for hardware BCH ecc"

>  If so, I can set up an immutable
> branch for GPMC that you can merge in as well.

I guess this would be a good idea, but probably it is better to do this
when you believe you merged most gpmc patches, so probably closer to the
final -rc?

--=20
Best Regards,
Artem Bityutskiy

--=-+Mt5edcrmWCUlDGUCrIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPmBvlAAoJEJtuLFy+q7fehPMIALBX8kO36EKXAld0t1ih1Pcs
jEg0tyt+BN0HWpQYTfIqVnNcrw5BNtVOmmyxAM7bts0uTvNyEWhvKUyBJQFLbSLj
iVUXsQwBIQLIl5bPj05mw+mVtsSST3m7C1kQtOs4bH2kyKCOQ7lkVWGmeG6/lz0E
CvpqYJgptXcLxxcr6KjeIE2pFTnBaOz5mMoiuY9UAm/bgSDDpZhcXM+tONGWt8NO
ffTdmA3BsDIMY4DJ8KrnJsQaJeM2HUagVUGzIn6dlpYO9lSpLqnclv4YsnL3zq4l
9UB2dT32EmLP/YJri5u6MS5PtgWNOAia9OwukvcXPZACrP+APVGdxEHjqKxqrM8=
=bXgA
-----END PGP SIGNATURE-----

--=-+Mt5edcrmWCUlDGUCrIi--

