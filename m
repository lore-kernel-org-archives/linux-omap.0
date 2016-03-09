From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 0/6] Implement generic ASoC HDMI codec and use it in
 tda998x
Date: Wed, 9 Mar 2016 10:27:08 +0700
Message-ID: <20160309032708.GF3898@sirena.org.uk>
References: <cover.1457465383.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067412802=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1457465383.git.jsarha@ti.com>
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


--===============2067412802==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2016 at 10:14:24PM +0200, Jyri Sarha wrote:
> There is currently two other patch series[1][2] that depend on the
> three first (ALSA-) patches of this series. It would be nice to get at
> least those three applied sooner rather than later, so please tell me
> if I can do anything to get those in.

It would be good if the people working on those other series could
review this code then - there's no Reviwed-by or Acked-by on those
patches or anything like that.  This is what I mean about a lack of
visible collaboration, there is no real enagagment that can be seen
here.

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW35gHAAoJECTWi3JdVIfQv8kH/2idHRO+3i5Rr+AVGtuC1279
Z4SHO+DEGj41H3ezrjsxEnZArXdhYVmP3eVkedbmzj3k0yHrocsMUXSptUR5RXym
l4hwDeQi+JiORkDs7S7rabwIbzAbdoVUCIA/HUsoXjXbntlWtDtXgKxXpx6uoZxm
WnEIMWg/muSantBeUtkqgxQw+x1VB1Wh74woLLoWju13RNULTiQ6SZMsuJnDO3eX
cII2hrJFBf2QfHcT2XqOjXsf8zHxK9EXa1uC0NfEejiQwOS0HovzM+OaU11NL1Jl
qfKmmrg4+uPuKMJMy4Xmm9YdhEHKmXe/SmUiTAVNjUjlZPHS6Hf0bT+YZ2y2QJ4=
=pT2X
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--

--===============2067412802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2067412802==--
