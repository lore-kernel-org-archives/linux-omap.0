From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] ARM: dts: DRA7: Use dra7-l3-noc instead of omap4-l3-noc
Date: Mon, 14 Apr 2014 14:12:45 -0500
Message-ID: <1397502766-13994-2-git-send-email-nm@ti.com>
References: <1397502766-13994-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397502766-13994-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <ranayak@ti.com>

We have currently marked the DRA7 L3 as being compatible with
omap4-l3-noc This is not true considering the differences in data
involved.

Now that we have proper support for ti,dra7-l3-noc, add the clock
modules clk1 and clk3 (clk2 submodule will be handled by the driver)
and switch compatibility flag to use the proper data.

Signed-off-by: Rajendra Nayak <ranayak@ti.com>
[nm@ti.com: map up full address range]
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1c0f8e1..c7222ca 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -99,13 +99,13 @@
 	 * hierarchy.
 	 */
 	ocp {
-		compatible = "ti,omap4-l3-noc", "simple-bus";
+		compatible = "ti,dra7-l3-noc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2";
-		reg = <0x44000000 0x2000>,
-		      <0x44800000 0x3000>;
+		reg = <0x44000000 0x1000000>,
+		      <0x45000000 0x1000>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
1.7.9.5
