From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Fix eMMC on n900 with device tree
Date: Fri, 22 Nov 2013 17:35:33 +0100
Message-ID: <20131122163532.GA32331@earth.universe>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
 <1385059866-10646-4-git-send-email-tony@atomide.com>
 <20131121231751.GA9772@earth.universe>
 <20131121235729.GD10023@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:39142 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755723Ab3KVQhU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Nov 2013 11:37:20 -0500
Content-Disposition: inline
In-Reply-To: <20131121235729.GD10023@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 03:57:29PM -0800, Tony Lindgren wrote:
> Well let's use just vaux3 then with a comment to the .dts file if that
> works also on your 0x2204. It works on my 0x0010 too.
>=20
> I folded in your changes to the updated patch below. Care to reply with
> your Signed-off-by too assuming it works also on your 0x2204 n900?

It does work with the 0x2204 phone.

Signed-off-by: Sebastian Reichel <sre@debian.org>

-- Sebastian

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSj4fTAAoJENju1/PIO/qaAdMP/2beEloN3FVcsaphDov110yP
mKudvKF8MQBia2lkcSBsrI79ONwZOfZheZ0EGnHJWHELXxN2ax10d/dYbMhWB8pb
hgn5bKxR72cjC0UOwMbTmS5Sk1hH8onaaEh228sBRttaf3/lItbJHZxENyhDe/ls
h3ELyROwgE/v65Y/YUOUWZARx2sBUQyrj2lJZgpjenGRHyUH2xLXvSRyukZM8YEe
wSxXTlL8TwhItWxrQwkKZwBMg7pxhRGwlgSfJxYv3efEFeL/wP2ujNTBBp7ZsRRU
iN72mXdFgc4g1jTwADbIbmhffzqntEW39mFHKFyMtg1JBoZHlkxV6wv04wOo175c
0vDs5hC+A/Vokxd6h5TiajFQnNb6K3kpBwrVL10rmjKz1q5/RCbh5N0e3++SZNku
BcTLH/m5D1inBxdt9h0MlqTaavvMZZBH+FMe6sTBa9STDH9qkjesgRFT7DztW3hG
c++ZOvsJ5eql9rDnGp1L/+kZ6UtE6GAvAPulcnq+FK7vbjOeBwUzA7XKUWZqRHFy
4Oz2o02hcuApBwo6KtbNua5cDxtVP1WgAbFNCZC96wCt6MInouVk95nFjl3sZmPj
BPnJQIfHiNV5vdCsABAH2IvQKK1Klom/t5qig9OJbxwYJflQaV3z/JQzFEi88/B8
O4oDgthIubHLp+pmWb9c
=6O0u
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
