From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/10] ARM: dts: Fix some mux and divider clocks to get dm814x-evm booting
Date: Tue,  1 Dec 2015 15:38:21 -0800
Message-ID: <1449013103-23238-9-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Although we have hp t410 booting, I noticed that dm814x-evm does not boot
after I got one. This is because we don't have the clocks yet configured
properly. Let's start configuring proper clocks starting with the system
timers and clocks that work with existing mux and divider clock drivers.

Note that the oscillator speed register is different from am335x, dm814x
has only one bit that shows the BTMODE[6] at CONTROL_STATUS[21].

Also note that this only gets the system timers working with the defined
clocks. The PLL clocks are still missing and and the devices may or may
not work depending on what the bootloader has enabled.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x-clocks.dtsi | 109 +++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
index ef1e8e7..2600158 100644
--- a/arch/arm/boot/dts/dm814x-clocks.dtsi
+++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
@@ -4,25 +4,74 @@
  * published by the Free Software Foundation.
  */
 
+&pllss_clocks {
+	timer1_fck: timer1_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
+			  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
+		ti,bit-shift = <3>;
+		reg = <0x2e0>;
+	};
+
+	timer2_fck: timer2_fck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
+			  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
+		ti,bit-shift = <6>;
+		reg = <0x2e0>;
+	};
+
+	sysclk18_ck: sysclk18_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&rtcosc_ck>, <&rtcdivider_ck>;
+		ti,bit-shift = <0>;
+		reg = <0x02f0>;
+	};
+};
+
 &scm_clocks {
+	devosc_ck: devosc_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&virt_20000000_ck>, <&virt_19200000_ck>;
+		ti,bit-shift = <21>;
+		reg = <0x0040>;
+	};
 
-	tclkin_ck: tclkin_ck {
+	/* Optional auxosc, 20 - 30 MHz range, assume 27 MHz by default */
+	auxosc_ck: auxosc_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+	};
+
+	/* Optional 32768Hz crystal or clock on RTCOSC pins */
+	rtcosc_ck: rtcosc_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 	};
 
-	devosc_ck: devosc_ck {
+	/* Optional external clock on TCLKIN pin, set rate in baord dts file */
+	tclkin_ck: tclkin_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	virt_20000000_ck: virt_20000000_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <20000000>;
 	};
 
-	/* Optional auxosc, 20 - 30 MHz range, assume 27 MHz by default */
-	auxosc_ck: auxosc_ck {
+	virt_19200000_ck: virt_19200000_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-		clock-frequency = <27000000>;
+		clock-frequency = <19200000>;
 	};
 
 	mpu_ck: mpu_ck {
@@ -49,12 +98,6 @@
 		clock-frequency = <48000000>;
 	};
 
-	sysclk18_ck: sysclk18_ck {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <32768>;
-	};
-
         cpsw_125mhz_gclk: cpsw_125mhz_gclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -69,7 +112,31 @@
 
 };
 
-&pllss_clocks {
+&prcm_clocks {
+	osc_src_ck: osc_src_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&devosc_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	mpu_clksrc_ck: mpu_clksrc_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&devosc_ck>, <&rtcdivider_ck>;
+		ti,bit-shift = <0>;
+		reg = <0x0040>;
+	};
+
+	/* Fixed divider clock 0.0016384 * devosc */
+	rtcdivider_ck: rtcdivider_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&devosc_ck>;
+		clock-mult = <128>;
+		clock-div = <78125>;
+	};
 
 	aud_clkin0_ck: aud_clkin0_ck {
 		#clock-cells = <0>;
@@ -88,22 +155,4 @@
 		compatible = "fixed-clock";
 		clock-frequency = <20000000>;
 	};
-
-	timer1_mux_ck: timer1_mux_ck {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
-			  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
-		ti,bit-shift = <3>;
-		reg = <0x2e0>;
-	};
-
-	timer2_mux_ck: timer2_mux_ck {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
-			  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
-		ti,bit-shift = <6>;
-		reg = <0x2e0>;
-	};
 };
-- 
2.6.2
