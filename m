From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v3.19-rc1 regression(?) on N900
Date: Thu, 25 Dec 2014 11:48:00 +0100
Message-ID: <20141225104759.GA3515@amd>
References: <549B44E2.6080202@ti.com>
 <201412250932.40403@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201412250932.40403@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, sre@debian.org, sre@ring0.de, aaro.koskinen@iki.fi, tony@atomide.com, ivo.g.dimitrov.75@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu 2014-12-25 09:32:40, Pali Roh=E1r wrote:
> On Wednesday 24 December 2014 23:57:38 Nishanth Menon wrote:
> > based on automated testing with u-boot as a chained
> > bootloader..
> >=20
> > v3.18: boots fine:
> > https://github.com/nmenon/kernel-test-logs/blob/v3.18/omap2plu
> > s_defconfig/n900.txt
> >=20
> > v3.19-rc1: hung
> > https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc1/omap
> > 2plus_defconfig/n900.txt
> >=20
> > in the interim, my farm had a bit of breakdown around the time
> > of n900 breakdown..
> >=20
> > as per my last functional linux-next logs:
> > https://github.com/nmenon/kernel-test-logs/blob/next-20141204/
> > omap2plus_defconfig/n900.txt -> hung.
> > https://github.com/nmenon/kernel-test-logs/blob/next-20141112/
> > omap2plus_defconfig/n900.txt -> working.
> >=20
> > DEBUG_LL, CONFIG_DEBUG_OMAP3UART3=3Dy and early_printk did not
> > yield information either
> >=20
> > Note: I am using the combined uImage+dtb image.[2]
> >=20
> > I think this might just be my setup..(i use chained loader ->
> > NOLO->u-boot->serial download->kernel) but anyways.. Since
> > Pali thought others might be interested in sharing
> > experience...
> >=20
> > [1]   http://slexy.org/raw/s2osxhhwbR
> > [2]
> > https://github.com/nmenon/linux-2.6-playground/commit/177f5f71
> > b3f21ea484ee4b09a2e0c015de522417
>=20
> CCing other people.
>=20
> I see same problem in qemu with 3.19-rc1 kernel when doing DT=20
> boot. In qemu I'm using direct booting from OneNAND (X-Loader -->=20
> NOLO --> kernel) without U-Boot. After NOLO load & boot kernel I=20
> do not see any other output from serial console. Also on qemu=20
> screen there is no new output (just NOKIA logo from bootloader).
>=20
> I do not have this problem when doing legacy/board code boot with=20
> 3.19-rc1 kernel, so this problem is related to DT.
>=20
> Kernel 3.18-rc1 worked fine for both DT and legacy boot.
>=20
> Can somebody look what broke DT booting?

You should be able to apply this to get it back to boot.

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index 53f3ca0..7c17d084 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -13,9 +13,16 @@
 #include <dt-bindings/input/input.h>
