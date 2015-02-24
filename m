From: NeilBrown <neilb@suse.de>
Subject: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Tue, 24 Feb 2015 20:37:06 +1100
Message-ID: <20150224203706.1eafa129@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/44/CbQokPf2ZVpXE4fgAtdK"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/44/CbQokPf2ZVpXE4fgAtdK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



commit 303e4697e762dc92a40405f4e4b8aac02cd0d70b
    OMAPDSS: rename display-sysfs 'name' entry

broke the xorg X server on my device as it couldn't find the display
any more.  It needs the 'name' file and now there isn't one.

That commit claims that 'name' is not compatible with i2c or spi.
i2c does register it own 'name' file, but spi does not, hence my
problem - I have an spi display.

So create a special case for i2c: add the name attribute for non-i2c
devices.

Fixes: 303e4697e762dc92a40405f4e4b8aac02cd0d70b
Signed-off-by: NeilBrown <neilb@suse.de>

--

Hi Tomi,
 I wonder if you would consider this for the next merge window (or maybe ev=
en sooner as a bug-fix).
I haven't tested it with an i2c display, but it certainly allows xorg to wo=
rk
on my spi-attached display.

Thanks,
NeilBrown


diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/video/=
fbdev/omap2/dss/display-sysfs.c
index 5a2095a98ed8..53897b743130 100644
--- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
@@ -25,6 +25,15 @@
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
=20
+#if IS_ENABLED(CONFIG_I2C)
+#include <linux/i2c.h>
+#else
+static inline int i2c_verify_client(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 #include <video/omapdss.h>
 #include "dss.h"
=20
@@ -278,6 +287,7 @@ static ssize_t display_wss_store(struct device *dev,
 }
=20
 static DEVICE_ATTR(display_name, S_IRUGO, display_name_show, NULL);
+static DEVICE_ATTR(name, S_IRUGO, display_name_show, NULL);
 static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
 		display_enabled_show, display_enabled_store);
 static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
@@ -315,6 +325,17 @@ int display_init_sysfs(struct platform_device *pdev)
 			DSSERR("failed to create sysfs files\n");
 			goto err;
 		}
+		if (!i2c_verify_client(dssdev->dev)) {
+			/*
+			 * Add 'name' file - not compatible with i2c, but
+			 * need by Xorg for other devices.
+			 */
+			r =3D sysfs_create_file(kobj, &dev_attr_name.attr);
+			if (r) {
+				DSSERR("fail to create 'name' sysfs file\n");
+				goto err;
+			}
+		}
=20
 		r =3D sysfs_create_link(&pdev->dev.kobj, kobj, dssdev->alias);
 		if (r) {
@@ -341,5 +362,7 @@ void display_uninit_sysfs(struct platform_device *pdev)
 		sysfs_remove_link(&pdev->dev.kobj, dssdev->alias);
 		sysfs_remove_files(&dssdev->dev->kobj,
 				display_sysfs_attrs);
+		sysfs_remove_file(&dssdev->dev->kobj,
+				  &dev_attr_name.attr);
 	}
 }

--Sig_/44/CbQokPf2ZVpXE4fgAtdK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVOxGQjnsnt1WYoG5AQJqMQ/+JEn27TgsjKFKBrYHuwD5PJhFJrP1BF64
v6KVETLI0uF7Tld79ajEpnK0utAX+ntm56Uw+EeJLlH7DLf4lmMD/fqvcF3wqdtS
xz9iitxD1aGwaC7kTst20GhdNjvsphh4nHdO9gR2kTH7pyfQvEuINAZZ8qa6aJI1
uvfzAgV9JQt/q47i4L+SBmTOPwpCetU/7RsqA6MCP9EzHOuI5p8L6bB8H8g/oOcF
JuV1xXDXvXYHJWDvhc7uDOx/LRt+jmOncbuA2sGws0Y9xsr7mxqBtOsWIfSYQXF9
IwaLPaEYyvRO0dLOx6JzYX7+wJvVeNoUruHc7NZR30WOmMYAEhtfE7ZRLI/zwRtr
qgcCr+ZBc5e9mcyjli6FQMd5XF1C8MzfInjwcNseh6p2XuZDG9cwkY5GPbL7P7UT
gbRvcIzibji3133SI1NTTY8AvMSdZcL6SlnTJzVISby2uCcMxc6SS9+FkI4jIAPg
TgN5tSAbVW5hrGzoLpmj5tJ3WGRetZ/mKP8YKRU6LRrXp1D4zb8CPnEZ/uV3GSrS
J5SIIETWPBeQQI5VaTLStH3ClwSLXFYyU2AyxZ2f5rsog6+DvV/mOBQxM23M0q4/
zqdjdmtu/mxDtkmPDS6x04gBwUHhWHW71qkEkWaJUK/pzCR0BbOZIGfcqQDnKeE3
W9dlZlWOOfI=
=7KUM
-----END PGP SIGNATURE-----

--Sig_/44/CbQokPf2ZVpXE4fgAtdK--
