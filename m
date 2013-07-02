From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] usb: common: introduce of_usb_get_maximum_speed()
Date: Tue, 2 Jul 2013 21:22:06 +0300
Message-ID: <20130702182206.GB9216@arwen.pp.htv.fi>
References: <1372663135-436-1-git-send-email-balbi@ti.com>
 <1372663135-436-4-git-send-email-balbi@ti.com>
 <51D289FF.8030909@linutronix.de>
 <20130702081009.GE3352@arwen.pp.htv.fi>
 <51D28BD0.3090101@linutronix.de>
 <20130702082605.GG3352@arwen.pp.htv.fi>
 <51D29264.6070207@linutronix.de>
 <20130702093114.GJ3352@arwen.pp.htv.fi>
 <A2CA0424C0A6F04399FB9E1CD98E030458DD886F@US01WEMBX2.internal.synopsys.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53153 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab3GBSW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 14:22:26 -0400
Content-Disposition: inline
In-Reply-To: <A2CA0424C0A6F04399FB9E1CD98E030458DD886F@US01WEMBX2.internal.synopsys.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Cc: "balbi@ti.com" <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Michael Grzeschik <mgr@pengutronix.de>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, George Cherian <george.cherian@ti.com>, Benoit Cousson <b-cousson@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 02, 2013 at 06:04:45PM +0000, Paul Zimmerman wrote:
> > From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-owner@vger.kern=
el.org] On Behalf Of Felipe Balbi
> > Sent: Tuesday, July 02, 2013 2:31 AM
> >=20
> >     Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Docume=
ntation/devicetree/bindings/usb/generic.txt
> > new file mode 100644
> > index 0000000..477d5bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/generic.txt
> > @@ -0,0 +1,24 @@
> > +Generic USB Properties
> > +
> > +Optional properties:
> > + - maximum-speed: tells USB controllers we want to work up to a certain
> > +			speed. Valid arguments are "super-speed", "high-speed",
> > +			"full-speed" and "low-speed". In case this isn't passed
> > +			via DT, USB controllers should default to their maximum
> > +			HW capability.
> > + - dr_mode: tells Dual-Role USB controllers that we want to work on a
> > +			particular mode. Valid arguments are "host",
> > +			"peripheral" and "otg". In case this attribute isn't
> > +			passed via DT, USB DRD controllers should default to
> > +			OTG.
> > +
> > +This is an attribute to a USB controller such as:
> > +
> > +dwc3@4a030000 {
> > +	compatible =3D "synopsys,dwc3";
>=20
> Hi Felipe,
>=20
> Just a small nit. Weren't you going to change this property to
> "snps,dwc3" to match the existing Synopsys DT naming convention
> in the kernel? Or has the horse already left the gate on that?

I think we can still change, but we need to keep compatibility for the
old one in the driver :-)

Here's a patch for that:

commit 90dc4b82df9d0b4d049d03d1be225b9c7456522b
Author: Felipe Balbi <balbi@ti.com>
Date:   Tue Jul 2 21:20:24 2013 +0300

    usb: dwc3: core: switch to snps,dwc3
   =20
    all other drivers using Synopsys IPs with DT
    have a compatible of snps,$driver, in order
    to add consistency, we are switching over to
    snps,dwc3 but keeping synopsys,dwc3 in the core
    driver to maintain backwards compatibility.
   =20
    New DTS bindings should NOT use synopsys,dwc3.
   =20
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation=
/devicetree/bindings/usb/dwc3.txt
index 7a95c65..3a64e20 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -3,7 +3,7 @@ synopsys DWC3 CORE
 DWC3- USB3 CONTROLLER
=20
 Required properties:
- - compatible: must be "synopsys,dwc3"
+ - compatible: must be "snps,dwc3"
  - reg : Address and length of the register set for the device
  - interrupts: Interrupts used by the dwc3 controller.
  - usb-phy : array of phandle for the PHY device
@@ -14,7 +14,7 @@ Optional properties:
 This is usually a subnode to DWC3 glue to which it is connected.
=20
 dwc3@4a030000 {
-	compatible =3D "synopsys,dwc3";
+	compatible =3D "snps,dwc3";
 	reg =3D <0x4a030000 0xcfff>;
 	interrupts =3D <0 92 4>
 	usb-phy =3D <&usb2_phy>, <&usb3,phy>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 635cae2..2462708 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -641,7 +641,7 @@
 			utmi-mode =3D <2>;
 			ranges;
 			dwc3@4a030000 {
-				compatible =3D "synopsys,dwc3";
+				compatible =3D "snps,dwc3";
 				reg =3D <0x4a030000 0x1000>;
 				interrupts =3D <0 92 4>;
 				usb-phy =3D <&usb2_phy>, <&usb3_phy>;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c86ae12..a4dab1c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -755,6 +755,9 @@ static const struct dev_pm_ops dwc3_dev_pm_ops =3D {
 #ifdef CONFIG_OF
 static const struct of_device_id of_dwc3_match[] =3D {
 	{
+		.compatible =3D "snps,dwc3"
+	},
+	{
 		.compatible =3D "synopsys,dwc3"
 	},
 	{ },

--=20
balbi

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR0xpOAAoJEIaOsuA1yqREShIP/2VcWyCGuHhHi1LIpbd1lP+v
f4kXEz3eNrstJidqtT4DVNlKF4ObwoUZ1bQ6c7sJ6REBsMWwpDIgdQuwlcmrl1N9
XlMdc6+fYjo6RoyULDHStgz/Gy06fgGCOWYTv6HaZ1jPUKuWnfc/veS9RwgeaOxS
TWBuKBGHOWmfn2iRm4AagJXZqIYSVeg21N7usNh+29EXABOX0GiLLD8zHnrQKyf+
qT2HGYnU53RVT5A8ZExjc9DsJMH7A+p2sKwYZtYGvKWemup++bmK+Gg7AVEHa/JS
uRD8qXpRisEAUeFfi1ldOxawBy1bzmEJDnPktkN4ZAYz7cCiCy5JIhnaMc1GY9Qb
1+NhbhF7szypS3cEX/N7nTErRsLWkF1xIxpWgHn7SFZvRXkx9vtLw0PzPLzOGRTN
xYifrs7S9eJsftdcz75lzj+6H4sJ3Eqi9KCZLi6t7VyGqCbQdc7cyycTyijthqHX
BOrLSMYWs4mv+0ORAlLd7iojQGHDJxdqXVNrk8XEz0gnaOd5IpJO5e4UQ3lQjuLv
1IngAkWB4+brRoQ+U35Ooi7mGlydw3M9RojrqNKnLkOsxHUHCmkdZppWxHAB7/So
GbLHIpNuowY5m23f0wWsUQpftG/GfgA0jHgB2ccQf7xhM3d6laIU8EbAUKFKvjwu
tzauXp2MTpnG3YAzq02I
=/NhX
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
