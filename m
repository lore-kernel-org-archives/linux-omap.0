From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 3/3] ARM: dts: dra7: Add ti-sysc node for VPE
Date: Wed, 9 Oct 2019 12:56:28 -0500
Message-ID: <20191009175628.20570-4-bparrot@ti.com>
References: <20191009175628.20570-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009175628.20570-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add VPE node as a child of l4 interconnect in order for it to probe
using ti-sysc.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index ea0e7c19eb4e..d876c1754f33 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -4158,12 +4158,36 @@
 			ranges = <0x0 0x1b0000 0x10000>;
 		};
 
-		target-module@1d0000 {			/* 0x489d0000, ap 27 30.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+		target-module@1d0010 {			/* 0x489d0000, ap 27 30.0 */
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0x1d0010 0x4>;
+			reg-names = "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			clocks = <&vpe_clkctrl DRA7_VPE_VPE_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x1d0000 0x10000>;
+
+			vpe: vpe@0 {
+				compatible = "ti,vpe";
+				reg = <0x0000 0x120>,
+				      <0x0700 0x80>,
+				      <0x5700 0x18>,
+				      <0xd000 0x400>;
+				reg-names = "vpe_top",
+					    "sc",
+					    "csc",
+					    "vpdma";
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 	};
 };
-- 
2.17.1
