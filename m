From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v3 3/3] ARM: dts: dra7-evm: Add extcon nodes for USB ID pin detection
Date: Wed, 28 Aug 2013 23:03:05 +0530
Message-ID: <1377711185-31238-4-git-send-email-george.cherian@ti.com>
References: <1377711185-31238-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1377711185-31238-1-git-send-email-george.cherian@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, bcousson@baylibre.com, davidb@codeaurora.org, arnd@arndb.de, swarren@nvidia.com, popcornmix@gmail.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Add
	-extcon nodes for USB ID pin detection.
	-i2c nodes.
	-pcf nodes to which USB ID pin is connected.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 50 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index acd3c09..8b0738a 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -17,6 +17,17 @@
 		device_type = "memory";
 		reg = <0x80000000 0x60000000>; /* 1536 MB */
 	};
+
+	extcon1: gpio_usbvid_extcon1 {
+		compatible = "ti,gpio-usb-id";
+		gpios = <&gpio21 1 0>;
+	};
+
+	extcon2: gpio_usbvid_extcon2 {
+		compatible = "ti,gpio-usb-id";
+		gpios = <&gpio21 2 0>;
+	};
+
 };
 
 &dra7_pmx_core {
@@ -33,10 +44,47 @@
         };
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+
+	gpio20: pcf8575@20 {
+		compatible = "ti,pcf8575";
+		reg = <0x20>;
+		n_latch = <0x4000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio21: pcf8575@21 {
+		compatible = "ti,pcf8575";
+		reg = <0x21>;
+		n_latch = <0x1408>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&pcf_20>;
+		interrupts = <14 2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+};
+
 &dwc3_1 {
-	dr_mode = "otg";
+	dr_mode = "host";
 };
 
 &dwc3_2 {
 	dr_mode = "host";
 };
+
+&usb1 {
+	extcon = <&extcon1>;
+};
+
+&usb2 {
+	extcon = <&extcon2>;
+};
-- 
1.8.1.4

