From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 26 Nov 2014 19:57:08 +0100
Message-ID: <201411261957.08860@pali>
References: <20141027200008.GR2560@atomide.com> <20141126172857.GA26157@amd> <20141126181934.GL2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1822310.B1qtr1HzKQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42998 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaKZS5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 13:57:12 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so13492658wiv.11
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 10:57:11 -0800 (PST)
In-Reply-To: <20141126181934.GL2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart1822310.B1qtr1HzKQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 November 2014 19:19:35 Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [141126 09:31]:
> > On Tue 2014-10-28 01:01:38, Aaro Koskinen wrote:
> > > Hi,
> > >=20
> > > On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren=20
wrote:
> > > > +
> > > > +	if (!of_have_populated_dt())
> > > > +		pr_warn("WARNING: legacy booting deprecated, please
> > > > update to boot with .dts\n"); +
> > >=20
> > > Maybe use WARN so that the warning is more verbose and
> > > kernel gets tainted?
> >=20
> > Well.. Pali still has regression where /proc/cpuinfo changes
> > in a way that breaks existing userspace, when dt is used on
> > N900.
> >=20
> > And rmk was less then helpfull...
>=20
> Maybe Pali can try to restart that discussion? To me it seems
> the /proc/cpuinfo should be the same as it's a user
> interface. Sorry forgot the details of the previous
> discussion..
>=20

Yes, two days ago I again wrote emails about this problem...

E.g. one of them, see: https://lkml.org/lkml/2014/11/24/774

> And with which app was that? Sorry I forgot..
>=20

More applications/libraries for N900 which running on Maemo 5=20
system. Some of them are Nokia proprietary, some of them are open=20
source and some are mine.

Basically problem is that non DT boot provides this info in=20
/proc/cpuinfo:

Hardware        : Nokia RX-51 board
Revision        : 0012

New DT boot provides this:

Hardware        : Generic OMAP3 (Flattened Device Tree)
Revision        : 0000

> It's weird that it's not been an issue for other though?
>=20
> > Should we maybe solve that before adding backtraces to our
> > boot messages?
>=20
> With this warning we want to notify the people actually using
> mainline kernel on omap3 that they should update their
> systems. And also let us know on this list about the
> regressions, so I think that's quite valuable.
>=20
> Regards,
>=20
> Tony

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1822310.B1qtr1HzKQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR2IoQACgkQi/DJPQPkQ1Io9gCeOMqMzvI5N/FxxZxrPjPN7lOj
OekAnjnQDd9ToS1v9+ctUgvyNURzisFt
=naWe
-----END PGP SIGNATURE-----

--nextPart1822310.B1qtr1HzKQ--
