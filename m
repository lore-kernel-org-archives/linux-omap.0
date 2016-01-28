From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/5] HSI: ssi-protocol: Use handshake logic from n950
Date: Thu, 28 Jan 2016 17:54:16 +0100
Message-ID: <20160128165415.GC17038@earth>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
 <1453045749-22642-5-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453045749-22642-5-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 17, 2016 at 04:49:08PM +0100, Sebastian Reichel wrote:
> When using the ssi-protocol driver with the Nokia N950, the
> following error is thrown during modem powered up sequence.
>=20
> [13852.274993]  port0: SSI error: 0x01
> [13852.279205] ssi-protocol ssi-protocol: RX error detected
> [13852.284820] ssi-protocol ssi-protocol: Main state: 1
> [13852.290069] ssi-protocol ssi-protocol: Recv state: 0
> [13852.295288] ssi-protocol ssi-protocol: Send state: 0
> [13852.300537] ssi-protocol ssi-protocol: CMT Offline
> [13852.305603] ssi-protocol ssi-protocol: Wake test 1
> [13852.310638] ssi-protocol ssi-protocol: Data RX id: 0
> [13852.315887] ssi-protocol ssi-protocol: Data TX id: 0
> [13856.001464] ssi-protocol ssi-protocol: Watchdog trigerred
> [13856.007293] ssi-protocol ssi-protocol: Main state: 1
> [13856.012542] ssi-protocol ssi-protocol: Recv state: 0
> [13856.017761] ssi-protocol ssi-protocol: Send state: 0
> [13856.023010] ssi-protocol ssi-protocol: CMT Offline
> [13856.028045] ssi-protocol ssi-protocol: Wake test 0
> [13856.033111] ssi-protocol ssi-protocol: Data RX id: 0
> [13856.038330] ssi-protocol ssi-protocol: Data TX id: 0
>=20
> This patch fixes the issue by using the handshake setup from
> the Nokia N950 kernel. The new handshake sequence also works
> with the N900, so there is no need to differentiate between
> both modems.

I queued this patch with Aaro's Tested-By:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=3D=
for-next&id=3D87d99063be016ceee90723a13365a40b21eec0d9

-- Sebastian

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqke3AAoJENju1/PIO/qa3VUP/3bAw2lCTWkYxcMi4ImITxJg
uqjv+28LuQyiVHekc/sV+1J3YzyR1oDic59t/KxbNlmpi8WuewOuR8q7R7MZroOk
3PCNgcpSTRSMrBejjXLq0IhGVaSH0AdEmcucZ64GrwgxxKYZJVLfxJPr0S+nfads
pWv/RS6WObSRQV6UNoDcUc+3MYw9yBQf2LoZVfbuK4Tm7BsduFFvBnxNr3TzvwkR
WVHsI+sElz9pno1cKDN9iPlBo2tdZyMeso4WYI0+Hq/fX8EUYheEBVIqImdOMRVz
6Lth6RZdf1hfBPpJ4FIyGaYp006povy83ErZl9LN/3fvaoEYpGOg86tCzbuwFYR8
TxfHiDAymXk2x+ddajrHCyMwalJRtYxvk6LYuTX8zYgpU3owYe1tndSRYK/xe2td
cxixn14KKagl+xQZUmrDiQN+d8INmw2oDcOlGqPh9UoYccF0ADh9+sj3WIvAQHyC
v32ECdmk+lFy2odIxUyIdBeD64A6MhH0W8UDPZHcn442ecnUVbR19aeQVH4HNFL6
gjRt0YWPCaC09urt6KNpi46nnFB/Wur+uHiDZhcrzpM3rtmaRRcFYgm2ewdRcQl4
SzExuRlEtdEjyE/InQGprxRFE0j4Nq6qnrWd7JKWDR2vGYirxDkauXrqKAkh1SMa
shoOXbDp8z1GVVIcyReM
=4Y9x
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
