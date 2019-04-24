From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 14/66] ARM: dts: Fix dcan clkctrl clock for am3
Date: Wed, 24 Apr 2019 10:32:48 -0400
Message-ID: <20190424143341.27665-14-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9 ]

We must not use legacy clock defines for dts clckctrl clocks as the offsets
will be wrong.

Fixes: 87fc89ced3a7 ("ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc")
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7b818d9d2eab..8396faa9ac28 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1763,7 +1763,7 @@
 			reg = <0xcc000 0x4>;
 			reg-names = "rev";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM3_D_CAN0_CLKCTRL 0>;
+			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN0_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1786,7 +1786,7 @@
 			reg = <0xd0000 0x4>;
 			reg-names = "rev";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM3_D_CAN1_CLKCTRL 0>;
+			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN1_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.19.1
