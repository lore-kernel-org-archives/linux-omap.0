From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 16:23:36 +0100
Message-ID: <201501061623.36687@pali>
References: <20150105230228.GO4081@atomide.com> <201501060009.15806@pali> <20150106150353.GA2321@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1808105.xp1FsvvNWM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:62994 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbAFPXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 10:23:40 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so6261471wiv.2
        for <linux-omap@vger.kernel.org>; Tue, 06 Jan 2015 07:23:39 -0800 (PST)
In-Reply-To: <20150106150353.GA2321@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>

--nextPart1808105.xp1FsvvNWM
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 January 2015 16:03:54 Sebastian Reichel wrote:
> Hi Pali,
>=20
> On Tue, Jan 06, 2015 at 12:09:15AM +0100, Pali Roh=C3=A1r wrote:
> > Just to note that smc91x ethernet support is also in qemu
> > n900 emulation. Later I will try if it work with upstream
> > kernel...
>=20
> $ qemu-system-arm --machine '?' | grep n900 || echo "No N900
> support" No N900 support
>=20
> Is there work going on to mainline the n900 patches for qemu?
>=20
> -- Sebastian

I do not know, but n900 support is part of linaro qemu version.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1808105.xp1FsvvNWM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSr/fgACgkQi/DJPQPkQ1Jn0ACffm230Bpy5EWZwUiW/I4KVZFp
zM4An2VSBAJt+s6FqIFhq7iEj3vNa+Kw
=CnVk
-----END PGP SIGNATURE-----

--nextPart1808105.xp1FsvvNWM--
