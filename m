From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [FAILURE] drivers/video/omap2/displays-new/connector-analog-tv.c
Date: Fri, 2 Aug 2013 13:11:17 +0300
Message-ID: <51FB85C5.8020707@ti.com>
References: <20130801191903.GC23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0546641190340137150=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130801191903.GC23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0546641190340137150==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Kgpi2W8La2O1rHcdxJ675iLWPixQSPGf6"

--Kgpi2W8La2O1rHcdxJ675iLWPixQSPGf6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/08/13 22:19, Russell King - ARM Linux wrote:
> Last couple of 4430SDP randconfig build attempts had this error in
> common:
>=20
> drivers/video/omap2/displays-new/connector-analog-tv.c: In function 'tv=
c_probe':
> drivers/video/omap2/displays-new/connector-analog-tv.c:215:19: error: '=
omap_dss_pal_timings' undeclared (first use in this function)
>=20
> #ifdef CONFIG_OMAP2_DSS_VENC
> /* Hardcoded timings for tv modes. Venc only uses these to
>  * identify the mode, and does not actually use the configs
>  * itself. However, the configs should be something that
>  * a normal monitor can also show */
> extern const struct omap_video_timings omap_dss_pal_timings;
> extern const struct omap_video_timings omap_dss_ntsc_timings;
> #endif
>=20
> # CONFIG_OMAP2_DSS_VENC is not set
>=20
> Maybe some required dependencies are missing?

Thanks, I've made a fix (below). Instead of adding a build dependency, I'=
ve
removed the dependency as there shouldn't be one in the first place.

I'll add the patch to fbdev fixes branch.

 Tomi


commit 005358c8c05998bef5e136ca7e7d6b1dc5326b49 (HEAD, 3.11-fixes/fbdev)
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Fri Aug 2 10:15:01 2013 +0300

    OMAPDSS: analog-tv-connector: compile fix
   =20
    connector-analog-tv.c uses omap_dss_pal_timings, defined in omapdss's=

    venc.c, for default timings. omap_dss_pal_timings only exists when VE=
NC
    is enabled in the kernel config, so disabling VENC breaks
    omap_dss_pal_timings connector-analog-tv compilation.
   =20
    Instead of adding dependency to VENC, add internal default timings to=

    the connector driver, because the connector driver should not depend =
on
    VENC, and it can be used with any other analog TV encoder.
   =20
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c b/dri=
vers/video/omap2/displays-new/connector-analog-tv.c
index 5338f36..1b60698 100644
--- a/drivers/video/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
@@ -28,6 +28,20 @@ struct panel_drv_data {
 	bool invert_polarity;
 };
=20
+static const struct omap_video_timings tvc_pal_timings =3D {
+	.x_res		=3D 720,
+	.y_res		=3D 574,
+	.pixel_clock	=3D 13500,
+	.hsw		=3D 64,
+	.hfp		=3D 12,
+	.hbp		=3D 68,
+	.vsw		=3D 5,
+	.vfp		=3D 5,
+	.vbp		=3D 41,
+
+	.interlace	=3D true,
+};
+
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
=20
 static int tvc_connect(struct omap_dss_device *dssdev)
@@ -212,14 +226,14 @@ static int tvc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
=20
-	ddata->timings =3D omap_dss_pal_timings;
+	ddata->timings =3D tvc_pal_timings;
=20
 	dssdev =3D &ddata->dssdev;
 	dssdev->driver =3D &tvc_driver;
 	dssdev->dev =3D &pdev->dev;
 	dssdev->type =3D OMAP_DISPLAY_TYPE_VENC;
 	dssdev->owner =3D THIS_MODULE;
-	dssdev->panel.timings =3D omap_dss_pal_timings;
+	dssdev->panel.timings =3D tvc_pal_timings;
=20
 	r =3D omapdss_register_display(dssdev);
 	if (r) {



--Kgpi2W8La2O1rHcdxJ675iLWPixQSPGf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+4XFAAoJEPo9qoy8lh7132UP+wfTiY9MZMwxs+qZkN4Eu9sH
8jmr5hqqWGRBsrlVJbVzEJNp5uslkugebclFdfzP1KMPKumdVuXNQnBEofT9m8g9
ls8c03DkhExZWvQ+PlBIsEo51SJk+u6PY6zbnWVo7u9XKmUqsdoCDIuOYxE5G3HD
RKKX2nHfDbu5ZsbbLwGYv1YnVTX66JNVVdo91y79YN8CdGQpNd96K51ujnYmuZgS
3h2r9xHpN4E0DzZ/xgOJ5MwA65/EHJ/g/GlxtxySyguIOWEqmKgx5O3CNj4FOgpl
XA2cY9WjTUzXpBzoQyvToYzDv7nPbZ337ks2qutdOSO0SdDhS1Ktrd6232rvAYpI
79z0pdR1c5Gbg99UhMpca0pMrgtERFcTKFQARadyyuWFFoydbZ9RHy+DY2ablWRC
kCiVQRzfa2iIH49jA77YaUunMRUt6/Gzsi78fLu5U0daIP6HcAYsMY9OkQ6tF/0g
BaTSZkzAX9L6hJskZ/73FoQRHo7BP9K9khw3jMVII59rYAAsXyaNZ9e5VuQvgh7N
L5h5o1Q9mri4AN/ZX4aBlXcWKLE2cb55Qdy4F0HHgrXM9gXALlfAizPkstpWHPNL
MZWWqwVEr4hmah19rRUC6yduEqX1a4xawwbWKglcSlm/rc9a+mhutmbgDKVQtvpb
3NKXf1pISok2oqtD9V4/
=jBdP
-----END PGP SIGNATURE-----

--Kgpi2W8La2O1rHcdxJ675iLWPixQSPGf6--


--===============0546641190340137150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0546641190340137150==--
