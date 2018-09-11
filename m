From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/3] mfd: ti-lmu: use managed resource for everything
Date: Tue, 11 Sep 2018 23:03:44 +0200
Message-ID: <20180911210344.GB32497@amd>
References: <20180911210133.GA32497@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911210133.GA32497@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, lee.jones@linaro.org, dmurphy@ti.com
List-Id: linux-omap@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This replaces all remaining unmanaged resources with device
managed ones, so that the remove function is no longer needed.
This makes the code slightly shorter and fixes two problems:
   =20
 1. The hardware is disabled after the child devices have
    been removed. Previously there was a potential race
    condition.
 2. The hardware is disabled when mfd_add_devices fails
    during probe.
   =20
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index e14cb9f..2ee09d0 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -47,8 +47,9 @@ static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_l=
mu_id id)
 	return 0;
 }
=20
-static void ti_lmu_disable_hw(struct ti_lmu *lmu)
+static void ti_lmu_disable_hw(void *data)
 {
+	struct ti_lmu *lmu =3D data;
 	if (lmu->en_gpio)
 		gpiod_set_value(lmu->en_gpio, 0);
 }
@@ -205,6 +206,10 @@ static int ti_lmu_probe(struct i2c_client *cl, const s=
truct i2c_device_id *id)
 	if (ret)
 		return ret;
=20
+	ret =3D devm_add_action_or_reset(dev, ti_lmu_disable_hw, lmu);
+	if (ret)
+		return ret;
+
 	/*
 	 * Fault circuit(open/short) can be detected by ti-lmu-fault-monitor.
 	 * After fault detection is done, some devices should re-initialize
@@ -214,17 +219,8 @@ static int ti_lmu_probe(struct i2c_client *cl, const s=
truct i2c_device_id *id)
=20
 	i2c_set_clientdata(cl, lmu);
=20
-	return mfd_add_devices(lmu->dev, 0, data->cells,
-			       data->num_cells, NULL, 0, NULL);
-}
-
-static int ti_lmu_remove(struct i2c_client *cl)
-{
-	struct ti_lmu *lmu =3D i2c_get_clientdata(cl);
-
-	ti_lmu_disable_hw(lmu);
-	mfd_remove_devices(lmu->dev);
-	return 0;
+	return devm_mfd_add_devices(lmu->dev, 0, data->cells,
+				    data->num_cells, NULL, 0, NULL);
 }
=20
 static const struct i2c_device_id ti_lmu_ids[] =3D {
@@ -240,7 +236,6 @@ MODULE_DEVICE_TABLE(i2c, ti_lmu_ids);
=20
 static struct i2c_driver ti_lmu_driver =3D {
 	.probe =3D ti_lmu_probe,
-	.remove =3D ti_lmu_remove,
 	.driver =3D {
 		.name =3D "ti-lmu",
 		.of_match_table =3D ti_lmu_of_match,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluYLbAACgkQMOfwapXb+vKMAQCfR+GVYzamvf2F0vghbkpm7URy
BcgAnRUykwzhF6Um2FGgMV4D0r0WVQ4U
=iER6
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
