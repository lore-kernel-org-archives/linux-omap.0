From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/11] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 14:13:08 +0300
Message-ID: <20110711111306.GY2680@legolas.emea.dhcp.ti.com>
References: <1310165559-31037-1-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QZ+LYBYf4/WKxcjd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40516 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754229Ab1GKLNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:13:13 -0400
Received: by mail-yx0-f171.google.com with SMTP id 38so2034938yxk.16
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310165559-31037-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--QZ+LYBYf4/WKxcjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 09, 2011 at 01:52:28AM +0300, Felipe Balbi wrote:
> Hi Tony,
>=20
> a few more CBUS patches. I started cleaning
> up tahvo and also found two possible optimizations
> on Retu which are based on patches from Thomas
> Gleixner and Sebastian Siewior - on other pieces
> of code, of course :-p
>=20
> These patches were compile tested only. It would
> be very nice if someone could actually measure
> IRQ latency on Retu to see if managed to spend
> considerably less time looping on the IDR register.
>=20
> Anyway, following are the patches.

hold on.. I made more patches... will send them all in a jiffy, forget
about this version.

--=20
balbi

--QZ+LYBYf4/WKxcjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGtrCAAoJEAv8Txj19kN1Nq8IAKviVJ/q4H+ICH1vIuZewcnk
K4DAkxbvVbWDRdgO1/kGVksMIE+FhreJ7Bd1dawC+QtIXHIkYfhynVQQbf3V1RIK
PZjazv6WybbQA0mpiHpQe5KQRVQSb6s4BaelpjqlNSeRK9wZXhJGOOAM/5P9Gtl6
o/j8doCTCm6At7MZBEjznPc+oRVymo8EYZB9Dju4ef0C1mTlVgsAmkegS+KDkkBC
LgIv3oOYzWBGuO5kOt7W/8kzgVyzvJQ05uHXDnm7kpRl8HfgtwafYuRAzmDkhZD9
CQHl9Q5hfXDlQzJhfEQxTJOiFuhsvPGfx5Lj3njlYFHuLtdXJipg4ux+9sP8lwM=
=E3L7
-----END PGP SIGNATURE-----

--QZ+LYBYf4/WKxcjd--
