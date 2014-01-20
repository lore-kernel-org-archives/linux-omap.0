From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCHv13 27/40] ARM: dts: omap3 clock data
Date: Mon, 20 Jan 2014 19:00:54 +0100
Message-ID: <20140120180053.GA25920@earth.universe>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <1389276051-1326-28-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:38996 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbaATSA6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jan 2014 13:00:58 -0500
Content-Disposition: inline
In-Reply-To: <1389276051-1326-28-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I just found some time to update my SSI driver adding DT clock
support. It works, but I wonder if the alias of the ssi clocks
can be changed to something like the following:

/* omap3430es1-clocks.dtsi */
ssi_ick: ssi_ick_3430es1 {};
ssi_ssr_fck: ssi_ssr_fck_3430es1 {};
ssi_sst_fck: ssi_sst_fck_3430es1 {};

/* omap36xx-omap3430es2plus-clocks.dtsi */
ssi_ick: ssi_ick_3430es2 {};
ssi_ssr_fck: ssi_ssr_fck_3430es2 {};
ssi_sst_fck: ssi_sst_fck_3430es2 {};

With this change I can reference the ssi clocks in omap3.dtsi
instead of creating files for omap3430es1 and omap3430es2+.

-- Sebastian

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJS3WRVAAoJENju1/PIO/qaICEP/Rv7AAzH4Id9zCTDDV2tuMh6
5kYeqM05EcAA6ES5XaNI3cs76jnsGkLfHMWy682pZU0ePgtgQbOiHE81YYY55kW5
+nN+dWz5hOhTmcgkaU+yv9NkluYfpu474EF4NODTjXSk1XPpZb45FdeANrLyRz4N
6jcozWeUA0DPHRAN8cgM5Zj7J9lPdW4COO6QQA1W0cWMD0qGc4cWGYAuIptTloNV
AzeT1zx0Cy2IRS90HmBKPVJOYKgfcCn6nn9wO5+Qaq+UIC2J0QgpT9T8IOyxfPsM
m1LxY5678YpD1MK0FWpiNwZmBR0WjwEDLp/DwdJUHXpc1TnSxGNOhV+9vSSEGfwp
WLzFr+pBZB8MYN646sJU6fAIMsXG13FbodjDM/WSa6yhMAAE+KOin5KbpqTY8wDv
B1EgQoZfscEMn75Q77KIm91j4N+EZKdJ/Tkzgcwyt/BNM0IEadUnh2dImAoUq+0I
uhjfZYlOGmdiANIwteWfgvR9qJrcJ3F29YCgf4pfUvTbIV5ly2NJlPwCbiqLvHEj
ER4o9xqmWBU6y3LEZQizlSc3QNouirmnm2mC3X/9Tkg+rj/qm42hSPP1/SYBZbme
zEWBzeFMZmsU6VV6Tjjp4BPnWl+BS68d2SYAHjpBxodTMbaLg8tCq8hlhN0gzRc8
KN1Av8nyzQk8i+yx1iX6
=HVxk
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
