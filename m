From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 9/9] arm: dts: am43x-gp-evm: Add matrix gpio keys.
Date: Tue, 14 Jan 2014 07:14:44 -0600
Message-ID: <20140114131444.GD10818@saruman.home>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
 <1387456421-21379-10-git-send-email-sourav.poddar@ti.com>
 <52D417A1.9060007@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38565 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbaANNPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jan 2014 08:15:50 -0500
Content-Disposition: inline
In-Reply-To: <52D417A1.9060007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sourav <sourav.poddar@ti.com>
Cc: bcousson@baylibre.com, balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, lokeshvutla@ti.com

--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2014 at 10:13:13PM +0530, sourav wrote:
> Benoit,
>=20
> On Thursday 19 December 2013 06:03 PM, Sourav Poddar wrote:
> >Add gpio keys node for am43x gp evm.
> >
> >Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
> >---
> >  arch/arm/boot/dts/am437x-gp-evm.dts |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am4=
37x-gp-evm.dts
> >index 0dc248d..4eb72b8 100644
> >--- a/arch/arm/boot/dts/am437x-gp-evm.dts
> >+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> >@@ -13,6 +13,7 @@
> >  #include "am4372.dtsi"
> >  #include<dt-bindings/pinctrl/am43xx.h>
> >  #include<dt-bindings/pwm/pwm.h>
> >+#include<dt-bindings/gpio/gpio.h>
> >
> >  / {
> >  	model =3D "TI AM437x GP EVM";
> >@@ -24,6 +25,26 @@
> >  		brightness-levels =3D<0 51 53 56 62 75 101 152 255>;
> >  		default-brightness-level =3D<8>;
> >  	};
> >+
> >+	matrix_keypad: matrix_keypad@0 {
> >+		compatible =3D "gpio-matrix-keypad";
> >+		debounce-delay-ms =3D<5>;
> >+		col-scan-delay-us =3D<2>;
> >+
> >+		row-gpios =3D<&gpio3 21 GPIO_ACTIVE_HIGH /* Bank3, pin21 */
> >+				&gpio4 3 GPIO_ACTIVE_HIGH /* Bank4, pin3 */
> >+				&gpio4 2 GPIO_ACTIVE_HIGH>; /* Bank4, pin2 */
> >+
> >+		col-gpios =3D<&gpio3 19 GPIO_ACTIVE_HIGH /* Bank3, pin19 */
> >+				&gpio3 20 GPIO_ACTIVE_HIGH>; /* Bank3, pin20 */
> >+
> >+		linux,keymap =3D<0x00000201      /* P1 */
> >+				0x00010202      /* P2 */
> >+				0x01000067      /* UP */
> >+				0x0101006a      /* RIGHT */
> >+				0x02000069      /* LEFT */
> >+				0x0201006c>;      /* DOWN */
> >+		};
> >  };
> >
> >  &am43xx_pinmux {
>=20
> ping on this series, this series is lying for a while.
> This series is based on your for_3.14 branch.

Benoit, do you need us to do anything else to get this merged ? Sourav
already rebased the patches as you requested back in December 19th.

cheers

--=20
balbi

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS1ThEAAoJEIaOsuA1yqREGqwP/i/IVMoNNh7M4wyfUAQNaPfR
SiFlAaqtAY4SNs3H+OzlNR5OgEsPgpAvgi0XtuRI9wVeEKcj4yQENNOyiZg1IBxm
pIdW1GfbGKj59WAM8N9db2QfxOUf8wnrb53MXgMHa/hwyzHHpJUmhyudC8OgBtIW
7RIuGF1QveERrClSIihOTEaM+TfgjgjHldhUMLT4Ofrflk+T8wwL8CM+JQ4pOLaL
vMEh248EBtUo7i67kQYH73sOEQimA5yGCO8wiHfXwYkZMywbhaw6kVRQtztX6CbH
xFsuAWSf7F5ueZI/t85wMq+d62AIquTVM59EJuHF4es3LOfN0+NgQRA1B8S+dOMX
wwxxnRiYDga2tJ9R14KitJ7piNgUq+v+OI6h5Jw8id8yaBTMU31W4RouEOdjbW+M
NM3DeciCfH/GVaXRgdM8xxbiDUSU7q4DVBPR3v1tSonh/4kuHjOsaatq7VvgDNZN
2u9N6VD3/A6vfN4vQqJotVwf2l+rwpUY1RwaiF0otskgI+WWZxnm0cyRNkNmXQSG
QKYCTobWQlA2/wmTxg2JD0Gwjjl0zxv1HKT10G9/aEqVKpvb6/H/0C8O4B7c720b
mJQU3rjY1MEPIRDjDqaygHyGAbj7zk8AyRpNXgJqvMwK1ZLXSGHuhss7HEA6IZU/
BMC33Ni/0uiuVjQVegnn
=/twJ
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
