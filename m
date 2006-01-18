From: <Mikko.Soikkala@Tietoenator.com>
Subject: RE: [PATCH] Convert touchscreen to input_allocate_device
Date: Wed, 18 Jan 2006 11:34:03 +0200
Message-ID: <890E52023811004CB455C1B7C433BA101A8B29@dino.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: komal_shah802003@yahoo.com, dirk.behme@de.bosch.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Komal Shah [mailto:komal_shah802003@yahoo.com]
>=20
> Not good enough.
>=20
> 1. Need to free the irq, you just got before this code.
> 2. Need to call ts_omap.dev->remove() to match _probe() for the
> corresponding platform before you return -ENOMEM.>=20

How about if we move the allocation and check to the beginning of the
probe function? Then the return shouldn't cause problems?

Mikko

--

diff -Naur linux-2.6.15-omap2/drivers/input/touchscreen/omap/omap_ts.c
linux-2.6.15-omap2-tsfix/drivers/input/touchscreen/omap/omap_ts.c
--- linux-2.6.15-omap2/drivers/input/touchscreen/omap/omap_ts.c
2006-01-17 14:39:49.000000000 +0200
+++ linux-2.6.15-omap2-tsfix/drivers/input/touchscreen/omap/omap_ts.c
2006-01-18 11:08:42.447581656 +0200
@@ -133,6 +133,10 @@
 	int status =3D -ENODEV;
=20
 	memset(&ts_omap, 0, sizeof(ts_omap));
+	ts_omap.inputdevice =3D input_allocate_device();
+	if (!ts_omap.inputdevice)
+		return -ENOMEM;
+
 	spin_lock_init(&ts_omap.lock);
=20
 	for (i =3D 0; i < ARRAY_SIZE(ts_devs); i++) {
@@ -167,7 +171,6 @@
 		return -EINVAL;
 	}
=20
-	ts_omap.inputdevice =3D input_allocate_device();
 	ts_omap.inputdevice->name =3D OMAP_TS_NAME;
 	ts_omap.inputdevice->dev =3D &pdev->dev;
 	ts_omap.inputdevice->evbit[0] =3D BIT(EV_KEY) | BIT(EV_ABS);=20
