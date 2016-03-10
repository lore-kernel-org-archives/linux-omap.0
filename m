From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/6] ALSA: pcm: add IEC958 channel status helper for
 hw_params
Date: Thu, 10 Mar 2016 12:24:07 +0700
Message-ID: <20160310052407.GL3898@sirena.org.uk>
References: <cover.1457465383.git.jsarha@ti.com>
 <3d9fbdac702b93742841221e3e8d2468a3d18f12.1457465383.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410407889=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <3d9fbdac702b93742841221e3e8d2468a3d18f12.1457465383.git.jsarha@ti.com>
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


--===============1410407889==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2016 at 10:14:25PM +0200, Jyri Sarha wrote:
> Add IEC958 channel status helper that gets the audio properties from
> snd_pcm_hw_params instead of snd_pcm_runtime. This is needed to
> produce the channel status bits already in audio stream configuration
> phase.

Takashi, are you OK with this one?

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4QTxAAoJECTWi3JdVIfQLWAH/2FZ08qtvMqhvuRBc2aFaq2v
K6QQXxBCw4Ipy0ZshaZoADsM9dieZVeMppUyG6jm2/gt4e9zlqcQ8f2mseuB2XwV
BTaiAgm8SCi/T1W70tIQ5ZyCEZu6lhHoOIB8XAskN/qJxd1tSdf3BqEdYfoaFMX2
aMp+BigFdRHYRh1M62b8FDR5SUSCZ1J9tN77X2s9dWgFaUNoXRsJcGPr8E8OegTu
qUgBcO9ZAZh9Rsx3+tp0w9vX++XAbniIW3Zxl7A+BnvowOMsj1kZcCZuLeRNeFPI
aBuOG71ffyDHcy1y/6FWqTV2me2jl8utjAywldZflshtCNwKW2gIvOtvaUqLiUw=
=8RvK
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--

--===============1410407889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1410407889==--
