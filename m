From: Pavel Machek <pavel@ucw.cz>
Subject: regression v4.16 on Nokia N900:/dev/input/event6 aka
 AV Jack support disappeared
Date: Sat, 24 Feb 2018 22:46:17 +0100
Message-ID: <20180224214617.GA22619@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7166571092126423223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, afd@ti.com
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org


--===============7166571092126423223==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In v4.16, AV jack support disappeared.

This one is suspect:

commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057
Author: Andrew F. Davis <afd@ti.com>
Date:   Wed Nov 29 11:13:59 2017 -0600

    ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

    The correct DT property for specifying a GPIO used for reset
        is "reset-gpios", fix this here.

    Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X
    support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

How was it tested? It reverts polarity of reset pin, but
sound/soc/codecs/tlv320aic3x.c treats those as aliases:

 ret =3D of_get_named_gpio(np, "reset-gpios", 0);
 if (ret >=3D 0) {
    aic3x->gpio_reset =3D ret;
 } else {
 ret =3D of_get_named_gpio(np, "gpio-reset", 0);
 if (ret > 0) {
    dev_warn(&i2c->dev, "Using deprecated property \"gpio-r\eset\", please =
update your DT");
    aic3x->gpio_reset =3D ret;


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqR3SkACgkQMOfwapXb+vKArwCfU1sALPGd+Be9AcXOY3fYdiSn
7T4AnidKF80FJYtN+KRr7C4tHi9OsrYB
=tU/B
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--===============7166571092126423223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7166571092126423223==--
