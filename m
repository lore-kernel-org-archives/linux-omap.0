From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 3/6] ARM: dts: OMAP4: add clock nodes for CPU
Date: Wed, 8 May 2013 14:06:13 -0500
Message-ID: <1368039976-29648-4-git-send-email-nm@ti.com>
References: <1368039976-29648-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368039976-29648-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP443x, OMAP446x and OMAP447x platforms use dpll_mpu clock.
Add same to common definition.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
no change in current revision.
Previous version: http://marc.info/?l=linux-kernel&m=136580751024225&w=2

 arch/arm/boot/dts/omap4.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..1c6d969 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -31,6 +31,8 @@
 		cpu@0 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
+			clocks = <&dpll_mpu>;
+			clock-names = "cpu";
 		};
 		cpu@1 {
 			compatible = "arm,cortex-a9";
@@ -106,6 +108,11 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		dpll_mpu: dpll_mpu {
+			#clock-cells = <0>;
+			compatible = "ti,omap-clock";
+		};
+
 		omap4_pmx_core: pinmux@4a100040 {
 			compatible = "ti,omap4-padconf", "pinctrl-single";
 			reg = <0x4a100040 0x0196>;
-- 
1.7.9.5
