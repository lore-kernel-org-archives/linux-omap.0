From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 1/6] ALSA: pcm: add IEC958 channel status helper for
 hw_params
Date: Mon, 28 Mar 2016 12:38:01 -0700
Message-ID: <20160328193801.GI2350@sirena.org.uk>
References: <cover.1458214526.git.jsarha@ti.com>
 <164484552294777b0b9b88d7982bd6bfb0da9a9f.1458214526.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1724348531=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <164484552294777b0b9b88d7982bd6bfb0da9a9f.1458214526.git.jsarha@ti.com>
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


--===============1724348531==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Content-Disposition: inline


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2016 at 02:22:29PM +0200, Jyri Sarha wrote:
> Add IEC958 channel status helper that gets the audio properties from
> snd_pcm_hw_params instead of snd_pcm_runtime. This is needed to
> produce the channel status bits already in audio stream configuration
> phase.

Takashi?

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+YgXAAoJECTWi3JdVIfQAs0H/RYb3o5zjgkQ3CYHI1U9rfcP
82WbmTqYQvCoKB8ZGQvgh6em9aNNIiwmaWltx9ZswmxLxT3vWkoqmjp+EN3pkXN2
k3cg9ZKSjzTBh749duR8J3nICbzhUc363ntypAOjYhQ5E4jNyhwh+AnR4vGC4/Sb
SrY0WXi0JkKHRFce5LfbPYbdPhv76sRcTFVidetUtimTTJ9jNJ33CkmXEZ9NEAX9
gajgQoeujmJ8Pjwb7k4oqeh8B8AcDgpBnVULEv0CDL3QkPfxqaNJl4DgKHDRqu2J
Cbt5x5NTqH3+DM4zyHNbhOk4sFun0pczB8+zhv/CPWUwpcID18kCGhjXvIdCQso=
=FhlN
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--

--===============1724348531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1724348531==--
