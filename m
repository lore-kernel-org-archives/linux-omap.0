From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 7/7] ARM: dts: N9/N950: Add support for accelerometer
Date: Sun, 13 Mar 2016 01:06:20 +0100
Message-ID: <1457827580-16919-8-git-send-email-sre@kernel.org>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457827580-16919-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Filip=20Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

=46rom: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>

Signed-off-by: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n9.dts       | 14 ++++++++++
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 54 ++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/omap3-n950.dts     | 14 ++++++++++
 3 files changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n=
9.dts
index f2e213931e09..32414707cc69 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -53,3 +53,17 @@
 		};
 	};
 };
+
+&lis302 {
+	st,axis-x =3D <1>;    /* LIS3_DEV_X */
+	st,axis-y =3D <(-2)>; /* LIS3_INV_DEV_Y */
+	st,axis-z =3D <(-3)>; /* LIS3_INV_DEV_Z */
+
+	st,min-limit-x =3D <(-46)>;
+	st,min-limit-y =3D <3>;
+	st,min-limit-z =3D <3>;
+
+	st,max-limit-x =3D <(-3)>;
+	st,max-limit-y =3D <46>;
+	st,max-limit-z =3D <46>;
+};
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/o=
map3-n950-n9.dtsi
index 38d2d756acdd..22a7e8f7357c 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -53,6 +53,13 @@
 };
=20
 &omap3_pmx_core {
+	accelerator_pins: pinmux_accelerator_pins {
+		pinctrl-single,pins =3D <
+			OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT | MUX_MODE4)	/* mcspi2_somi.gpi=
o_180 -> LIS302 INT1 */
+			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT | MUX_MODE4)	/* mcspi2_cs0.gpio=
_181 -> LIS302 INT2 */
+		>;
+	};
+
 	debug_leds: pinmux_debug_led_pins {
 		pinctrl-single,pins =3D <
 			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE4)       /* dss_data=
22.gpio_92 */
@@ -189,6 +196,53 @@
=20
 &i2c3 {
 	clock-frequency =3D <400000>;
+
+	lis302: lis302@1d {
+		compatible =3D "st,lis3lv02d";
+		reg =3D <0x1d>;
+
+		Vdd-supply =3D <&vaux1>;
+		Vdd_IO-supply =3D <&vio>;
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&accelerator_pins>;
+
+                interrupts-extended =3D <&gpio6 20 IRQ_TYPE_EDGE_FALLI=
NG>, <&gpio6 21 IRQ_TYPE_EDGE_FALLING>; /* 180, 181 */
+
+		/* click flags */
+		st,click-single-x;
+		st,click-single-y;
+		st,click-single-z;
+
+		/* Limits are 0.5g * value */
+		st,click-threshold-x =3D <8>;
+		st,click-threshold-y =3D <8>;
+		st,click-threshold-z =3D <10>;
+
+		/* Click must be longer than time limit */
+		st,click-time-limit =3D <9>;
+
+		/* Kind of debounce filter */
+		st,click-latency =3D <50>;
+
+		st,wakeup-x-hi;
+		st,wakeup-y-hi;
+		st,wakeup-threshold =3D <(800/18)>; /* millig-value / 18 to get HW v=
alues */
+
+		st,wakeup2-z-hi;
+		st,wakeup2-threshold =3D <(1000/18)>; /* millig-value / 18 to get HW=
 values */
+
+		st,highpass-cutoff-hz =3D <2>;
+
+		/* Interrupt line 1 for thresholds */
+		st,irq1-ff-wu-1;
+		st,irq1-ff-wu-2;
+		/* Interrupt line 2 for click detection */
+		st,irq2-click;
+
+		st,wu-duration-1 =3D <8>;
+		st,wu-duration-2 =3D <8>;
+	};
 };
=20
 &mmc1 {
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3=
-n950.dts
index daa17d20ccf5..ff9544cae5af 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -138,3 +138,17 @@
 			 MATRIX_KEY(0x07, 0x07, KEY_R)
 			 >;
 };
+
+&lis302 {
+	st,axis-x =3D <(-2)>; /* LIS3_INV_DEV_Y */
+	st,axis-y =3D <(-1)>; /* LIS3_INV_DEV_X */
+	st,axis-z =3D <(-3)>; /* LIS3_INV_DEV_Z */
+
+	st,min-limit-x =3D <(-32)>;
+	st,min-limit-y =3D <3>;
+	st,min-limit-z =3D <3>;
+
+	st,max-limit-x =3D <(-3)>;
+	st,max-limit-y =3D <32>;
+	st,max-limit-z =3D <32>;
+};
--=20
2.7.0
