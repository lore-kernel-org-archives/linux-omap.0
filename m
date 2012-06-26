From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 15:03:33 +0300
Message-ID: <1340712213.24530.21.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	 <1340628094.3395.63.camel@deskari>
	 <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	 <1340632161.3395.100.camel@deskari>
	 <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	 <1340695166.2093.22.camel@lappyti>
	 <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	 <1340701660.24530.17.camel@deskari>
	 <CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wOob5e3g/4W3l9hX3cK8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46024 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752046Ab2FZMDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 08:03:39 -0400
Received: by lbbgo11 with SMTP id go11so8571710lbb.31
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 05:03:36 -0700 (PDT)
In-Reply-To: <CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-wOob5e3g/4W3l9hX3cK8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 15:27 +0530, Jassi Brar wrote:

> Seems similar, but I only tested OMAP4 HDMI.

Would something like this one below work for you? It fixes the issues on
my overo board.

Instead of using omapdss device's suspend/resume callbacks, this one
uses PM notifier calls which happen before suspend and after resume.

I still think the suspend handling is wrong, omapdss shouldn't be
enabling and disabling panel devices like that, but this one should
remove the biggest issues with the current suspend method.

 Tomi

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.=
c
index 5066eee..c35a248 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
=20
 #include <video/omapdss.h>
=20
@@ -201,6 +202,30 @@ int dss_debugfs_create_file(const char *name, void (*w=
rite)(struct seq_file *))
 #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
=20
 /* PLATFORM DEVICE */
+static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, vo=
id *d)
+{
+	DSSDBG("pm notif %lu\n", v);
+
+	switch (v)
+	{
+	case PM_SUSPEND_PREPARE:
+		DSSDBG("suspending displays\n");
+		return dss_suspend_all_devices();
+
+	case PM_POST_SUSPEND:
+		DSSDBG("resuming displays\n");
+		return dss_resume_all_devices();
+
+	default:
+		return 0;
+	}
+}
+
+static struct notifier_block omap_dss_pm_notif_block =3D
+{
+	.notifier_call =3D omap_dss_pm_notif,
+};
+
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata =3D pdev->dev.platform_data;
@@ -224,6 +249,8 @@ static int __init omap_dss_probe(struct platform_device=
 *pdev)
 	else if (pdata->default_device)
 		core.default_display_name =3D pdata->default_device->name;
=20
+	register_pm_notifier(&omap_dss_pm_notif_block);
+
 	return 0;
=20
 err_debugfs:
@@ -233,6 +260,8 @@ err_debugfs:
=20
 static int omap_dss_remove(struct platform_device *pdev)
 {
+	unregister_pm_notifier(&omap_dss_pm_notif_block);
+
 	dss_uninitialize_debugfs();
=20
 	dss_uninit_overlays(pdev);
@@ -247,25 +276,9 @@ static void omap_dss_shutdown(struct platform_device *=
pdev)
 	dss_disable_all_devices();
 }
=20
-static int omap_dss_suspend(struct platform_device *pdev, pm_message_t sta=
te)
-{
-	DSSDBG("suspend %d\n", state.event);
-
-	return dss_suspend_all_devices();
-}
-
-static int omap_dss_resume(struct platform_device *pdev)
-{
-	DSSDBG("resume\n");
-
-	return dss_resume_all_devices();
-}
-
 static struct platform_driver omap_dss_driver =3D {
 	.remove         =3D omap_dss_remove,
 	.shutdown	=3D omap_dss_shutdown,
-	.suspend	=3D omap_dss_suspend,
-	.resume		=3D omap_dss_resume,
 	.driver         =3D {
 		.name   =3D "omapdss",
 		.owner  =3D THIS_MODULE,


--=-wOob5e3g/4W3l9hX3cK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6aUVAAoJEPo9qoy8lh71UqgP/1HUJB13m/k3gSoPH56hi7rZ
T4kOhcewwl/bfcc9gdbPwd/HihrX9ncDy6jJ9VX6+8Xl3hnM9cG2p9LJ8PzcR5wt
A83VIsDmszSxu6zwkD2fDiOMmlhxHeMBoKQkEs+qYVWYGAPdcugRRvm22wfmCPzD
d3tJlCrp9TUu8wJWFr0EQQq9Js1v8pDJ51nxRMFbr7BeK5Ti1iPKVvTza+Y5Xzuc
eno8zD9a1ov8Z0lXdAao98zdQZmB2FwPhRnVcg3jJG9RsiMR2Ynw1unFf8l2OhaV
9BZ57FOiA667ScfBf3nJtboxsAdqg0U6OFtsfYCGCrAEDdPUaez41KZh7Y7/REe5
o3Qze99MgCOyYumxvkY0KJfMfuxOS+B4p9r6CjAeF4/cvJrS9sg6tyqYN6w173af
Y+/9zhObeg1Ma9ca3tjmdiDc6zCDaDtetCH8AXq0VtxkHTTmwE2+aRZQ+iFzG5Xj
P/GWJ+RgKjg2KEzV62QIsQcy82y2ap636n3fwia+VaybEwThGHxN+FDKNdVL+uTe
BclZ3tRQQKTyfL3K4yQDN9ygmzwRXtnzRIPu3Z3TyR28xFuScgOAYvVTxSw0Ieyg
iSq1zwZqYqA9NTD4r9YpeBQIk4ojvOe1/2Txuqk+7HfBPU1qXCvWh20MVcDLngmF
dpDzYZF1rfAyGaKJFv2P
=N7pl
-----END PGP SIGNATURE-----

--=-wOob5e3g/4W3l9hX3cK8--

