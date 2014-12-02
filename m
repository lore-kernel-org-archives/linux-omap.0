From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Tue, 2 Dec 2014 22:28:16 +0100
Message-ID: <201412022228.16421@pali>
References: <20141027200008.GR2560@atomide.com> <201411271232.47231@pali> <20141128202719.GU2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3720473.JLXMeiLLZh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:59186 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932894AbaLBV2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2014 16:28:19 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so17989324wgh.24
        for <linux-omap@vger.kernel.org>; Tue, 02 Dec 2014 13:28:18 -0800 (PST)
In-Reply-To: <20141128202719.GU2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart3720473.JLXMeiLLZh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 28 November 2014 21:27:19 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141127 03:34]:
> > On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> > > Thinking about this probably the best long term solution
> > > is to pass optional board_revision in the kernel cmdline
> > > that can be parsed early and copied to system_rev
> > > variable.
> >=20
> > Not possible. Our bootloader is closed & proprietary. I
> > tried to replace it with u-boot I was not able to do that.
> > So we will use that Nokia closed bootloader forever and it
> > can provide data only in ATAG structure.
>=20
> I'm using just mainline u-boot flashed as kernel for nolo that
> then loads the kernel.
>=20
> For passing the board revision using the pass through u-boot
> is probably the best long term solution. U-boot can read the
> ATAGs from nolo and modify the .dtb for the revision
> information.
>=20
> Are you saying there are some issues with that?
>=20
> > > Or if you can think of some other way to get it, we can
> > > set system_rev in pdata-quirks.c.
> > >=20
> > > Or maybe add some code to copy the ATAGs somewhere where
> > > they are out of the way and don't conflict with the device
> > > tree data? Then we can query ATAG_REVISION from
> > > pdata-quirks.c and set system_rev.
> >=20
> > If we are able to read ATAG from pdata-quirks, then we can
> > parse it there and fix problems... But I do not know if
> > address of ATAG structure is available there...
>=20
> Are there other ATAGs needed beyond the ATAG_REVISION?
>=20
> Regards,
>=20
> Tony

Ouch... Also ATAG_CMDLINE... which is probably reason why cmdline=20
passed from bootloader is ignored.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3720473.JLXMeiLLZh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR+LvAACgkQi/DJPQPkQ1K9KQCfd4n6fI4lvKlhoqk6RU8Om/tu
oK4An0JU5DTycGthkiX31et3+uhsL3M5
=sGBE
-----END PGP SIGNATURE-----

--nextPart3720473.JLXMeiLLZh--
