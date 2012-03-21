From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] OMAP DSS for v3.4
Date: Wed, 21 Mar 2012 14:39:13 +0200
Message-ID: <1332333553.2236.8.camel@deskari>
References: <1332154865.2144.57.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3ClahHL60HEGQTJVEckv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57979 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757939Ab2CUMjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 08:39:19 -0400
Received: by mail-lb0-f176.google.com with SMTP id m11so1083615lbo.35
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 05:39:16 -0700 (PDT)
In-Reply-To: <1332154865.2144.57.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>


--=-3ClahHL60HEGQTJVEckv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, 2012-03-19 at 13:01 +0200, Tomi Valkeinen wrote:
> Hi Florian, Arnd,
>=20
> Here are the changes for OMAP DSS driver for v3.4.
>=20
> There's an issue with the dss driver that appears on arm-soc/for-next
> branch, which I'm still solving
> (http://marc.info/?l=3Dlinux-omap&m=3D133214966902577&w=3D2). I hope to g=
et
> fix for that ready and merged for -rc1, but I'm not sure if I can make
> it in time, so I wanted to sent this pull request already.

Below is a patch that fixes the issue I mentioned above. So briefly, the
problem is that omapdss's driver registration is broken, and it has been
working so far by luck. arm-soc tree contains a patch which changes how
arch/arm/plat-omap/omap_device.c creates the devices, and this causes
the (broken) omapdss driver registration to break, causing a deadlock.

The patch below makes the omapdss driver registration saner. The patch
works with and without the omap_device.c patch from arm-soc.

Florian, if you didn't send the pull request yet, this would be a good
patch to add to it. We can, of course, get it in for -rc2, but avoiding
a kernel deadlock on -rc1 would be nice.

 Tomi


=46rom 849c07b1fd3d9f23e8ed94436b6221f8652462c0 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 19 Mar 2012 15:05:02 +0200
Subject: [PATCH] OMAPDSS: register dss drivers in module init

We do the dss driver registration in a rather strange way: we have the
higher level omapdss driver, and we use that driver's probe function to
register the drivers for the rest of the dss devices.

There doesn't seem to be any reason for that, and additionally the
soon-to-be-merged patch "ARM: OMAP: omap_device: remove
omap_device_parent" will break omapdss initialization with the current
registration model.

This patch changes the registration for all drivers to happen at the
same place, in the init of the module.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |  135 +++++++++++++++++++++++-------------=
----
 1 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.=
c
index 8613f86..e8a1207 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -183,42 +183,6 @@ static int omap_dss_probe(struct platform_device *pdev=
)
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
=20
-	r =3D dss_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize DSS platform driver\n");
-		goto err_dss;
-	}
-
-	r =3D dispc_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize dispc platform driver\n");
-		goto err_dispc;
-	}
-
-	r =3D rfbi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize rfbi platform driver\n");
-		goto err_rfbi;
-	}
-
-	r =3D venc_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize venc platform driver\n");
-		goto err_venc;
-	}
-
-	r =3D dsi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize DSI platform driver\n");
-		goto err_dsi;
-	}
-
-	r =3D hdmi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize hdmi\n");
-		goto err_hdmi;
-	}
-
 	r =3D dss_initialize_debugfs();
 	if (r)
 		goto err_debugfs;
@@ -246,18 +210,6 @@ static int omap_dss_probe(struct platform_device *pdev=
)
 err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
-	hdmi_uninit_platform_driver();
-err_hdmi:
-	dsi_uninit_platform_driver();
-err_dsi:
-	venc_uninit_platform_driver();
-err_venc:
-	dispc_uninit_platform_driver();
-err_dispc:
-	rfbi_uninit_platform_driver();
-err_rfbi:
-	dss_uninit_platform_driver();
-err_dss:
=20
 	return r;
 }
@@ -269,13 +221,6 @@ static int omap_dss_remove(struct platform_device *pde=
v)
=20
 	dss_uninitialize_debugfs();
=20
-	hdmi_uninit_platform_driver();
-	dsi_uninit_platform_driver();
-	venc_uninit_platform_driver();
-	rfbi_uninit_platform_driver();
-	dispc_uninit_platform_driver();
-	dss_uninit_platform_driver();
-
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
=20
@@ -525,6 +470,80 @@ static int omap_dss_bus_register(void)
=20
 /* INIT */
