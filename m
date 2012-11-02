From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Remove NEED_MACH_GPIO_H
Date: Fri, 2 Nov 2012 14:25:20 +0000
Message-ID: <20121102142519.GZ4413@opensource.wolfsonmicro.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224823.2103.24591.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3Nkz3fRLNVT9Ca+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33062 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750746Ab2KBOZV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 10:25:21 -0400
Content-Disposition: inline
In-Reply-To: <20121101224823.2103.24591.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>


--z3Nkz3fRLNVT9Ca+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2012 at 03:48:23PM -0700, Tony Lindgren wrote:
> Omap no longer needs this option, mach/gpio.h is
> empty.
>=20
> Also remove mach/irqs.h from gpio-omap.h and
> include it directly from the related omap1
> gpio init files.
>=20
> Otherwise omap2+ build fails for MULTI_PLATFORM.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--z3Nkz3fRLNVT9Ca+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk9fGAAoJELSic+t+oim9pNsQAIcqe5ZxhROT4LpC5NNtM5Sh
a5QOJSoFYakvSK6x8m2S6asKu1f4Nhn271hF2PmnjYAR9B7cIX4co86PzOe8iLxV
WXZT4z6nGaWe3QYaGzTXqf9daGBYSyZR5NQ8NPFVPV8oCMFZ/eZGvVM9AMrvPxfW
KHH52DrU/yw4BFSuaBGvMj9/y8yuReduoFl/7XhFy/yk2lboRBokLCy9hfEkhu/J
G8rblwPlOlibaPwHWvgusptw4pwTXPTgWlNRlz+klbSBt6Nby0qLoHY7fgNmp5pC
t8zrvMEE7MZQA9cVWGkMONAWpk2jXAAZNLOgLHupSMgXDp8PMd7sXrz/3dFdd8Im
j7rle/6ERrxB6Dxo8C2nMTOpbkgm3HnRAUyoLzXHD8UguIijAX1RKMA8j7NalKMb
/E6yBy9uZr/JFDofBBAvi5EUav147JamEulYZ8+RMrKe/Anp5wXyxm2fBudLB7RI
FQqHOSWQjr6t0D/IStJgGfLIfm9/RC9TcJH+C3MNeKkU5W6joM4uuhCKkFx12oQR
cJoXvYFL6z2mWpFs9evq8obCqyLPLnaMBDwTb7XuI8UtIomFG7ellyi5FUb8Totz
m/AoAslAgyN6SzQEMYGrbOZgfxXOh814BZXK8H+26dFxTTbWX4xidXkK28j7UyuI
NB0isadLhjy1osnufanT
=7V75
-----END PGP SIGNATURE-----

--z3Nkz3fRLNVT9Ca+--
