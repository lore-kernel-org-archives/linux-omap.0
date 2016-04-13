From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 0/7] Implement generic ASoC HDMI codec and use it in
 tda998x
Date: Wed, 13 Apr 2016 18:26:00 +0100
Message-ID: <20160413172600.GD29471@sirena.org.uk>
References: <cover.1459431292.git.jsarha@ti.com>
 <20160413070219.GN14664@sirena.org.uk> <570DFADD.60608@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1680884356=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <570DFADD.60608@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============1680884356==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 10:53:01AM +0300, Jyri Sarha wrote:
> On 04/13/16 10:02, Mark Brown wrote:

> > None of the ASoC specific patches here have had any review from other
> > HDMI users?

> I got ack from Arnaud Pouliquen and tested-by from Philipp Zabel for
> "ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders" in
> previous version of the series. Since then there is one minimal change,
> but because I touched the patch I removed the ack and tested-by tags.

Yes, I remember but if you think the change is big enough to warrant
removing the tags I'm hoping to see some interest in review!

> The change is setting hw_params->msbits to 24 in hw_params() callback if
> sample width is greater than 24 bits.

That is reasonably small though...

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDoEnAAoJECTWi3JdVIfQKBAH/3nT5ILYMCNU/RBT6s9lDrtl
asnYbCY2Yx8DgXcQFn0XFnMzS+st0kSi376LOqpi5uDicBZySORXHY4luTNUofm1
LEOVNOT3eyiCLw+qJM9jndZJn+KAfHJ5NysdLeAW3hfKDHt573MWz6NJ5O7ZpZ9n
oIL+VgqKlOlf1ooHgnUrvJRL+rhfrQtaKp+4hDrCtKGJevfkmxaZAiTe1Sl8Ao4s
8ty9CUY1N4DGSzzgg59D5CepH604KsqGayF7s7aTJPurZYtD+mWGFCVzrlQMOa5T
ACBfqvadAAGof6xG0C+Kk82T8vZ95g8p1TVCCr1vx/lTT4gtBQELnW7VsDYrfIc=
=qa4K
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--

--===============1680884356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1680884356==--
