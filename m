From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4] ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
Date: Fri, 28 Sep 2018 11:34:42 +0530
Message-ID: <20180928060442.24312-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Add ti,syscon-unaligned-access property to PCIe RC nodes to set
appropriate bits in CTRL_CORE_SMA_SW_7 register to enable workaround for
errata i870.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
This patch is split from v3 here:
https://lore.kernel.org/patchwork/cover/967020/
Dependent DT binding documentation and driver changes are now merged via
PCI tree and part of next-20180928

 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9136b3cf9a2c..7ce24b282d42 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -336,6 +336,7 @@
 						<0 0 0 2 &pcie1_intc 2>,
 						<0 0 0 3 &pcie1_intc 3>,
 						<0 0 0 4 &pcie1_intc 4>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
 				status = "disabled";
 				pcie1_intc: interrupt-controller {
 					interrupt-controller;
@@ -387,6 +388,7 @@
 						<0 0 0 2 &pcie2_intc 2>,
 						<0 0 0 3 &pcie2_intc 3>,
 						<0 0 0 4 &pcie2_intc 4>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
 				pcie2_intc: interrupt-controller {
 					interrupt-controller;
 					#address-cells = <0>;
-- 
2.19.0
