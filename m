From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Mon, 19 Mar 2012 15:59:10 +0200
Message-ID: <1332165550.2144.85.camel@deskari>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk>
	 <20120317004706.GF7276@atomide.com>
	 <20120317211505.GA4720@n2100.arm.linux.org.uk>
	 <1332149601.2144.15.camel@deskari>
	 <20120319123006.GC16389@n2100.arm.linux.org.uk>
	 <1332160864.2144.66.camel@deskari>  <1332162163.2144.77.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-En6vUvCL6T/ttrbEgCOZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45000 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030222Ab2CSOFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 10:05:40 -0400
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so6150183laa.24
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 07:05:37 -0700 (PDT)
In-Reply-To: <1332162163.2144.77.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>


--=-En6vUvCL6T/ttrbEgCOZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 15:02 +0200, Tomi Valkeinen wrote:

> I'll see if I can make a single patch that fixes the issue. The patch
> series I mentioned earlier does lots of things, but I think just moving
> the driver registration out of the probe function should be enough to
> avoid the problem.

Here's a patch that fixes the issue for me. Tested on OMAP4 Blaze with
omapdss both as module and built-in. I'll queue this up after testing it
a bit more.

This still leaves the issue of initialization order, but I think that's
not a big issue at the moment. It doesn't happen in practice, as the
current driver framework will probe the devices at driver registration
time. I'll fix this for the next merge window.

 Tomi


=46rom 39ff2ded6c79d40d09597a56ddcf584470c6e699 Mon Sep 17 00:00:00 2001
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



--=-En6vUvCL6T/ttrbEgCOZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPZzuuAAoJEPo9qoy8lh713YIQAItOGJidOKoE4tijeSnHnJ0K
7UlVSDtY9TJQHgoYoAgMlM3Xz4N2yClsBJEBOAy5DY4eSemsoxv4l9qn4z2eGSvM
rseLN69xuiRZTT2I6exzv9IIT+6wDx7gudt1sPRuHJuIWMuhGkzP1wYAr+oIER8r
Q846nkPPQTQAoBlJBxUXCYWX4KphfKboLt/UTgFE4aEVUqD+7o0XvavgeOazyXWt
cNNokSMGEjxTHi+pAPhtkYfxR4rGcQ4ayzm9PJAujFGiiUC9AQiXDx511J5ub3pe
ZzN9L46B19dlInOtEVQN+/OwxmDnCsAvdQMy2NDo+G7gosfDqSJjJF5hMdWQMrzh
NB/O87NB2iyXoeNm2Wh9Qzk0x1F2im0mk8fB25QvfDtMrrztWFiu4vtitqgdBJwT
MZ6WiqyykT7+y50FPMSOWKktQ5+ozqyjJ20D90eQhF5zA/wJtAo5dvAk4gMolZx6
6lkWu2bXW6OsvWUr9UdcvmOSQ/4va2n9HF50KljALusyOQFZ3hNa5Jaunxm0v7hf
CN1UufWqTpsXpnTJbhQ909AC97RilRCJLP8LNDs/NeOopJ/0fhkIFi9v5SHb+6oO
b6EGyaq6uZX1YYpc222RljBjGDABh6yu8IdFD5IDZF2k50vabb852yRUELsKAbtw
lykIUAVJfhImDCQx0oKC
=sTep
-----END PGP SIGNATURE-----

--=-En6vUvCL6T/ttrbEgCOZ--

