From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 3/3] ARM: dts: omap5-uevm: update optional/unused regulator configurations
Date: Mon, 29 Jul 2013 12:03:03 -0500
Message-ID: <1375117383-19285-4-git-send-email-nm@ti.com>
References: <51F67D7D.9070003@ti.com>
 <1375117383-19285-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375117383-19285-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <benoit.cousson@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards.

The following optional/unused regulators can be updated:

- SMPS9 supplies TWL6040 over VDDA_2v1_AUD. This regulator needs to be
enabled only when audio is active. Since it does not come active by
default, it does not require "always-on" or "boot-on".

- LDO2 and LDO8 do not go to any peripheral or connector on the board.
=46urther, these unused regulators should have been 2.8V for LDO2 and
3.0V for LDO8. Mark these LDOs as disabled in the dts until needed.

Reported-by: Marc J=C3=BCttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: J Keerthy <j-keerthy@ti.com>
---

V2: squash of multiple patches from V1, as suggested in:
	http://marc.info/?l=3Ddevicetree&m=3D137510852731656&w=3D2

 arch/arm/boot/dts/omap5-uevm.dts |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5=
-uevm.dts
index 247c03c..65d7b60 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -331,8 +331,6 @@
 					regulator-name =3D "smps9";
 					regulator-min-microvolt =3D <2100000>;
 					regulator-max-microvolt =3D <2100000>;
-					regulator-always-on;
-					regulator-boot-on;
 					ti,smps-range =3D <0x80>;
 				};
=20
@@ -355,10 +353,10 @@
 				ldo2_reg: ldo2 {
 					/* VCC_2V8_DISP: Does not go anywhere */
 					regulator-name =3D "ldo2";
-					regulator-min-microvolt =3D <2900000>;
-					regulator-max-microvolt =3D <2900000>;
-					regulator-always-on;
-					regulator-boot-on;
+					regulator-min-microvolt =3D <2800000>;
+					regulator-max-microvolt =3D <2800000>;
+					/* Unused */
+					status =3D "disabled";
 				};
=20
 				ldo3_reg: ldo3 {
@@ -408,10 +406,11 @@
 				ldo8_reg: ldo8 {
 					/* VDD_3v0: Does not go anywhere */
 					regulator-name =3D "ldo8";
-					regulator-min-microvolt =3D <1500000>;
-					regulator-max-microvolt =3D <1500000>;
-					regulator-always-on;
+					regulator-min-microvolt =3D <3000000>;
+					regulator-max-microvolt =3D <3000000>;
 					regulator-boot-on;
+					/* Unused */
+					status =3D "disabled";
 				};
=20
 				ldo9_reg: ldo9 {
--=20
1.7.9.5
