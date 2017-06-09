From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/3] ARM: dts: omap4: add missing des_fck
Date: Sat, 10 Jun 2017 01:12:04 +0200
Message-ID: <20170609231206.19798-2-sre@kernel.org>
References: <20170609231206.19798-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609231206.19798-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add missing functional clock for DES3DES IP core. This is
documented in the TRM as CM_L4SEC_DES3DES_CLKCTRL.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index 9573b37fbaa7..e997265460d4 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -985,6 +985,14 @@
 		reg = <0x15a8>;
 	};
 
+	des_fck: des_fck@15b0 {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l3_div_ck>;
+		ti,bit-shift = <1>;
+		reg = <0x15b0>;
+	};
+
 	dss_sys_clk: dss_sys_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-- 
2.11.0
