From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 9/9] arm: dts: am43x-gp-evm: Add matrix gpio keys.
Date: Tue, 14 Jan 2014 11:54:26 -0600
Message-ID: <20140114175426.GB13600@saruman.home>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
 <1387456421-21379-10-git-send-email-sourav.poddar@ti.com>
 <52D417A1.9060007@ti.com>
 <20140114131444.GD10818@saruman.home>
 <52D547F5.2080307@baylibre.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34706 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbaANRze (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jan 2014 12:55:34 -0500
Content-Disposition: inline
In-Reply-To: <52D547F5.2080307@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: balbi@ti.com, sourav <sourav.poddar@ti.com>, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, lokeshvutla@ti.com

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 03:21:41PM +0100, Benoit Cousson wrote:
> Hi Felipe,
>=20
> On 14/01/2014 14:14, Felipe Balbi wrote:
> >On Mon, Jan 13, 2014 at 10:13:13PM +0530, sourav wrote:
> >>Benoit,
> >>
> >>On Thursday 19 December 2013 06:03 PM, Sourav Poddar wrote:
> >>>Add gpio keys node for am43x gp evm.
> >>>
> >>>Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
> >>>---
> >>>  arch/arm/boot/dts/am437x-gp-evm.dts |   21 +++++++++++++++++++++
> >>>  1 file changed, 21 insertions(+)
> >>>
> >>>diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/a=
m437x-gp-evm.dts
> >>>index 0dc248d..4eb72b8 100644
> >>>--- a/arch/arm/boot/dts/am437x-gp-evm.dts
> >>>+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> >>>@@ -13,6 +13,7 @@
> >>>  #include "am4372.dtsi"
> >>>  #include<dt-bindings/pinctrl/am43xx.h>
> >>>  #include<dt-bindings/pwm/pwm.h>
> >>>+#include<dt-bindings/gpio/gpio.h>
> >>>
> >>>  / {
> >>>  	model =3D "TI AM437x GP EVM";
> >>>@@ -24,6 +25,26 @@
> >>>  		brightness-levels =3D<0 51 53 56 62 75 101 152 255>;
> >>>  		default-brightness-level =3D<8>;
> >>>  	};
> >>>+
> >>>+	matrix_keypad: matrix_keypad@0 {
> >>>+		compatible =3D "gpio-matrix-keypad";
> >>>+		debounce-delay-ms =3D<5>;
> >>>+		col-scan-delay-us =3D<2>;
> >>>+
> >>>+		row-gpios =3D<&gpio3 21 GPIO_ACTIVE_HIGH /* Bank3, pin21 */
> >>>+				&gpio4 3 GPIO_ACTIVE_HIGH /* Bank4, pin3 */
> >>>+				&gpio4 2 GPIO_ACTIVE_HIGH>; /* Bank4, pin2 */
> >>>+
> >>>+		col-gpios =3D<&gpio3 19 GPIO_ACTIVE_HIGH /* Bank3, pin19 */
> >>>+				&gpio3 20 GPIO_ACTIVE_HIGH>; /* Bank3, pin20 */
> >>>+
> >>>+		linux,keymap =3D<0x00000201      /* P1 */
> >>>+				0x00010202      /* P2 */
> >>>+				0x01000067      /* UP */
> >>>+				0x0101006a      /* RIGHT */
> >>>+				0x02000069      /* LEFT */
> >>>+				0x0201006c>;      /* DOWN */
> >>>+		};
> >>>  };
> >>>
> >>>  &am43xx_pinmux {
> >>
> >>ping on this series, this series is lying for a while.
> >>This series is based on your for_3.14 branch.
> >
> >Benoit, do you need us to do anything else to get this merged ? Sourav
> >already rebased the patches as you requested back in December 19th.
>=20
> Nope, I've just needed more BW. I'll apply it ASAP.

cool, thanks.

--=20
balbi

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS1XnSAAoJEIaOsuA1yqRE4EAP/A/Xtlt+9gqShUIUcxoZXZM5
a67rB1g60C9JaZ2iDGl42obye5Smf3Bi2gwM29G00TJNVb1YadDhO+9HsJCOPvLY
e/uEWPOAZ4m8i8hTfaMX4sRH+8GiskJT7JD3wrq7WepCDpkaFBHzeShsjxdsroNN
CskeNj0Hwcl7fWsCg9NU/K/Hbg8kXG1GsS/D2ApPFdOSVFGQ1HDHmSzwYYOZkfJi
judzScIhKmdeQDvBkWg8ncxwY5XUwBDmx7fgvlqmN0v3dgtA2w57ugw5nfTOZHwB
ullKpYuv7NNp+dL+ETuLHnc0up2pAVGwmh0qFZbNktjPNdwUviV8e/MRNlvFQTsI
pcCqCLrH122neDPqQYmDfEaDyhs13tRkce+4LrM724ftfeQRxSgCvOggG1lOrnrD
VuNs+tBKiorTenj3qjVsWkthSILFER8kcU2TKNeBkDloOA2DCnGPGaOcMcAaO+sB
pB0zHb/ebDCfVgW4X4G93dN0udBh/WAJqGSFXGV7/jFpjfKVs/52PY7fuhQwNBB/
sWJeGx8yoxUGmAS/5ADhwKm3WGTe2W+i9OXVLuA5yN2KoBMib+rQy6JijsKoJyAX
7AgDOnNOC5Werq4M0aZ+R2C+ryvlq/L+EEfQ1lL+BYXu3zicU3elg0zkYTaX7niz
I9wKq8bImj1Nyzxv0kUK
=vkSn
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
