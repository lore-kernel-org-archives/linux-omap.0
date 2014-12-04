From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 4 Dec 2014 20:01:36 +0100
Message-ID: <201412042001.36805@pali>
References: <20141027200008.GR2560@atomide.com> <201412041934.03384@pali> <20141204184033.GI2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart38320720.p06OznuTKD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57160 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbaLDTBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 14:01:40 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so23562957wgh.32
        for <linux-omap@vger.kernel.org>; Thu, 04 Dec 2014 11:01:39 -0800 (PST)
In-Reply-To: <20141204184033.GI2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart38320720.p06OznuTKD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 04 December 2014 19:40:34 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141204 10:36]:
> > see last mail in thread (I CCed you):
> > "[PATCH] ARM: /proc/cpuinfo: Use DT machine name when
> > possible"
> >=20
> > There is already some layer for converting ATAGs to DTB and
> > it is in decompresser:
> > arch/arm/boot/compressed/atags_to_fdt.c
> >=20
> > I do not know if it can help us to provide /proc/cpuinfo and
> > /proc/atags in DT boot, but at least this this transfer
> > cmdline and mem ATAGs to DBT.
>=20
> Yes that makes sense to me. Sorry forgot about that piece of
> code as I have not tinkered with arch/arm/boot/compressed/*
> for a few years.
>=20

I did not know about that code in compressed too...

> It sounds like there may be some regression also if the
> cmdline is not being passed like it already should. But I
> assume you already figured that out and have some patches
> coming :)
>=20
> Regards,
>=20
> Tony

I did not start find out why it not working (do not have time=20
now), but at least I know where to start looking for it.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart38320720.p06OznuTKD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSAr5AACgkQi/DJPQPkQ1LhxwCglFj+ai7INiedhJGJOCnzPQP9
PJwAnjPEWbVZL42i80UbDP1SeAvXEmc3
=Eh3V
-----END PGP SIGNATURE-----

--nextPart38320720.p06OznuTKD--
