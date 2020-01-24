From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 05/56] ARM: dts: am57xx-beagle-x15/am57xx-idk:
 Remove "gpios" for endpoint dt nodes
Date: Fri, 24 Jan 2020 09:19:21 -0500
Message-ID: <20200124142012.29752-5-sashal@kernel.org>
References: <20200124142012.29752-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200124142012.29752-1-sashal@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index 6bebedfc0f35a..9f99ecc6890cd 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -93,10 +93,6 @@
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
index 784639ddf4513..8a7d34c8ae115 100644
--- a/arch/arm/boot/dts/am572x-idk-common.dtsi
+++ b/arch/arm/boot/dts/am572x-idk-common.dtsi
@@ -71,10 +71,6 @@
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
index d53532b479475..872382bd043f8 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -550,10 +550,6 @@
 	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
 };
 
-&pcie1_ep {
-	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
-};
-
 &mcasp3 {
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&l4per_clkctrl DRA7_MCASP3_CLKCTRL 24>;
-- 
2.20.1
