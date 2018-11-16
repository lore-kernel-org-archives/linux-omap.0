From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv4 4/6] drm/omap: fix incorrect union usage
Date: Fri, 16 Nov 2018 23:36:16 +0100
Message-ID: <20181116223616.ojoq4qffmj2qo7gk@earth.universe>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-5-sebastian.reichel@collabora.com>
 <f64b580d-14ae-42df-34b9-a1f7c87e5f37@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njnboep25iyebnam"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f64b580d-14ae-42df-34b9-a1f7c87e5f37@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--njnboep25iyebnam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

On Fri, Nov 16, 2018 at 03:41:24PM +0200, Tomi Valkeinen wrote:
> On 16/11/18 01:06, Sebastian Reichel wrote:
> > The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
> > same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
> > only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
> > union works, it won't be NULL if dsi.set_config is set. This means
> > dsi_set_config will be called with config=3Dhdmi_mode=3Dfalse=3DNULL pa=
rameter
> > resulting in a NULL dereference. Also the dereference happens while
> > console is locked, so kernel hangs without any debug output (can be
> > avoided by fbmem's lockless_register_fb=3D1 parameter).
> >=20
> > This fixes the issue by exiting early if the output type definitely
> > has no hdmi_set operations.
> >=20
> > Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations t=
o omap_dss_device_ops")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/gpu/drm/omapdrm/omap_encoder.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/o=
mapdrm/omap_encoder.c
> > index 32bbe3a80e7d..ba0099f0644c 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_encoder.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
> > @@ -122,6 +122,14 @@ static void omap_encoder_mode_set(struct drm_encod=
er *encoder,
> > =20
> >  	dssdev =3D omap_encoder->output;
> > =20
> > +	/* The following operations access dssdev->ops->hdmi, which is a union
> > +	 * also used by DSI. This ensures, that the field does not have data
> > +	 * for DSI (or any other future output type).
> > +	 */
> > +	if (dssdev->output_type !=3D OMAP_DISPLAY_TYPE_HDMI &&
> > +	    dssdev->output_type !=3D OMAP_DISPLAY_TYPE_DVI)
>=20
> Good catch.
>=20
> Why DVI?
>=20
> I think the whole code block starting from
>=20
> /* Set the HDMI mode and HDMI infoframe if applicable. */
>=20
> to the end of the function should be inside
>=20
> if (dssdev->output_type =3D=3D OMAP_DISPLAY_TYPE_HDMI)

When I identified the issue I whitelisted DVI, since I wasn't sure
if it also has the HDMI functionality. I planned to check the code
later and then forgot about it. You are right, this should only
check for HDMI.

-- Sebastian

--njnboep25iyebnam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvvRlcACgkQ2O7X88g7
+prb9Q/9GSlbOuv987KeX8peuscQlUgXwMRfxZkPSpUKN1wlSQwXHbTr9zqt+4gP
rNcO7YzoNiJg2t+wD3gCRMKq+Q0bj67QW+qkNmbEObmkv87XeOAq7+CDedDd0Xsm
xTJfb86+hOSgKcI7pIOuQgG3WEkeKuIqNb1aKNvT4jTvu27mch5SlpXjwknqsfdq
IAlC7b6M4rA/80lzwMyucxIEJ4TP5IrwtAc07n+u2VVAyVuaecQGIaRYoXF8szd6
tK6mMOhmJDAy94lCa1aCyzHyx0NBPvgJJYnqmWVBOydB8yOukxE0jIXnSbBF+Ad5
WWHpa0aIDizAAatSuDm4UXPjrOKXaspyIaeQOHeVnL+Vl9vQHU9VYEfbBPAHc4yO
L1Tmesk1KT4bQKTYkOsKkxRpQ+17RAlAskEz8TzOvu1vYVpc4X6V4gZg4te/6cWZ
QGxLCIoCF2kjQaGPQC7f1cV7CN2SqOo/oRtuficMfL9Fn4EbkYSmlKbsRlV9MKDX
B77VP1lYPIyvVYLaHq+LdT1gqTgktJFvzN1+oCFtLTrcdxIuVP77hOml2MzHyJxs
RLkRIpQjtQUryH3tHBzrh+PE6cGDzPOlzl0JB4a6I73+FRK3yFXzS6NXU9S6+dCE
8K1iqoUbb5Xk9AyHkUynJa/JChBMF4Y1KmnN6xpHO2uPp1BFRuI=
=9+W1
-----END PGP SIGNATURE-----

--njnboep25iyebnam--
