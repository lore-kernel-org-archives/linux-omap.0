From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-am65: Add pinctrl regions
Date: Tue, 13 Nov 2018 11:31:09 +0530
Message-ID: <20181113060111.16374-3-vigneshr@ti.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113060111.16374-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
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
index 3d4bf369d030..6fdfc7815811 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/k3.h>
 
 / {
 	model = "Texas Instruments K3 AM654 SoC";
-- 
2.19.1
