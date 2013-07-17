From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/9] ARM: dts: omap5-uevm: update and disable unused regulators LDO[28]
Date: Wed, 17 Jul 2013 11:45:32 -0500
Message-ID: <1374079538-19548-4-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards - On production boards, LDO2 and 8 are unused.

LDO2 and LDO8 do not go to any peripheral or connector on the board.
=46urther, these unused regulators should have been 2.8V for LDO2 and
3.0V for LDO8. Mark these LDOs as disabled in the dts until needed.

Reported-by: Marc J=C3=BCttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5=
-uevm.dts
index 6709f1e..87b3e9e 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -355,10 +355,10 @@
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
@@ -409,10 +409,11 @@
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
