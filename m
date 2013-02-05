From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/6] ARM: dts: omap5: add dwc3 omap dt data
Date: Tue, 5 Feb 2013 10:38:28 +0200
Message-ID: <20130205083828.GE32118@arwen.pp.htv.fi>
References: <1359112312-6918-1-git-send-email-kishon@ti.com>
 <1359112312-6918-5-git-send-email-kishon@ti.com>
 <510432BF.80808@mvista.com> <5110C2E6.30504@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7609591206305871716=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5110C2E6.30504-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============7609591206305871716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline

--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2013 at 01:59:26PM +0530, kishon wrote:
> On Sunday 27 January 2013 01:17 AM, Sergei Shtylyov wrote:
> >Hello.
> >
> >On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:
> >
> >>Add dwc3 omap glue data to the omap5 dt data file. The information about
> >>the dt node added here is available @
> >>Documentation/devicetree/bindings/usb/omap-usb.txt
> >
> >>Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >>---
> >>  arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >
> >>diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> >>index 5f59bf2..1703a72 100644
> >>--- a/arch/arm/boot/dts/omap5.dtsi
> >>+++ b/arch/arm/boot/dts/omap5.dtsi
> >>@@ -513,6 +513,17 @@
> >>              ti,type =3D <2>;
> >>          };
> >>
> >>+        omap_dwc3@4a020000 {
> >>+            compatible =3D "ti,dwc3";
> >>+            ti,hwmods =3D "usb_otg_ss";
> >>+            reg =3D <0x4a020000 0x1ff>;
> >
> >    Shoudn't the "reg" length be 0x200 here? It's length, not limit.
>=20
> I think 0x1ff is correct. I got the data from hwmod data.

hwmod is utterly wrong. Looking at TRM, it says the size here is 64KiB
(0x10000), so is the size for dwc3 itself. Please don't blindly trust
hwmod, make sure you read data from TRM ;-)

--=20
balbi

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREMUEAAoJEIaOsuA1yqREeCMP/00MTFJ+vrclP7kd3hvhezn8
4LYqnFlAY9tYcitSW2SSlOBE6vSJ8zh5hYmDRPgbwIhGNGY53MZRdDDV8TEz7iCQ
6Lk8Agq/OVvejMSE6i6RfZyhpeMzBJX1WayckDmSWp76m7Vmo4O+oNVHxmjOXY8C
9C1+KFyXhNvlEOkuKdu+4+caGhhb/9SaNKtRV1TEBfr/LQp73O6fwmLsERSOh0uV
9DXQ7Tatj5WXt4RTEcMhdCQ7glejLbQ42tUUUmHveQldFcaR5Ov7JSHh+xcuNd4O
H3uLesodihbu8Ak4NyQP712SxysZ1uO/rvTbR+1EUaZjzpnu6SIe8qsF/Wu/etx5
EM4+aUjrvlFwbXROi8C9tKTYKN07OB/WGU2h1Nfjsn98NJAViwhfrz/OC6aQqQz2
rlYN14YXSi9jlySpyW4L3bEctcR1A5XeqBjwMuepaKZZqp/o2sOniLkZjqpa05+h
g2fobrClsR/J6R2rsdbSlUwjb4/GL1T/3yz9Uzdb9QJq9kYKyFdYA4U/LXUJ7Ou/
wiUb1p2cVjr6o70d6+uAzB2UzgNUVZnpHBDKT8BMB0DVwFR5xrL/7bAIXTetOY12
R3d3RzPYDjpKRO/tVgQME4p49PJwy5gmWifAaWRrx3YczFD5y3uqkzmwqETVRpH0
B38FTDw48TEOXJYEagvT
=jOcw
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--

--===============7609591206305871716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7609591206305871716==--