=20
+static int __init omap_dss_register_drivers(void)
+{
+	int r;
+
+	r =3D platform_driver_register(&omap_dss_driver);
+	if (r)
+		return r;
+
+	r =3D dss_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize DSS platform driver\n");
+		goto err_dss;
+	}
+
+	r =3D dispc_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize dispc platform driver\n");
+		goto err_dispc;
+	}
+
+	r =3D rfbi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize rfbi platform driver\n");
+		goto err_rfbi;
+	}
+
+	r =3D venc_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize venc platform driver\n");
+		goto err_venc;
+	}
+
+	r =3D dsi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize DSI platform driver\n");
+		goto err_dsi;
+	}
+
+	r =3D hdmi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize hdmi\n");
+		goto err_hdmi;
+	}
+
+	return 0;
+
+err_hdmi:
+	dsi_uninit_platform_driver();
+err_dsi:
+	venc_uninit_platform_driver();
+err_venc:
+	rfbi_uninit_platform_driver();
+err_rfbi:
+	dispc_uninit_platform_driver();
+err_dispc:
+	dss_uninit_platform_driver();
+err_dss:
+	platform_driver_unregister(&omap_dss_driver);
+
+	return r;
+}
+
+static void __exit omap_dss_unregister_drivers(void)
+{
+	hdmi_uninit_platform_driver();
+	dsi_uninit_platform_driver();
+	venc_uninit_platform_driver();
+	rfbi_uninit_platform_driver();
+	dispc_uninit_platform_driver();
+	dss_uninit_platform_driver();
+
+	platform_driver_unregister(&omap_dss_driver);
+}
+
 #ifdef CONFIG_OMAP2_DSS_MODULE
 static void omap_dss_bus_unregister(void)
 {
@@ -541,7 +560,7 @@ static int __init omap_dss_init(void)
 	if (r)
 		return r;
=20
-	r =3D platform_driver_register(&omap_dss_driver);
+	r =3D omap_dss_register_drivers();
 	if (r) {
 		omap_dss_bus_unregister();
 		return r;
@@ -562,7 +581,7 @@ static void __exit omap_dss_exit(void)
 		core.vdds_sdi_reg =3D NULL;
 	}
=20
-	platform_driver_unregister(&omap_dss_driver);
+	omap_dss_unregister_drivers();
=20
 	omap_dss_bus_unregister();
 }
@@ -577,7 +596,7 @@ static int __init omap_dss_init(void)
=20
 static int __init omap_dss_init2(void)
 {
-	return platform_driver_register(&omap_dss_driver);
+	return omap_dss_register_drivers();
 }
=20
 core_initcall(omap_dss_init);
--=20
1.7.4.1



--=-3ClahHL60HEGQTJVEckv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPacvtAAoJEPo9qoy8lh717xkP/3Rn5E2m/xcciWG8678bVfTK
fOV/rXXqXpY+OtQJIKDC+JdMRRWuquo+p9AHyVDWs3C719vc/0YNG/UFx9/Gpe2O
ceQOEWjHxXvdaQYIOkhzNnalA1Wv/urIo5rmH+luCWQx7Pmg7zsV8HiyR3fTiuI4
5qLmbUQtq0M/CWZlABtkAs8ud06dwICei+1Zi+51drZFhxlBXHzBh0mLwgvIMUsX
XJvXqWuJXiVWsJqyMDhIlBifmT6mAvxhv/qfjFjSN1Ccqqk8xXXwqcObzBTH6pxc
oG4BBKkz4Be/c5xEQHplnYcVyZO2KbEGaQWZTUmnZa4d4qDLIeQbjQb0LG3fsyCA
dmnwGBP7Vya717+S8Rlq8y3AskJDIXL9rg0HXKFhExysIEa+/TDehG8QUVlunKf9
EZIP1YAWHHtFNBPjnUpNUWrUGBgEDJbgT3+cwPPPKOhQVj/RtHA7hVU/N7J+QZVq
ubdau9EKgGWl0fC3JPrgbaCNdkYjA5iVz+lTfqGHcydUOQGgu2tAXxMVrLaP9nEW
qTq80pHx9COK6F44/lptNd5RD7I83wE9/ZOgyIp0uraBmQYEIsI055stlskL0Mh5
bQF7pHq6YoDX+pOMhuPiqejeBUNd5Crjha5flJcstAbNy+fqIugdjmtnRzD420uu
BeB4ER2nQgwWJ5EJ6U/U
=BJCg
-----END PGP SIGNATURE-----

--=-3ClahHL60HEGQTJVEckv--

