From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 09/11] arm64: exynos: Add bus1 pinctrl node on exynos7
Date: Fri, 21 Nov 2014 19:05:52 +0530
Message-ID: <1416576954-11997-10-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

BUS1 pinctrl provides gpios for usb and power regulator
available on exynos7-espresso board. So add relevant device
node for pinctrl-bus1.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |   26 +++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |    7 ++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
index 2eef4a2..9648e03 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
@@ -335,6 +335,32 @@
 	};
 };
 
+&pinctrl_bus1 {
+	gpf0: gpf0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf4: gpf4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gph1: gph1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
 &pinctrl_nfc {
 	gpj0: gpj0 {
 		gpio-controller;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index d7a37c3..90048b2 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -26,6 +26,7 @@
 		pinctrl5 = &pinctrl_ese;
 		pinctrl6 = &pinctrl_fsys0;
 		pinctrl7 = &pinctrl_fsys1;
+		pinctrl8 = &pinctrl_bus1;
 	};
 
 	cpus {
@@ -242,6 +243,12 @@
 			interrupts = <0 383 0>;
 		};
 
+		pinctrl_bus1: pinctrl@14870000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x14870000 0x1000>;
+			interrupts = <0 384 0>;
+		};
+
 		pinctrl_nfc: pinctrl@14cd0000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x14cd0000 0x1000>;
-- 
1.7.10.4
