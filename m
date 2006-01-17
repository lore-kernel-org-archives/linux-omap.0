From: <Mikko.Soikkala@Tietoenator.com>
Subject: RE: [PATCH] Convert touchscreen to input_allocate_device
Date: Tue, 17 Jan 2006 15:24:42 +0200
Message-ID: <890E52023811004CB455C1B7C433BA101A8B28@dino.eu.tieto.com>
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
To: dirk.behme@de.bosch.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Dirk Behme [mailto:dirk.behme@de.bosch.com]
>=20
> Mikko.Soikkala@Tietoenator.com wrote:
> > Hi
> >
> > Shouldn't there be a check after input_allocate_device() if the
> > allocation fails? At least other touchscreen drivers seem to return
> > -ENOMEM in this case.
>=20
> Sounds good to me. Can you send a patch?

I'm still learning how to create and submit patches, but hopefully this
does the trick.

Mikko

--

diff -Naur linux-2.6.15-omap2/drivers/input/touchscreen/omap/omap_ts.c
linux-2.6.15-omap2-tsfix/drivers/input/touchscreen/omap/omap_ts.c
--- linux-2.6.15-omap2/drivers/input/touchscreen/omap/omap_ts.c
2006-01-17 14:39:49.000000000 +0200
+++ linux-2.6.15-omap2-tsfix/drivers/input/touchscreen/omap/omap_ts.c
2006-01-17 14:47:48.000000000 +0200
@@ -168,6 +168,9 @@
 	}
=20
 	ts_omap.inputdevice =3D input_allocate_device();
+	if (!ts_omap.inputdevice)
+		return -ENOMEM;
+
 	ts_omap.inputdevice->name =3D OMAP_TS_NAME;
 	ts_omap.inputdevice->dev =3D &pdev->dev;
 	ts_omap.inputdevice->evbit[0] =3D BIT(EV_KEY) | BIT(EV_ABS);
