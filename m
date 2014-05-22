From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 2/5] [RFC-HACK] ARM: dts: OMAP3: reorder pinmux_gpio1_pins
Date: Fri, 23 May 2014 01:06:23 +0200
Message-ID: <1400799986-20043-3-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:50322 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbaEVXG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:06:57 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3339265lab.17
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 16:06:55 -0700 (PDT)
In-Reply-To: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

pinctrl-single for omap3_pmx_core2 gets deferred which results in
some corrupt IRQs so that mmc, spi and dss stop working.

Diff of bootlog with (good) and without (fail) this patch:

--- good
+++ fail
 cpuidle: using governor ladder
 cpuidle: using governor menu
 Reprogramming SDRC clock to 400000000 Hz
-pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size 92
 pinctrl-single 48002030.pinmux: 282 pins at pa fa002030 size 564
 pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
+omap_gpio 48310000.gpio: could not find pctldev for node /ocp/pinmux@480025a0/pinmux_gpio1_pins, deferring probe
+platform 48310000.gpio: Driver omap_gpio requests probe deferral
 OMAP GPIO hardware version 2.5
 platform 49022000.mcbsp: alias fck already exists
 omap-gpmc 6e000000.gpmc: GPMC revision 5.0
 gpmc_probe_nand_child: ti,elm-id property not found
 gpmc_read_settings_dt: page/burst-length set but not used!
 gpmc_read_settings_dt: read/write wait monitoring not enabled!
+pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size 92
 omap3_dbb056_legacy_init: Late Reparent clkout2 to 96M_FCK
 omap3_dbb056_legacy_init: Set clkout2 to 24MHz for internal usb hub
 No ATAGs?
@@ -130,8 +132,8 @@
 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
 brd: module loaded
 loop: module loaded
-twl 0-0048: PIH (irq 23) chaining IRQs 338..346
-twl 0-0048: power (irq 343) chaining IRQs 346..353
+twl 0-0048: PIH (irq 23) chaining IRQs 306..314
+twl 0-0048: power (irq 311) chaining IRQs 314..321
 VAUX1: at 3000 mV
 VAUX2_4030: 2800 mV
 VAUX3: at 2800 mV
@@ -150,7 +152,7 @@
 VPLL1: at 1800 mV
 VPLL2: 1800 mV
 VSIM: 1800 <--> 3000 mV at 1800 mV
-twl4030_gpio twl4030-gpio: gpio (irq 338) chaining IRQs 354..371
+twl4030_gpio twl4030-gpio: gpio (irq 306) chaining IRQs 322..339
 twl4030_usb twl4030-usb.29: Initialized TWL4030 USB module
 mtdoops: mtd device (mtddev=name/number) must be supplied
 nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xba
@@ -164,11 +166,12 @@
 0x000000260000-0x000000280000 : "u-boot-environment"
 0x000000280000-0x000000780000 : "kernel"
 0x000000780000-0x000010000000 : "filesystem"
+irq: no irq domain found for /ocp/gpio@48310000 !
 CAN device driver interface
 sja1000 CAN netdevice driver
 libphy: smsc911x-mdio: probed
 smsc911x 15000000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=15000000.etherne:01, irq=-1)
@@ -208,16 +211,16 @@
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 1 port detected
 mousedev: PS/2 mouse device common for all mice
-ads7846 spi2.0: touchscreen, irq 120
-input: ADS7846 Touchscreen as /devices/68000000.ocp/4809a000.spi/spi_master/spi2/spi2.0/input/input0
+ads7846: probe of spi2.0 failed with error -22
 twl_rtc rtc.8: Power up reset detected.
 twl_rtc rtc.8: Enabling TWL-RTC
 twl_rtc rtc.8: rtc core: registered rtc.8 as rtc0
 i2c /dev entries driver
-usb 1-1: new high-speed USB device number 2 using ehci-omap
 omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
+usb 1-1: new high-speed USB device number 2 using ehci-omap
 VMMC1: Restricting voltage, 3100000-1950000uV
 omap_hsmmc 480b4000.mmc: could not set regulator OCR (-22)
+platform leds.3: Driver leds-gpio requests probe deferral
 usbcore: registered new interface driver usbhid
 usbhid: USB HID core driver
 usb 1-1: New USB device found, idVendor=0424, idProduct=2512
@@ -239,6 +242,6 @@
 Registering SWP/SWPB emulation handler
 registered taskstats version 1
 twl_rtc rtc.8: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
-smsc911x 15000000.ethernet eth0: SMSC911x/921x identified at 0xc8856000, IRQ: 241
-smsc911x 20000000.ethernet eth1: SMSC911x/921x identified at 0xc8858000, IRQ: 210
-Sending DHCP requests ...
+smsc911x 15000000.ethernet eth0: SMSC911x/921x identified at 0xc8856000, IRQ: 209
+smsc911x 20000000.ethernet eth1: SMSC911x/921x identified at 0xc8858000, IRQ: 178
+Sending DHCP requests ..., OK
---
 arch/arm/boot/dts/omap34xx.dtsi |   28 ++++++++++++++-------------
 arch/arm/boot/dts/omap36xx.dtsi |   40 ++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 2e92360..4994cb0 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -8,6 +8,21 @@
  * kind, whether express or implied.
  */
 
+/ {
+	ocp {
+		omap3_pmx_core2: pinmux@480025d8 {
+			compatible = "ti,omap3-padconf", "pinctrl-single";
+			reg = <0x480025d8 0x24>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0xff1f>;
+		};
+	};
+};
+
 #include "omap3.dtsi"
 
 / {
@@ -25,19 +40,6 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
-
-	ocp {
-		omap3_pmx_core2: pinmux@480025d8 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x480025d8 0x24>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0xff1f>;
-		};
-	};
 };
 
 /include/ "omap34xx-omap36xx-clocks.dtsi"
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 22cf464..fad05f3 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -8,26 +8,7 @@
  * kind, whether express or implied.
  */
 
-#include "omap3.dtsi"
-
 / {
-	aliases {
-		serial3 = &uart4;
-	};
-
-	cpus {
-		/* OMAP3630/OMAP37xx 'standard device' variants OPP50 to OPP130 */
-		cpu@0 {
-			operating-points = <
-				/* kHz    uV */
-				300000  1012500
-				600000  1200000
-				800000  1325000
-			>;
-			clock-latency = <300000>; /* From legacy driver */
-		};
-	};
-
 	ocp {
 		uart4: serial@49042000 {
 			compatible = "ti,omap3-uart";
@@ -72,6 +53,27 @@
 	};
 };
 
+#include "omap3.dtsi"
+
+/ {
+	aliases {
+		serial3 = &uart4;
+	};
+
+	cpus {
+		/* OMAP3630/OMAP37xx 'standard device' variants OPP50 to OPP130 */
+		cpu@0 {
+			operating-points = <
+				/* kHz    uV */
+				300000  1012500
+				600000  1200000
+				800000  1325000
+			>;
+			clock-latency = <300000>; /* From legacy driver */
+		};
+	};
+};
+
 /* OMAP3630 needs dss_96m_fck for VENC */
 &venc {
 	clocks = <&dss_tv_fck>, <&dss_96m_fck>;
-- 
1.7.10.4