=20
 / {
-	model =3D "Nokia N900";
+	model =3D "Nokia RX-51 board";
 	compatible =3D "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
=20
+	aliases {
+		i2c0;
+		i2c1 =3D &i2c1;
+		i2c2 =3D &i2c2;
+		i2c3 =3D &i2c3;
+	};
+
 	cpus {
 		cpu@0 {
 			cpu0-supply =3D <&vcc>;
@@ -26,7 +33,7 @@
 		compatible =3D "gpio-leds";
 		heartbeat {
 			label =3D "debug::sleep";
-			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
+			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* 162 */
 			linux,default-trigger =3D "default-on";
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&debug_leds>;
@@ -140,14 +147,6 @@
 		>;
 	};
=20
-	ethernet_pins: pinmux_ethernet_pins {
-		pinctrl-single,pins =3D <
-			OMAP3_CORE1_IOPAD(0x20b4, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* gpmc_n=
cs3.gpio_54 */
-			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE4)		/* dss_data16.gp=
io_86 */
-			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE4)		/* uart3_rts_sd.=
gpio_164 */
-		>;
-	};
-
 	gpmc_pins: pinmux_gpmc_pins {
 		pinctrl-single,pins =3D <
=20
@@ -307,7 +306,7 @@
 	regulator-name =3D "V28";
 	regulator-min-microvolt =3D <2800000>;
 	regulator-max-microvolt =3D <2800000>;
-	regulator-always-on; /* due battery cover sensor */
+	regulator-always-on; /* due to battery cover sensor */
 };
=20
 &vaux2 {
@@ -365,7 +364,6 @@
 	regulator-name =3D "VIO";
 	regulator-min-microvolt =3D <1800000>;
 	regulator-max-microvolt =3D <1800000>;
-
 };
=20
 &vintana1 {
@@ -504,30 +502,6 @@
 		clock-mode =3D /bits/ 8 <0>; /* LP55XX_CLOCK_AUTO */
 		enable-gpio =3D <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
=20
-		chan0 {
-			chan-name =3D "lp5523:kb1";
-			led-cur =3D /bits/ 8 <50>;
-			max-cur =3D /bits/ 8 <100>;
-		};
-
-		chan1 {
-			chan-name =3D "lp5523:kb2";
-			led-cur =3D /bits/ 8 <50>;
-			max-cur =3D /bits/ 8 <100>;
-		};
-
-		chan2 {
-			chan-name =3D "lp5523:kb3";
-			led-cur =3D /bits/ 8 <50>;
-			max-cur =3D /bits/ 8 <100>;
-		};
-
-		chan3 {
-			chan-name =3D "lp5523:kb4";
-			led-cur =3D /bits/ 8 <50>;
-			max-cur =3D /bits/ 8 <100>;
-		};
-
 		chan4 {
 			chan-name =3D "lp5523:b";
 			led-cur =3D /bits/ 8 <50>;
@@ -545,18 +519,6 @@
 			led-cur =3D /bits/ 8 <50>;
 			max-cur =3D /bits/ 8 <100>;
 		};
-
-		chan7 {
-			chan-name =3D "lp5523:kb5";
-			led-cur =3D /bits/ 8 <50>;
-			max-cur =3D /bits/ 8 <100>;
-		};
-
-		chan8 {
-			chan-name =3D "lp5523:kb6";
-			led-cur =3D /bits/ 8 <50>;
-			max-cur =3D /bits/ 8 <100>;
-		};
 	};
=20
 	bq27200: bq27200@55 {
@@ -564,6 +526,7 @@
 		reg =3D <0x55>;
 	};
=20
+	/* Stereo headphone amplifier */
 	tpa6130a2: tpa6130a2@60 {
 		compatible =3D "ti,tpa6130a2";
 		reg =3D <0x60>;
@@ -596,6 +559,22 @@
=20
 		ti,usb-charger-detection =3D <&isp1704>;
 	};
+
+	adp1653: led-controller@30 {
+		compatible =3D "adi,adp1653";
+		reg =3D <0x30>;
+		gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
+
+		flash {
+			flash-timeout-microsec =3D <500000>;
+			flash-max-microamp =3D <320000>;
+			max-microamp =3D <50000>;
+		};
+
+		indicator {
+			max-microamp =3D <17500>;
+		};
+	};
 };
=20
 &i2c3 {
@@ -603,6 +582,18 @@
 	pinctrl-0 =3D <&i2c3_pins>;
=20
 	clock-frequency =3D <400000>;
+
+	/* bus 3, same as ad5820, et8ek8 */
+	/* bus 2, adp1653, smiapp */
+	ad5820: ad5820@c {
+		compatible =3D "adi,ad5820";
+		reg =3D <0x0c>;
+	};
+
+	et8ek8: et8ek8@3e {
+		compatible =3D "et,et8ek8";
+		reg =3D <0x3e>;
+	};
 };
=20
 &mmc1 {
@@ -699,43 +690,6 @@
 			reg =3D <0x004c0000 0x0fb40000>;
 		};
 	};
-
-	ethernet@gpmc {
-		compatible =3D "smsc,lan91c94";
-
-		status =3D "disabled";
-
-		interrupt-parent =3D <&gpio2>;
-		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
-		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
-		bank-width =3D <2>;
-		pinctrl-names =3D "default";
-		pinctrl-0 =3D <&ethernet_pins>;
-		power-gpios =3D <&gpio3 22 GPIO_ACTIVE_HIGH>;	/* gpio86 */
-		reset-gpios =3D <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* gpio164 */
-		gpmc,device-width =3D <2>;
-		gpmc,sync-clk-ps =3D <0>;
-		gpmc,cs-on-ns =3D <0>;
-		gpmc,cs-rd-off-ns =3D <48>;
-		gpmc,cs-wr-off-ns =3D <24>;
-		gpmc,adv-on-ns =3D <0>;
-		gpmc,adv-rd-off-ns =3D <0>;
-		gpmc,adv-wr-off-ns =3D <0>;
-		gpmc,we-on-ns =3D <12>;
-		gpmc,we-off-ns =3D <18>;
-		gpmc,oe-on-ns =3D <12>;
-		gpmc,oe-off-ns =3D <48>;
-		gpmc,page-burst-access-ns =3D <0>;
-		gpmc,access-ns =3D <42>;
-		gpmc,rd-cycle-ns =3D <180>;
-		gpmc,wr-cycle-ns =3D <180>;
-		gpmc,bus-turnaround-ns =3D <0>;
-		gpmc,cycle2cycle-delay-ns =3D <0>;
-		gpmc,wait-monitoring-ns =3D <0>;
-		gpmc,clk-activation-ns =3D <0>;
-		gpmc,wr-access-ns =3D <0>;
-		gpmc,wr-data-mux-bus-ns =3D <12>;
-	};
 };
=20
 &mcspi1 {
@@ -823,9 +777,21 @@
 };
=20
 &uart2 {
+        compatible =3D "brcm,uart,bcm2048";
 	interrupts-extended =3D <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart2_pins>;
+
+	clocks =3D <&uart2_fck>, <&uart2_ick>;
+	clock-names =3D "fck", "ick";
+
+	device {
+		  compatible =3D "brcm,bcm2048";
+		  reset-gpios =3D <&gpio3 27 GPIO_ACTIVE_HIGH>; /* 91 */
+		  host-wakeup-gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
+		  bluetooth-wakeup-gpios =3D <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
+		  bt-sysclk =3D <2>;
+	};
 };
=20
 &uart3 {



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
