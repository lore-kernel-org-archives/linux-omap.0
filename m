From: green <greenfreedom10@gmail.com>
Subject: Re: FYI: Retu RTC script for setting and storing system time in
	N8x0
Date: Mon, 22 Dec 2008 08:03:20 -0600
Message-ID: <20081222140320.GE12324@swansys>
References: <20081219133849.c31b5258.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:60622 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbYLVR30 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 12:29:26 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1187842qwe.37
        for <linux-omap@vger.kernel.org>; Mon, 22 Dec 2008 09:29:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081219133849.c31b5258.jarkko.nikula@nokia.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2008.12.19, 354, Jarkko Nikula wrote:
> I hacked once this Debian script for setting the N8x0 system time from
> Retu RTC during the boot and saving the time stamp when doing shutdown.
>=20
> Script can coexist with other hwclock and ntpdate scripts and can work
> with read-only root as well. So if script cannot store the timestamp
> diff then Retu RTC is not cleared.

Great; thanks!  I'll try this out sometime.

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklPnigACgkQ682C+dBP+oS17wCgpROoLsy9UKGHkA03tdNb06eB
wxYAoPdzCwQR/E6bZyFpmGpk90gwK0kR
=URXq
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
