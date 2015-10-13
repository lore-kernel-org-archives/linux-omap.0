From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
Date: Tue, 13 Oct 2015 10:18:48 -0700
Message-ID: <1444756728-11185-3-git-send-email-tony@atomide.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444756728-11185-1-git-send-email-tony@atomide.com>
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
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With omap5-board-common.dtsi, we can now easily add support for various omap5
board variants. Let's add minimal support for isee igepv5.

So far I've tested that basic things work, such as serial, USB Ethernet, HDMI
and WLAN.

Note that like omap5-uevm, these boards seem to need to reserve 16MB for a
trap section as in commit 03178c66d289 ("ARM: dts: omap5-evm: Update
available memory to 2032 MB") and also noted in a u-boot commit at
http://marc.info/?l=u-boot&m=134376852603255 and also at
http://patchwork.ozlabs.org/patch/159881/.

Not sure why this is not needed for omap5-cm-t54.dts, maybe because of
different u-boot configuration.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Enric, can you please check if there are some critical pieces compared
to omap5-uevm that should be updated for this patch?

---
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/omap5-igep0050.dts | 54 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap5-igep0050.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e45d771..2c12411 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -471,6 +471,7 @@ dtb-$(CONFIG_SOC_AM43XX) += \
 	am437x-gp-evm.dtb
 dtb-$(CONFIG_SOC_OMAP5) += \
 	omap5-cm-t54.dtb \
+	omap5-igep0050.dtb \
 	omap5-sbc-t54.dtb \
 	omap5-uevm.dtb
 dtb-$(CONFIG_SOC_DRA7XX) += \
diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
new file mode 100644
index 0000000..46ecb1d
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap5-board-common.dtsi"
+
+/ {
+	model = "IGEPv5";
+	compatible = "isee,omap5-igep0050", "ti,omap5";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x7f000000>; /* 2032 MB */
+	};
+};
+
+&hdmi {
+	vdda-supply = <&ldo7_reg>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+
+	tca6416: tca6416@21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&omap5_pmx_core {
+	i2c4_pins: pinmux_i2c4_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x0f8, PIN_INPUT | MUX_MODE0)	/* i2c4_scl */
+			OMAP5_IOPAD(0x0fa, PIN_INPUT | MUX_MODE0)	/* i2c4_sda */
+		>;
+	};
+};
+
+&tpd12s015 {
+	gpios = <&tca6416 11 0>,	/* TCA6416 P01, CT_CP_HDP */
+		<&tca6416 12 0>,	/* TCA6416 P00, LS_OE*/
+		<&gpio7 1 0>,		/* 193, HPD */
+		<&gpio7 2 0>,		/* 194, SCL */
+		<&gpio7 3 0>;		/* 195, SDA */
+};
+
-- 
2.1.4
