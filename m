From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] w1: omap-hdq: support device probing with device-tree.
Date: Sat, 8 Nov 2014 10:30:32 +1100
Message-ID: <20141108103032.5426db7a@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/7ddOIc1J6FJuK0j4OzOtqRn"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Evgeniy Polyakov <zbr-i6C2adt8DTjR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/7ddOIc1J6FJuK0j4OzOtqRn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



This driver has no 'compatible' string and so is not found when
using device-tree.

Add one with value to match
		hdqw1w: 1w@480b2000 {
device in omap3.dtsi.

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

diff --git a/Documentation/devicetree/bindings/w1/omap-hdq.txt b/Documentat=
ion/devicetree/bindings/w1/omap-hdq.txt
new file mode 100644
index 000000000000..fef794741bd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/omap-hdq.txt
@@ -0,0 +1,17 @@
+* OMAP HDQ One wire bus master controller
+
+Required properties:
+- compatible : should be "ti,omap3-1w"
+- reg : Address and length of the register set for the device
+- interrupts : interrupt line.
+- ti,hwmods : "hdq1w"
+
+Example:
+
+- From omap3.dtsi
+  hdqw1w: 1w@480b2000 {
+	compatible =3D "ti,omap3-1w";
+	reg =3D <0x480b2000 0x1000>;
+	interrupts =3D <58>;
+	ti,hwmods =3D "hdq1w";
+  };
diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 9900e8ec7393..03321d6a2684 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -72,11 +72,18 @@ struct hdq_data {
 static int omap_hdq_probe(struct platform_device *pdev);
 static int omap_hdq_remove(struct platform_device *pdev);
=20
+static struct of_device_id omap_hdq_dt_ids[] =3D {
+	{ .compatible =3D "ti,omap3-1w" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, omap_hdq_dt_ids);
+
 static struct platform_driver omap_hdq_driver =3D {
 	.probe =3D	omap_hdq_probe,
 	.remove =3D	omap_hdq_remove,
 	.driver =3D	{
 		.name =3D	"omap_hdq",
+		.of_match_table =3D omap_hdq_dt_ids,
 	},
 };
=20

--Sig_/7ddOIc1J6FJuK0j4OzOtqRn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVF1WGDnsnt1WYoG5AQKY8A//QH85O0cW6uytzdkQ9Tr1eFj7TzIm0gYF
eZ6nzYSHaqDaHn7PlBn7YHEdCxPw2hfksdFDvDoUObCxx6UvEMuuCjO+sqneVxJd
5kU9aCb6nk7rUzakfbRoUyCZDaQ03b5SUmLo840/O7alVKQcu+g/Lwom+IFLnsHC
z8XeGZNJL2OLdT5XKmrCKcgg6dhjSoqgE5AGUQK8fyinpZohFpMWWE8Kxis5NJ0R
kpYBUVzLVW+VYgRHtBo0MUt1NxThZ/Qqdq5yh6vW/t6ykamoGamVpVzJ1Kp9274+
Z89PCjJ3VKZoSV/FtcyTT8bvw7zd9odfY7vcXJYqx+XTvVYPCSFCxK1lsjjzVprF
akYQJv5Cu2XGhb/MS6gacNjtdFjJhWLMKIucpT4NPxL3UzXPdHmsiNdP/NqKIJWF
/LuiQN/4i5zF4hK05TA7gEPkCK80kH8RnSnw1MHNGQwI+n9sNEarPHIUQViKEpqw
NJad44hXgLjRo9wftEhKWlO3UGd67FKhhs4csfOILNyt0JRVRBJ21piyhS4VB87O
9PxeEoS7arA6S4XCFxe50XJwVDo2galkPepxtZJKS1zBevkH0ptUeIzFLqCUwUBe
eZbzCYBPVYzo3PGQcBwtmi499AWLV0geS4TyGL0ntLZMz60H+hdPGrIAljofoxrD
qEwTMsH1+kc=
=sYx4
-----END PGP SIGNATURE-----

--Sig_/7ddOIc1J6FJuK0j4OzOtqRn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
