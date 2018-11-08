From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65: Add pinctrl regions
Date: Thu, 8 Nov 2018 16:56:47 +0530
Message-ID: <20181108112647.7205-3-vigneshr@ti.com>
References: <20181108112647.7205-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181108112647.7205-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Add pinctrl regions for the main and wkup mmr.

The range for main pinctrl region contains a gap
at offset 0x2e4, and because of this, the pinctrl
range is split into two sections.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi        |  1 +
 3 files changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index adcd6341e40c..f7c2a60d5c80 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -69,4 +69,20 @@
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 	};
+
+	main_pmx0: pinmux@11c000 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x11c000 0x0 0x2e4>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_pmx1: pinmux@11c2e8 {
+		compatible = "pinctrl-single";
+		reg = <0x0 0x11c2e8 0x0 0x24>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 8d7b47f9dfbf..19b46f40789b 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -34,6 +34,14 @@
 		};
 	};
 
+	wkup_pmx0: pinmux@4301c000 {
+		compatible = "pinctrl-single";
+		reg = <0x4301c000 0x118>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,am654-uart";
 		reg = <0x42300000 0x100>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 3d4bf369d030..873dca1d0813 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/k3-am65.h>
 
 / {
 	model = "Texas Instruments K3 AM654 SoC";
-- 
2.19.1
