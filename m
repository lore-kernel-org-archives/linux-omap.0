From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 1/2] ARM: dts: dra7x: Remove QSPI pinmux
Date: Wed, 20 Apr 2016 17:02:59 +0530
Message-ID: <1461151980-28139-2-git-send-email-vigneshr@ti.com>
References: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>, nsekhar@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

DRA7 family of processors from Texas Instruments, have a hardware modul=
e
called IODELAYCONFIG Module which is expected to be configured. This
block allows very specific custom fine tuning for electrical
characteristics of IO pins that are necessary for functionality and
device lifetime requirements. IODelay module has it's own register spac=
e
with registers to configure various pins.

According to AM572x TRM SPRUHZ6E October 2014=E2=80=93Revised January 2=
016[1]
section 18.4.6.1 Pad Configuration, in addition to pinmuxing(MUXMODE),
when operating a pad in certain mode, Virtual/Manual IO Timing Mode mus=
t
also be configured to ensure that IO timings are met (DELAYMODE and
MODESELECT fields of pad's IODELAYCONFIG module register). According to
section 18.4.6.1.7 Isolation Requirements of above TRM, when
reprogramming MUXMODE, DELAYMODE, and MODESELECT fields, there is a
potential for a significant glitch on the corresponding IO. It is hence
recommended to do this with I/O isolation (which can only be done in
initial stages of bootloader). QSPI is one such module that requires
IODELAY configuration. So, this patch removes the pinmux for
QSPI for DRA74/DRA72 EVM as it needs to be done in bootloader (U-Boot)
and cannot be done in kernel.

Users should migrate to U-Boot v2016.05-rc1 or higher.

[1] http://www.ti.com/lit/ug/spruhz6e/spruhz6e.pdf

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: rebased on linux-next 20160419 to include moving to
dra72-evm-common.dtsi

 arch/arm/boot/dts/dra7-evm.dts          | 17 -----------------
 arch/arm/boot/dts/dra72-evm-common.dtsi | 14 --------------
 2 files changed, 31 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-ev=
m.dts
index d272cf140197..47d0745a08ad 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -226,21 +226,6 @@
 		>;
 	};
=20
-	qspi1_pins: pinmux_qspi1_pins {
-		pinctrl-single,pins =3D <
-			DRA7XX_CORE_IOPAD(0x344c, PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_=
cs2 */
-			DRA7XX_CORE_IOPAD(0x3450, PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_=
cs3 */
-			DRA7XX_CORE_IOPAD(0x3474, PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1=
_rtclk */
-			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1=
_d3 */
-			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1=
_d2 */
-			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_=
d1 */
-			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1=
_d0 */
-			DRA7XX_CORE_IOPAD(0x3488, PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1=
_sclk */
-			DRA7XX_CORE_IOPAD(0x34b8, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs=
2.qspi1_cs0 */
-			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs=
3.qspi1_cs1 */
-		>;
-	};
-
 	usb1_pins: pinmux_usb1_pins {
                 pinctrl-single,pins =3D <
 			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvb=
us */
@@ -678,8 +663,6 @@
=20
 &qspi {
 	status =3D "okay";
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&qspi1_pins>;
=20
 	spi-max-frequency =3D <48000000>;
 	m25p80@0 {
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dt=
s/dra72-evm-common.dtsi
index 2c880501ba2e..beef82502ea0 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -241,18 +241,6 @@
 		>;
 	};
=20
-	qspi1_pins: pinmux_qspi1_pins {
-		pinctrl-single,pins =3D <
-			DRA7XX_CORE_IOPAD(0x3474, PIN_OUTPUT | MUX_MODE1)	/* gpmc_a13.qspi1=
_rtclk */
-			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)	/* gpmc_a14.qspi1_=
d3 */
-			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)	/* gpmc_a15.qspi1_=
d2 */
-			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1)	/* gpmc_a16.qspi1_=
d1 */
-			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)	/* gpmc_a17.qspi1_=
d0 */
-			DRA7XX_CORE_IOPAD(0x3488, PIN_OUTPUT | MUX_MODE1)	/* qpmc_a18.qspi1=
_sclk */
-			DRA7XX_CORE_IOPAD(0x34b8, PIN_OUTPUT | MUX_MODE1)	/* gpmc_cs2.qspi1=
_cs0 */
-		>;
-	};
-
 	hdmi_pins: pinmux_hdmi_pins {
 		pinctrl-single,pins =3D <
 			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1) /* i2c2_sda.hdmi1_=
ddc_scl */
@@ -692,8 +680,6 @@
=20
 &qspi {
 	status =3D "okay";
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&qspi1_pins>;
=20
 	spi-max-frequency =3D <48000000>;
 	m25p80@0 {
--=20
2.8.1
