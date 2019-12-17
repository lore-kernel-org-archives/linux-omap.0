From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/14] ARM: dts: Configure interconnect target module for
 omap2 sdma
Date: Mon, 16 Dec 2019 16:19:13 -0800
Message-ID: <20191217001925.44558-3-tony@atomide.com>
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

Note that we want to use separate compatible for omap2420 and
omap2430 so let's do that here too while at it.

Cc: devicetree@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap2.dtsi    | 42 +++++++++++++++++++++++++--------
 arch/arm/boot/dts/omap2430.dtsi |  4 ++++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/omap.h>
@@ -79,17 +80,38 @@ intc: interrupt-controller@1 {
 			reg = <0x480FE000 0x1000>;
 		};
 
-		sdma: dma-controller@48056000 {
-			compatible = "ti,omap2430-sdma", "ti,omap2420-sdma";
+		target-module@48056000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "dma";
-			reg = <0x48056000 0x1000>;
-			interrupts = <12>,
-				     <13>,
-				     <14>,
-				     <15>;
-			#dma-cells = <1>;
-			dma-channels = <32>;
-			dma-requests = <64>;
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
+			ti,syss-mask = <1>;
+			clocks = <&core_l3_ck>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48056000 0x1000>;
+
+			sdma: dma-controller@0 {
+				compatible = "ti,omap2420-sdma", "ti,omap-sdma";
+				reg = <0 0x1000>;
+				interrupts = <12>,
+					     <13>,
+					     <14>,
+					     <15>;
+				#dma-cells = <1>;
+				dma-channels = <32>;
+				dma-requests = <64>;
+			};
 		};
 
 		i2c1: i2c@48070000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -309,6 +309,10 @@ wd_timer2: wdt@49016000 {
 	};
 };
 
+&sdma {
+	compatible = "ti,omap2430-sdma", "ti,omap-sdma";
+};
+
 &i2c1 {
 	compatible = "ti,omap2430-i2c";
 };
-- 
2.24.1
