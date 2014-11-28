From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Fri, 28 Nov 2014 23:43:34 +0100
Message-ID: <201411282343.34538@pali>
References: <20141027200008.GR2560@atomide.com> <201411282241.12095@pali> <20141128222630.GA1382@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1503741.MukHUtLuNv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:60627 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaK1Wnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 17:43:37 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so9724413wgh.6
        for <linux-omap@vger.kernel.org>; Fri, 28 Nov 2014 14:43:36 -0800 (PST)
In-Reply-To: <20141128222630.GA1382@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart1503741.MukHUtLuNv
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 28 November 2014 23:26:30 Aaro Koskinen wrote:
> Hi,
>=20
> On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh=C3=A1r wrote:
> > Does kernel provide some interface for telling userspace
> > applications something like bootreason (e.g power key,
> > software reset, rtc alarm, charger connected, ...)?
>=20
> In N950/N9, NOLO passes this information using kernel command
> line and applications are reading /proc/cmdline. If I
> remember correctly all those custom proc files were removed
> from Nokia kernel, and everything was passed via command
> line.
>=20
> A.

Yes, you are right. But NOLO on N900 pass all those data via=20
ATAGs only and does not pass it in /proc/cmdline :-(

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1503741.MukHUtLuNv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR4+pYACgkQi/DJPQPkQ1Iz9QCghkFIrY207/FQoozfhrTPeKrK
l/sAnRuEnBddcbzY+XAZV+Y6dI+JMGnl
=D86N
-----END PGP SIGNATURE-----

--nextPart1503741.MukHUtLuNv--
