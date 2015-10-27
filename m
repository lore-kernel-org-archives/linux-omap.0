From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: tps65217: remove tps65217.dtsi file
Date: Tue, 27 Oct 2015 09:31:27 +0900
Message-ID: <20151027003127.GL28319@sirena.org.uk>
References: <1445850836-17863-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVcIhgQsEzAXu06J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445850836-17863-1-git-send-email-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Georg.Soffel@bosch-si.com, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, Mark Jackson <mpfj@newflow.co.uk>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org


--EVcIhgQsEzAXu06J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2015 at 10:13:55AM +0100, Heiko Schocher wrote:
> remove tps65217.dtsi and adapt all boards, which
> used it.

Acked-by: Mark Brown <broonie@kernel.org>

but really this is a DTS change so I'd expect it to go via arm-soc
rather than me.

--EVcIhgQsEzAXu06J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWLsXfAAoJECTWi3JdVIfQYrkH/1ciQAakBPw0mSJsryPcTz/R
GmNG+OxF6dQyARJwPOPjOrDWem56pAuQFuuJ77M9PefsAwaLITsTJKVUfO6aEuj2
MNwjOsdamPcBWOQCghk9BXh/Hr1Gjg0N9V/pz7DAEnqEZHRMH8DFeeh3pmjcMGic
g/UlZ0Vb3PEsTJRdkZ5aIC5hobN6hSMJSkeiVdWw0jpSx5WBgixbJxsmSZT16Gcq
rbaX6Vwl2MoKAzdxb6sgysd6spiN6sNBBfg/pQHC+zDLE2HgW7FP0gcDv7t/XQ7l
lnoRzV6xeff76Z9V1ZipexsId0uDv8VMgay7jN1ZT8lleNhPtbY2+TFPzXiOkv4=
=o5aE
-----END PGP SIGNATURE-----

--EVcIhgQsEzAXu06J--
