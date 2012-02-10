From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/3] ASoC: twl6040: Remove dependency on
 twl4030 from Kconfig
Date: Fri, 10 Feb 2012 11:10:35 +0000
Message-ID: <20120210111035.GD3056@opensource.wolfsonmicro.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
	<1328868018-24668-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2600201776678922194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328868018-24668-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2600201776678922194==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 12:00:18PM +0200, Peter Ujfalusi wrote:
> twl6040 no longer needs twl4030.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

This should go via whatever path the first two patches go.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNPskAAoJEBus8iNuMP3dWhUP/j833HfDyb3ugioLFPhn8DcI
wSbdZXaNFM0X53zgGsRZ5oE0WhrWJOpVoR3EA+6ITPKLsjw2q8TPp9hkxwjjJzPZ
SbaEbDX5BHNKieuqwQfU439t0DogvPJW83UjdhRrSHAOG+BXbLOBLjfuXokIuEOE
ULp7qILEab8BKv3JTmZSoYR3wt+ZsBzDMvw2T8+lHtpRfG3F/YaQgkshxSrABQv2
jUcVqDGOQtzR7mGl90BJQn8lFql7JSuIakcX6uiGN4cXln6j6PLiGLQIwXRr35Fn
f7GiZdItJWyYgl1FKiZ4OUltGmSaTo1B8TNxH4tOQmAm5mkr0cgCq8cupH8pZ+wl
rJrClaLXKp0/F7mrd13Q9kkyVlrJi/gQ53yvUX7r8nwrZHXCThqciNsr1eMK6ULt
FndKibhLUGYlY0csSO087hz2XpF7JCg4g19aVOos9Sfo4B76fA3IdHv8csDM9sFc
/ZMTnmtJtKYVlcG5C4/GQRvQJJRhHnt9aRwkk/Ofz+eer43KvnGuq6Jq4/4yE/xU
862acfsXH+HBpG7ipvm7V3ILEXBkPESJLI/a/iY/NJYzwTi3qEs813GXJWpVPZCZ
jxeDNlZrBTwzUCGexCw4NwQKdmYHkirhoh1s2Rgl2/dEWZ+aIygqQLGUWxb51HwR
8IIcvVkEBbclD6ee/mVV
=z156
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--===============2600201776678922194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2600201776678922194==--
