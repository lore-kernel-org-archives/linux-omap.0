From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v9 0/7] Implement generic ASoC HDMI codec and use it in
 tda998x
Date: Wed, 13 Apr 2016 10:53:01 +0300
Message-ID: <570DFADD.60608@ti.com>
References: <cover.1459431292.git.jsarha@ti.com>
 <20160413070219.GN14664@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2106630239=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160413070219.GN14664@sirena.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============2106630239==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lspUvVoqKA9xFKtHNLWxqhakbxkRE7QM8"

--lspUvVoqKA9xFKtHNLWxqhakbxkRE7QM8
Content-Type: multipart/mixed; boundary="DwObJmeSxdijMPFaNPLDKA7txXpUwWrHP"
From: Jyri Sarha <jsarha@ti.com>
To: Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 bcousson@baylibre.com, alsa-devel@alsa-project.org, tony@atomide.com,
 liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com,
 tomi.valkeinen@ti.com, tiwai@suse.de, rmk+kernel@arm.linux.org.uk,
 p.zabel@pengutronix.de, arnaud.pouliquen@st.com
Message-ID: <570DFADD.60608@ti.com>
Subject: Re: [PATCH v9 0/7] Implement generic ASoC HDMI codec and use it in
 tda998x
References: <cover.1459431292.git.jsarha@ti.com>
 <20160413070219.GN14664@sirena.org.uk>
In-Reply-To: <20160413070219.GN14664@sirena.org.uk>

--DwObJmeSxdijMPFaNPLDKA7txXpUwWrHP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/13/16 10:02, Mark Brown wrote:
> On Thu, Mar 31, 2016 at 04:35:57PM +0300, Jyri Sarha wrote:
>> Couple of minor changes since v8 to ALSA/ASoC side patches. The series=

>> is based on top of drm-next. However, it does not look like there is
>> enough attention to the DRM side so that the tda998x patches would get=

>> in any time soon. So I am happy to rebase the first ALSA-side patches
>> on top of Mark Brown's for-next tree, for instance, if they would have=

>> a change to go in on their own. The first two IEC958 helper patches
>> should apply as such.
>=20
> None of the ASoC specific patches here have had any review from other
> HDMI users?
>=20

I got ack from Arnaud Pouliquen and tested-by from Philipp Zabel for
"ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders" in
previous version of the series. Since then there is one minimal change,
but because I touched the patch I removed the ack and tested-by tags.

The change is setting hw_params->msbits to 24 in hw_params() callback if
sample width is greater than 24 bits.

Best regards,
Jyri


--DwObJmeSxdijMPFaNPLDKA7txXpUwWrHP--

--lspUvVoqKA9xFKtHNLWxqhakbxkRE7QM8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXDfrnAAoJEJA2s1DX1hlB2AQQAIykJU5yYLod+RJfQ2omJ00n
1Dfkb/W5P8f8iHq2bSsTHCFInqF2s7VSy0Nxg+Ue771f3vYMD6aId6Ja8t/fODwM
RlCf7DVhQ9ZFpbiCKUo759kslurDnmtHhUYEfAwCD9lxCXKc3nZXGLQmBz7MZyCi
Ix9Mm/K0BDC9Rxkr5lSyyFNAtrX8fN+6KQcbWBU8Ks473lHtjq88e7l3OyfwUp6R
4A4QXrTHMQA1cYQrfgrlIMdp0na/7kLnuteGhNS/J9bTWw9CTyHMGkf0B3ZdLD2Z
8+XPnDO/rRgJC+Azx9Qv7heEYCFnvgoMUbdgyWkpt96LP7AkFrnn486SWjyVfbuG
LvQMXq+3s5OEQzIoIJBzMDJCMTxl5ZcLtR0dN8aVN1Uu9nXs4EgnnbxDh4VqJWPd
es9/kxGlrzAImy50AILyHe3DWemuEGgCYoxQ4w+g2bxYypxmwpUyM2LijvtmkJh7
wHf8yLgBb01jra6mHV5Ho6ur4CeWSs49PP8oxr5CBPOZUHPYuXo1wnj+ecb1sQW4
rey28hxqNrvUbnambnUVhpT0mbbE3OplZ9ny95RCw2S5NEVfdBWat1ldcN39JEIQ
2xfyqGQz0kailEx7UJ3suZE/Mx5WoMdjAFBbBxvnM9TqXSlxruVLz+5ehUpo6ePD
EJkcEZJidiIs1JRELP7d
=jAHr
-----END PGP SIGNATURE-----

--lspUvVoqKA9xFKtHNLWxqhakbxkRE7QM8--

--===============2106630239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2106630239==--
