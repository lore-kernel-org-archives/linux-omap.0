From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v4 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
Date: Wed, 19 Dec 2012 14:33:08 +0100
Message-ID: <1355923990-21240-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:41660 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab2LSNda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 08:33:30 -0500
In-Reply-To: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Add a generic .dtsi device tree source file for the
common characteristics across IGEP Technology devices.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---

Changes since v3:
    - Remove VSIM regulator definition since now exists on twl4030.dtsi.
    - Add mux pins configuration for MMC device node.

Changes since v2:
    - Associate uart3_pins in uart3 device node.
    - Remove mcbsp2_ins for now until SMSC9221 Ethernet support is added.

 arch/arm/boot/dts/omap3-igep.dtsi |   98 +++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-igep.dtsi

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
new file mode 100644
index 0000000..100eb41
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -0,0 +1,98 @@
+/*
+ * Device Tree Source for IGEP Technology devices
+ *
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
+ * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap3.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "igep2";
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
+};
+
+&omap3_pmx_core {
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e 0x100	/* uart3_rx.uart3_rx INPUT | MODE0 */
+			0x170 0		/* uart3_tx.uart3_tx OUTPUT | MODE0 */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x114 0x0118    /* sdmmc1_clk.sdmmc1_clk INPUT PULLUP | MODE 0 */
+			0x116 0x0118    /* sdmmc1_cmd.sdmmc1_cmd INPUT PULLUP | MODE 0 */
+			0x118 0x0118 	/* sdmmc1_dat0.sdmmc1_dat0 INPUT PULLUP | MODE 0 */
+			0x11a 0x0118	/* sdmmc1_dat1.sdmmc1_dat1 INPUT PULLUP | MODE 0 */
+			0x11c 0x0118	/* sdmmc1_dat2.sdmmc1_dat2 INPUT PULLUP | MODE 0 */
+			0x11e 0x0118	/* sdmmc1_dat3.sdmmc1_dat3 INPUT PULLUP | MODE 0 */
+			0x120 0x0100	/* sdmmc1_dat4.sdmmc1_dat4 INPUT | MODE 0 */
+			0x122 0x0100	/* sdmmc1_dat5.sdmmc1_dat5 INPUT | MODE 0 */
+			0x124 0x0100	/* sdmmc1_dat6.sdmmc1_dat6 INPUT | MODE 0 */
+			0x126 0x0100	/* sdmmc1_dat7.sdmmc1_dat7 INPUT | MODE 0 */
+		>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			      };
+		};
+	};
+};
+
+/include/ "twl4030.dtsi"
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&mmc1 {
+      pinctrl-names = "default";
+      pinctrl-0 = <&mmc1_pins>;
+      vmmc-supply = <&vmmc1>;
+      vmmc_aux-supply = <&vsim>;
+      bus-width = <8>;
+};
+
+&mmc2 {
+	status = "disabled";
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&uart3 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart3_pins>;
+};
+
+&twl_gpio {
+	ti,use-leds;
+};
-- 
1.7.7.6

