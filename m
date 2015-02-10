From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] ARM: dts: am33xx-clocks: Fix ehrpwm tbclk data on am33xx
Date: Tue, 10 Feb 2015 11:05:41 +0530
Message-ID: <1423546542-29664-2-git-send-email-vigneshr@ti.com>
References: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

ehrpwm tbclk is wrongly modelled as deriving from dpll_per_m2_ck.
The TRM says tbclk is derived from SYSCLKOUT. SYSCLKOUT nothing but the
functional clock of pwmss (l4ls_gclk).
Fix this by changing source of ehrpwmx_tbclk to l4ls_gclk.

Fixes: 9e100ebafb91: ("Fix ehrpwm tbclk data")
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am33xx-clocks.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index 712edce7d6fb..071b56aa0c7e 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -99,7 +99,7 @@
 	ehrpwm0_tbclk: ehrpwm0_tbclk@44e10664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <0>;
 		reg = <0x0664>;
 	};
@@ -107,7 +107,7 @@
 	ehrpwm1_tbclk: ehrpwm1_tbclk@44e10664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <1>;
 		reg = <0x0664>;
 	};
@@ -115,7 +115,7 @@
 	ehrpwm2_tbclk: ehrpwm2_tbclk@44e10664 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <2>;
 		reg = <0x0664>;
 	};
-- 
1.9.1
