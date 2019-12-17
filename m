From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/14] ARM: dts: Configure interconnect target module for
 omap3 sdma
Date: Mon, 16 Dec 2019 16:19:14 -0800
Message-ID: <20191217001925.44558-4-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can now probe devices with device tree only configuration using
ti-sysc interconnect target module driver. Let's configure the
module, but keep the legacy "ti,hwmods" peroperty to avoid new boot
time warnings. The legacy property will be removed in later patches
together with the legacy platform data.

Note that we want to use separate compatible for omap34xx and
omap36xx so let's do that here too while at it.

Cc: devicetree@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-n900.dts |  5 ++++
 arch/arm/boot/dts/omap3.dtsi     | 45 +++++++++++++++++++++++++-------
 arch/arm/boot/dts/omap36xx.dtsi  |  4 +++
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -482,6 +482,11 @@ &vintdig {
 	regulator-always-on;
 };
 
+/* First two dma channels are reserved on secure omap3 */
+&sdma {
+	dma-channel-mask = <0xfffffffc>;
+};
+
 &twl {
 	twl_audio: audio {
 		compatible = "ti,twl4030-audio";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -206,17 +206,42 @@ intc: interrupt-controller@48200000 {
 			reg = <0x48200000 0x1000>;
 		};
 
-		sdma: dma-controller@48056000 {
-			compatible = "ti,omap3630-sdma", "ti,omap3430-sdma";
-			reg = <0x48056000 0x1000>;
-			interrupts = <12>,
-				     <13>,
-				     <14>,
-				     <15>;
-			#dma-cells = <1>;
-			dma-channels = <32>;
-			dma-requests = <96>;
+		target-module@48056000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "dma";
+			reg = <0x48056000 0x4>,
+			      <0x4805602c 0x4>,
+			      <0x48056028 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_EMUFREE |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			/* Domains (V, P, C): core, core_pwrdm, core_l3_clkdm */
+			clocks = <&core_l3_ick>;
+			clock-names = "ick";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48056000 0x1000>;
+
+			sdma: dma-controller@0 {
+				compatible = "ti,omap3430-sdma", "ti,omap-sdma";
+				reg = <0x0 0x1000>;
+				interrupts = <12>,
+					     <13>,
+					     <14>,
+					     <15>;
+				#dma-cells = <1>;
+				dma-channels = <32>;
+				dma-requests = <96>;
+			};
 		};
 
 		gpio1: gpio@48310000 {
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -223,6 +223,10 @@ thermal_zones: thermal-zones {
 	};
 };
 
+&sdma {
+	compatible = "ti,omap3630-sdma", "ti,omap-sdma";
+};
+
 /* OMAP3630 needs dss_96m_fck for VENC */
 &venc {
 	clocks = <&dss_tv_fck>, <&dss_96m_fck>;
-- 
2.24.1
