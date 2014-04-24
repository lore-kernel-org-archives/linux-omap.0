From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Thu, 24 Apr 2014 13:29:14 -0500
Message-ID: <20140424182914.GD4659@saruman.home>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55110 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758127AbaDXS3k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 14:29:40 -0400
Content-Disposition: inline
In-Reply-To: <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>

--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 17, 2014 at 09:44:59AM +0200, Tomi Valkeinen wrote:
> omap2_dpll_round_rate() doesn't actually round the given rate, even if
> the name and the description so hints. Instead it only tries to find an
> exact rate match, or if that fails, return ~0 as an error.
>=20
> What this basically means is that the user of the clock needs to know
> what rates the dpll can support, which obviously isn't right.
>=20
> This patch adds a simple method of rounding: during the iteration, the
> code keeps track of the closest rate match. If no exact match is found,
> the closest is returned.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Tony, looks like this patch was lost. Are you taking it during the -rc ?

--=20
balbi

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWVf6AAoJEIaOsuA1yqRE/LMP/259UhEYNgHxDAlSpww+X/ZC
Wocl6fsx5zcOZe3SriYTxEx2S0/imMGAGUGtDm0yuLogzEWfLrndXJe4JvnVaauD
O606h7nmzIinroepp6hXqGPrn0USGbrYnBU8fsRRw3jUNtfg5xon0KXWyjxwrrvc
44Qx3GGArDWZIFNYhrQbMXi1Ypko73+C2Kp7iokYmIWupui9QcoSWwoF3EmZSEtP
pblI9PDll5mqoLSFJ8qXasr0CELs9NN5VGuIeuHCQhHAPuNSNuwIsM9r8YBkETzy
wwLu11IzqsaYKiKmwXsXMD1WkM3sniehg35xndC/wIhbExuYnrHtaKqK5PZ7uS0e
k2TM0ECoAIIiYKia1lbvZ2Qlw5glbcVYCUKOxvDhLXKDyQitwJuEBlvMIgIqnq0I
ucO38Hk2kSxfgynISxS2oIAUVpq5nAH2iJuq/2SqP9YAfFsk35IKgtW8Sv7RL1Ns
F6GJMyRsaMU55F3JLR7dIJU3p/YSB7a383ls4zojxtMjG+YNUzuJSUqt9TRRpnic
1VNFv76+X19YHeHwPzUD2zpTXDuulyYjgNSm+Xzfr0J4yS7mPcQGFoNM2QiTAyA5
qjPxZVFQTv734He/a2Nhbbq+l1svj0Uf1xMtsJ53VdG6THHpM+szpEAiotSvO57t
IS65c6FX4HsibWJNWokS
=Rye4
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
