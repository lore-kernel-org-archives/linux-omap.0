From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 16:03:54 +0100
Message-ID: <20150106150353.GA2321@earth.universe>
References: <20150105230228.GO4081@atomide.com>
 <201501060009.15806@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55017 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433AbbAFPEC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2015 10:04:02 -0500
Content-Disposition: inline
In-Reply-To: <201501060009.15806@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Tue, Jan 06, 2015 at 12:09:15AM +0100, Pali Roh=E1r wrote:
> Just to note that smc91x ethernet support is also in qemu n900
> emulation. Later I will try if it work with upstream kernel...

$ qemu-system-arm --machine '?' | grep n900 || echo "No N900 support"
No N900 support

Is there work going on to mainline the n900 patches for qemu?

-- Sebastian

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUq/lWAAoJENju1/PIO/qa1eIP/izxQpjsrKRlu99jNYYUbT5Z
KU4h3Z89Ltdr0uJEluSsimrTTFqT9mI700yw3KNgZmCdtvHkQbdARxsS5B5vcH06
EZ7t0y2sMJ/U/tbWhcDv8BAxt0pFQdadmnPlHLAr2ef+5yEdbYqK2NmwVcwvwlJG
oL4wkjSmfOZhHb31A3ud54sxRNaQ4lHrDr0J4c/vSiX6Gb6DzmUOucPa7tJtGkQA
8G/RS8ygxtJWChner2z/XOwzVUsPpdgNQFKXqC3dHPsY2y9EG6KakzabBKeeKu+0
wYvSZ/KV87at6GDrb7KYe/cfqGyMwKRguYuZ9dA29Ehy5WrvQCMc3RNZxa3P92gl
xPXbo4U8YmUv67Og/HyNjZqSP6PEzqH7lGm3vAiHO4uzMxOc/urMDZX3/O7tQf+R
Irb/c7rV5uhT0QcWDuPRXvY5XHHNwyxA8d1JKPwoEvM8IkJmh7TmgL+z3vwc3/xS
qX1UBIN8pqnQ322P9OY4LFnpCQqWz/oMToU3jN+Ptgad+UCyEr7upxi3qUlC0sto
wAyfAdpZAvVC+hV55lo16auDYCdhqYL9BGEIs6ADnHsu6W+5Ugb/K/IJLLcy6s82
4QKemFDCX5X6sTzZ+BkHKabAbfwBjdFQBPftLbfRu0JT1qQkzq+p4zclvnqlXe2/
3IvHG8oHrYCJ1ReuwlEG
=tTB3
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
