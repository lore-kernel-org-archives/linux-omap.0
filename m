From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v3.19: Nokia N900 - usb nokia gadget crash
Date: Mon, 2 Feb 2015 23:47:26 +0100
Message-ID: <201502022347.26582@pali>
References: <201501311006.11909@pali> <20150202221713.GB30753@saruman.tx.rr.com> <20150202222727.GC30753@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1444195.Zli66kGiKV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:47350 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965072AbbBBWra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2015 17:47:30 -0500
In-Reply-To: <20150202222727.GC30753@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>

--nextPart1444195.Zli66kGiKV
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 February 2015 23:27:27 Felipe Balbi wrote:
> On Mon, Feb 02, 2015 at 04:17:13PM -0600, Felipe Balbi wrote:
> > On Sat, Jan 31, 2015 at 10:25:09AM +0100, Pali Roh=C3=A1r wrote:
> > > On Saturday 31 January 2015 10:06:11 Pali Roh=C3=A1r wrote:
> > > > Hello,
> > > >=20
> > > > when I try to modprobe g_nokia.ko gadget module on n900
> > > > device, it produce tons on lines to display and then
> > > > crash and reboot device. So its not working and I
> > > > (without Nokia (TM) serial console I cannot debug it).
> > >=20
> > > When I compile g_nokia into zImage (not as external
> > > module) then it kernel loads correctly and usb is
> > > working.
> > >=20
> > > Any idea why g_nokia as external kernel module cause
> > > problems, but compiled into zImage is working??
> >=20
> > what I got here is a WARNING from f_phonet only, I'll look
> > into it. Keep in mind I don't have N900 available, testing
> > with beagleboneblack and AM437x SK.
>=20
> looks like there's a bug with MUSB too which needs fixing for
> that. Did you get "inconsistent lock stae" WARN ?

I cannot read any message after I modprobe g_nokia.ko

I just see that kernel try to overwrite couple of lines on n900=20
display and after 1-3 seconds device reboot.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1444195.Zli66kGiKV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTP/n4ACgkQi/DJPQPkQ1ImLwCeNM0PoV7RSIo9jHJXY0TuMhuw
s6UAoMnpeYLXrpYHwc4sVyIQ1BcluPSA
=cqly
-----END PGP SIGNATURE-----

--nextPart1444195.Zli66kGiKV--
