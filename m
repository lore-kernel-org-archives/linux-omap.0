From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] nokia n900: update dts with camera support
Date: Wed, 16 Aug 2017 00:03:49 +0200
Message-ID: <20170815220349.GA15441@amd>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I understand Tony already applied this one. I'd have a few comments below,
> could you address them in another patch, please?

Yes.

> > +	rear_camera: camera@0 {
> > +		compatible =3D "linux,camera";
> > +
> > +		module {
> > +			model =3D "TCM8341MD";
> > +			sensor =3D <&cam1>;
> > +		};
> > +	};
>=20
> There's no reference to rear_camera. I understand that this represents the
> camera module but as we don't have any documented way to describe camera
> modules (nor we have really discussed the matter), this should be removed
> for now.
>=20
> Perhaps later on, but I be it'd look quite different.

Ok, this is easy.

> > +				bus-type =3D <3>; /* CCP2 */
> > +				clock-lanes =3D <1>;
> > +				data-lanes =3D <0>;
> > +				lane-polarity =3D <0 0>;
> > +				clock-inv =3D <0>;
> > +				/* Select strobe =3D <1> for back camera, <0> for front camera */
> > +				strobe =3D <1>;
> > +				crc =3D <0>;
>=20
> crc is not a documented binding in video-interfaces.txt. Same for
> clock-inv. clock-inv is used by v4l2-fwnode.c already. Describing both in
> video-interfaces.txt would certainly make sense though, as well as adding
> support for crc in CCP2 to V4L2 fwnode.
>=20
> Could you submit patches for that? I can do that as well but it'll probab=
ly
> take some days at least.

Ok, no longer that easy. But see below, something like that?

Could you suggest better documentation lines? I'm afraid Rob will not
like "not inverted" vs. "inverted"... would "camera sensor protects
image data of each frame with crc" be suitable?

Best regards,

Signed-off-by: Pavel Machek <pavel@ucw.cz>

									Pavel

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b=
/Documentation/devicetree/bindings/media/video-interfaces.txt
index 852041a..aade681 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.txt
+++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
@@ -119,6 +119,8 @@ Optional endpoint properties
   as 0 (normal). This property is valid for serial busses only.
 - strobe: Whether the clock signal is used as clock (0) or strobe (1). Used
   with CCP2, for instance.
+- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 - invert=
ed
+- crc: crc is in use
=20
 Example
 -------
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index b1be53d..0c1ef5c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -144,15 +144,6 @@
 		io-channel-names =3D "temp", "bsi", "vbat";
 	};
=20
-	rear_camera: camera@0 {
-		compatible =3D "linux,camera";
-
-		module {
-			model =3D "TCM8341MD";
-			sensor =3D <&cam1>;
-		};
-	};
-
 	pwm9: dmtimer-pwm {
 		compatible =3D "ti,omap-dmtimer-pwm";
 		#pwm-cells =3D <3>;
@@ -192,7 +183,7 @@
 				clock-inv =3D <0>;
 				/* Select strobe =3D <1> for back camera, <0> for front camera */
 				strobe =3D <1>;
-				crc =3D <0>;
+				crc =3D <1>;
 			};
 		};
 	};
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform=
/omap3isp/isp.c
index 6cb1f04..3e17d72 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -2098,12 +2098,12 @@ static int isp_fwnode_parse(struct device *dev, str=
uct fwnode_handle *fwnode,
=20
 			buscfg->bus.ccp2.strobe_clk_pol =3D
 				vep.bus.mipi_csi1.clock_inv;
+			buscfg->bus.ccp2.crc =3D
+				vep.bus.mipi_csi1.crc;
 			buscfg->bus.ccp2.phy_layer =3D vep.bus.mipi_csi1.strobe;
 			buscfg->bus.ccp2.ccp2_mode =3D
 				vep.bus_type =3D=3D V4L2_MBUS_CCP2;
 			buscfg->bus.ccp2.vp_clk_pol =3D 1;
-
-			buscfg->bus.ccp2.crc =3D 1;
 		} else {
 			buscfg->bus.csi2.lanecfg.clk.pos =3D
 				vep.bus.mipi_csi2.clock_lane;
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-cor=
e/v4l2-fwnode.c
index 5cd2687..ce1af2d 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -170,6 +170,9 @@ v4l2_fwnode_endpoint_parse_csi1_bus(struct fwnode_handl=
e *fwnode,
 	if (!fwnode_property_read_u32(fwnode, "clock-lanes", &v))
 		bus->clock_lane =3D v;
=20
+	if (!fwnode_property_read_u32(fwnode, "crc", &v))
+		bus->crc =3D v;
+
 	if (bus_type =3D=3D V4L2_FWNODE_BUS_TYPE_CCP2)
 		vep->bus_type =3D V4L2_MBUS_CCP2;
 	else
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index cb34dcb..eb820dc 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -66,11 +66,13 @@ struct v4l2_fwnode_bus_parallel {
  *		   index (1)
  * @data_lane: the number of the data lane
  * @clock_lane: the number of the clock lane
+ * @crc: crc is in use
  */
 struct v4l2_fwnode_bus_mipi_csi1 {
 	bool clock_inv;
 	bool strobe;
 	bool lane_polarity[2];
+	bool crc;
 	unsigned char data_lane;
 	unsigned char clock_lane;
 };
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmTb8UACgkQMOfwapXb+vJVOACcD4MkdwbfYvETG0g3DOg1C6sd
/70An2IGgFx5KCb0nrGvHuAuBHpIYHln
=Ekbo
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
