From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v4 2/5] ARM: dts: am43xx clock data
Date: Thu, 13 Mar 2014 20:41:13 +0530
Message-ID: <1394723476-8580-3-git-send-email-george.cherian@ti.com>
References: <1394723476-8580-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394723476-8580-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, rogerq@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, tony@atomide.com, anatol.pomozov@gmail.com, bcousson@baylibre.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Add USB and USB PHY reference clock data

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 142009c..c74d45c 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -653,4 +653,36 @@
 		clocks = <&clk_32768_ck>, <&clk_32k_tpm_ck>;
 		reg = <0x4260>;
 	};
+
+	usb_phy0_always_on_clk32k: usb_phy0_always_on_clk32k {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&clk_32768_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&clk_32768_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
+	usb_otg_ss0_refclk960m: usb_otg_ss0_refclk960m {
+		#clock-cells = <0>;
+	        compatible = "ti,gate-clock";
+		clocks = <&dpll_per_clkdcoldo>;
+	        ti,bit-shift = <8>;
+	        reg = <0x8a60>;
+	};
+
+	usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m {
+		#clock-cells = <0>;
+	        compatible = "ti,gate-clock";
+		clocks = <&dpll_per_clkdcoldo>;
+	        ti,bit-shift = <8>;
+		reg = <0x8a68>;
+	};
 };
-- 
1.8.3.1
