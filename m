From: Pavel Machek <pavel@ucw.cz>
Subject: Backlight on Nokia N900 was Re: 4.13 (and probably all recent)
 kernels refuse to boot on one Nokia N950, work or another
Date: Fri, 27 Oct 2017 22:27:43 +0200
Message-ID: <20171027202743.GA17874@amd>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4217884444313908400=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171026093115.4bc6ctxjx72ng7ld@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, martijn@brixit.nl, filip.matijevic.pz@gmail.com, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============4217884444313908400==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
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

Ok, I tried that, and did not help. I also tried removing first
mutex_unlock(), since that's unbalanced and strange. Did not work. So
I commented it out with #if 0, and tried more hacks, but no luck :-(.

(I still see the display.. but no backlight so reading it is
=2E. difficult.)

Best regards,
								Pavel

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/=
drm/omapdrm/displays/panel-dsi-cm.c
index 8f74633..c0bbb42 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -668,6 +668,7 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 		goto err;
=20
 	r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff);
+	mdelay(1000);
 	if (r)
 		goto err;
=20
@@ -703,6 +704,8 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
=20
 	in->ops.dsi->enable_hs(in, ddata->channel, true);
=20
+	r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 0xff);
+
 	return 0;
 err:
 	dev_err(&ddata->pdev->dev, "error while enabling panel, issuing HW reset\=
n");
@@ -1396,6 +1399,15 @@ static int dsicm_probe(struct platform_device *pdev)
 		goto err_bl;
 	}
=20
+#if 0=09
+	mutex_lock(&ddata->lock);
+	ddata->in->ops.dsi->bus_lock(ddata->in);
+	r =3D dsicm_wake_up(ddata);
+	if (!r)
+		r =3D dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 100);
+	ddata->in->ops.dsi->bus_unlock(ddata->in);
+	mutex_unlock(&ddata->lock);
+#endif
 	return 0;
=20
 err_bl:



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnzlr8ACgkQMOfwapXb+vLJLwCgq2AOn0Ts4O0AgBf2TsWT5oWu
RdIAoJr4a0ERZaXo0OKJEMkef1Q+OBIn
=DKPW
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


--===============4217884444313908400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4217884444313908400==--
