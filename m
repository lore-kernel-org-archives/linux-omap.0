From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Mon, 30 Oct 2017 08:51:35 +0100
Message-ID: <20171030075135.GB32041@amd>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026093115.4bc6ctxjx72ng7ld@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I got "uncompressing Linux 4.13" on serial console now, debug LEDs
> > blinking, and if I use a flashlight, I see output on the screen, too.
> >=20
> > (What do I need to do to get the backlight working?)
>=20
> Glad you got it working :) For backlight you can add this
> in drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c:
>=20
> add the following code at the end of dsicm_probe:
>=20
> -----------------------------------------------------------
> mutex_unlock(&ddata->lock);
> mutex_lock(&ddata->lock);
> ddata->in->ops.dsi->bus_lock(ddata->in);
> r =3D dsicm_wake_up(ddata);
> if (!r)
>     r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 100);
> ddata->in->ops.dsi->bus_unlock(ddata->in);
> mutex_unlock(&ddata->lock);
> -----------------------------------------------------------

That one did not work; but after some help from Filip, this did:

Best regards,
									Pavel

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/=
drm/omapdrm/displays/panel-dsi-cm.c
index b5ea8e5..2cb74cc 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -385,7 +385,7 @@ static int dsicm_bl_update_status(struct backlight_devi=
ce *dev)
=20
 		r =3D dsicm_wake_up(ddata);
 		if (!r)
-			r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, level);
+			r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff /* level */);
=20
 		in->ops.dsi->bus_unlock(in);
 	}


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAln22gcACgkQMOfwapXb+vIbawCdHlFvo8EXC1EDhB3z0vkwNJ5I
2vYAoLcQJc7lYgPWbKrCKYp1SpKRVLlW
=hT4V
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
