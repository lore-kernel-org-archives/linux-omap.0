From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 2/5] ARM: dts: omap4.dtsi: remove aes[12]_fck
Date: Tue, 13 Jun 2017 11:28:44 +0200
Message-ID: <20170613092847.16732-3-sebastian.reichel@collabora.co.uk>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

"aes1_fck" and "aes2_fck" are controlled by hwmod. Drop clock
entries to avoid conflicts.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index 9573b37fbaa7..008693b0b17a 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -969,22 +969,6 @@
 		ti,max-div = <2>;
 	};
 
-	aes1_fck: aes1_fck@15a0 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3_div_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x15a0>;
-	};
-
-	aes2_fck: aes2_fck@15a8 {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&l3_div_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x15a8>;
-	};
-
 	dss_sys_clk: dss_sys_clk@1120 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-- 
2.11.0
