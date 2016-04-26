From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH 2/3] ARM: DRA7x: dts: Fix the 32kHz clock calculation
Date: Tue, 26 Apr 2016 12:54:28 -0500
Message-ID: <1461693269-19436-3-git-send-email-Linux.HWI@garmin.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

From: "J.D. Schroeder" <jay.schroeder@garmin.com>

This commit fixes the 32kHz clock (sys_32k_ck) calculation to be
correctly based on the SYS_CLK1 (sys_clkin1) frequency. Based on the
TRM CTRL_CORE_BOOTSTRAP[9:8] SPEEDSELECT, set by the SYSBOOT[9:8]
board jumpers according to the SYS_CLK1 frequency, the frequency of
the 32kHz FUNC_32K_CLK is set to SYS_CLK1/610. The following
sys_32k_ck frequencies get used for different SYS_CLK1 frequencies:
        0b00: Unknown  -> 32768 Hz crystal from CLKIN_32K pin
        0b01: 20   MHz -> 32787 Hz clock (SYS_CLK1/610)
        0b10: 27   MHz -> 44262 Hz clock (SYS_CLK1/610)
        0b11: 19.2 MHz -> 31475 Hz clock (SYS_CLK1/610)

Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Reviewed-by: Ben McCauley <ben.mccauley@garmin.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 9d1a583..a514fc3 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -98,12 +98,6 @@
 		clock-frequency = <32768>;
 	};
 
-	sys_32k_ck: sys_32k_ck {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <32768>;
-	};
-
 	virt_12000000_ck: virt_12000000_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -2177,4 +2171,26 @@
 		ti,bit-shift = <22>;
 		reg = <0x0558>;
 	};
+
+	sys_32kin: sys_32kin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
+	sys_clkin1_32k_div: sys_clkin1_32k_div {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin1>;
+		clock-mult = <1>;
+		clock-div = <610>;
+	};
+
+	sys_32k_ck: sys_32k_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_32kin>, <&sys_clkin1_32k_div>, <&sys_clkin1_32k_div>, <&sys_clkin1_32k_div>;
+		ti,bit-shift = <8>;
+		reg = <0x06c4>;
+	};
 };
-- 
1.9.1
