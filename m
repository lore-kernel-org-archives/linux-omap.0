From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/20] ARM: dts: omap4: add bus functionality to base PRCM nodes
Date: Thu, 7 Dec 2017 10:46:42 +0200
Message-ID: <1512636413-25243-10-git-send-email-t-kristo@ti.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512636413-25243-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFAdd simple-bus compatibility and ranges properties to cm1, cm2 and=
 prm
nodes. This is done in preparation of adding the support for clkctrl
nodes.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 56fdde3..787ea2a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -143,8 +143,11 @@
 			ranges =3D <0 0x4a000000 0x1000000>;
=20
 			cm1: cm1@4000 {
-				compatible =3D "ti,omap4-cm1";
+				compatible =3D "ti,omap4-cm1", "simple-bus";
 				reg =3D <0x4000 0x2000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				ranges =3D <0 0x4000 0x2000>;
=20
 				cm1_clocks: clocks {
 					#address-cells =3D <1>;
@@ -156,8 +159,11 @@
 			};
=20
 			cm2: cm2@8000 {
-				compatible =3D "ti,omap4-cm2";
+				compatible =3D "ti,omap4-cm2", "simple-bus";
 				reg =3D <0x8000 0x3000>;
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				ranges =3D <0 0x8000 0x3000>;
=20
 				cm2_clocks: clocks {
 					#address-cells =3D <1>;
@@ -243,6 +249,9 @@
 					compatible =3D "ti,omap4-prm";
 					reg =3D <0x6000 0x3000>;
 					interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					#address-cells =3D <1>;
+					#size-cells =3D <1>;
+					ranges =3D <0 0x6000 0x3000>;
=20
 					prm_clocks: clocks {
 						#address-cells =3D <1>;
--=20
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
