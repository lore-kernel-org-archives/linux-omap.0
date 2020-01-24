From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 009/107] ARM: dts: am57xx-beagle-x15/am57xx-idk: Remove "gpios" for  endpoint dt nodes
Date: Fri, 24 Jan 2020 09:16:39 -0500
Message-ID: <20200124141817.28793-9-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 81cc0877840f72210e809bbedd6346d686560fc1 ]

PERST# line in the PCIE connector is driven by the host mode and not
EP mode. The gpios property here is used for driving the PERST# line.
Remove gpios property from all endpoint device tree nodes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am571x-idk.dts                | 4 ----
 arch/arm/boot/dts/am572x-idk-common.dtsi        | 4 ----
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 0aaacea1d887b..975a6b1d3fc80 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -170,10 +170,6 @@
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 };
 
-&pcie1_ep {
-	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-};
-
 &mmc1 {
 	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
diff --git a/arch/arm/boot/dts/am572x-idk-common.dtsi b/arch/arm/boot/dts/am572x-idk-common.dtsi
index a064f13b38802..ddf123620e962 100644
--- a/arch/arm/boot/dts/am572x-idk-common.dtsi
+++ b/arch/arm/boot/dts/am572x-idk-common.dtsi
@@ -147,10 +147,6 @@
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 };
 
-&pcie1_ep {
-	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-};
-
 &mailbox5 {
 	status = "okay";
 	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index bc76f1705c0f6..9a94c96b0350e 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -547,10 +547,6 @@
 	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
 };
 
-&pcie1_ep {
-	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
-};
-
 &mcasp3 {
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 24>;
-- 
2.20.1
