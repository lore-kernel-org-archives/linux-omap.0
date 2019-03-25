From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
Date: Mon, 25 Mar 2019 15:15:25 +0530
Message-ID: <20190325094525.362-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

ti,syscon-lane-sel and ti,syscon-lane-conf properties specific to enable
PCIe x2 lane mode are added here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 2bc9add8b7a5..d87e932f45bd 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -193,6 +193,7 @@
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
+				ti,syscon-lane-sel = <&scm_conf_pcie 0x18>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie1_intc 1>,
 						<0 0 0 2 &pcie1_intc 2>,
@@ -218,6 +219,7 @@
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
 				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
+				ti,syscon-lane-sel = <&scm_conf_pcie 0x18>;
 				status = "disabled";
 			};
 		};
-- 
2.17.1
