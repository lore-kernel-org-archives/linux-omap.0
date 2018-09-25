From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4] ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
Date: Tue, 25 Sep 2018 10:51:51 +0530
Message-ID: <20180925052151.9537-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
incorrectly documented in the TRM. In fact, the bit positions are
swapped. Update the DT bindings for PCIe EP to reflect the same.

Fixes: d23f3839fe97 ("ARM: dts: DRA7: Add pcie1 dt node for EP mode")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---

This patch is split from v3 here:
https://lore.kernel.org/patchwork/cover/967020/
Patch can be applied standalone and has no dependencies on other patches
in v3.

 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1050da6c6d35..fc50d6a8e51a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -355,7 +355,7 @@
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
-				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
 				status = "disabled";
 			};
 		};
-- 
2.19.0
