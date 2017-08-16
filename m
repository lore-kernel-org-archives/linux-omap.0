From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] ARM: dts: am57xx-beagle-x15: Add support for rev C
Date: Wed, 16 Aug 2017 11:50:53 -0500
Message-ID: <20170816165053.19450-1-robertcnelson@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Latest update to the BeagleBoard-X15 platform (revision C). This board contains
a silicon update (Rev 2.0), which includes a fix for the 2nd ethernet phy when
running at 1000 Mbps speeds.

This board can be indentified by the [C.00] after [BBRDX15_] in the at24 eeprom:
[BBRDX15_C.001731PX150249]

Rev C is now in full production and boards are available for end users.

https://beagleboard.org/x15
https://github.com/beagleboard/beagleboard-x15/

Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
CC: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
CC: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
CC: Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
---
v2: Rework based on Kishon's [PATCH v2 00/10] ARM: dts: Add iodelay data for MMC
---
---
 arch/arm/boot/dts/Makefile                   |  1 +
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts | 39 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 570e107bf702..d51c0def01de 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -656,6 +656,7 @@ dtb-$(CONFIG_SOC_OMAP5) += \
 dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-beagle-x15.dtb \
 	am57xx-beagle-x15-revb1.dtb \
+	am57xx-beagle-x15-revc.dtb \
 	am57xx-cl-som-am57x.dtb \
 	am57xx-sbc-am57x.dtb \
 	am572x-idk.dtb \
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
new file mode 100644
index 000000000000..17c41da3b55f
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "am57xx-beagle-x15-common.dtsi"
+
+/ {
+	model = "TI AM5728 BeagleBoard-X15 rev C";
+};
+
+&tpd12s015 {
+	gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
+		<&gpio2 30 GPIO_ACTIVE_HIGH>,	/* gpio2_30, LS OE */
+		<&gpio7 12 GPIO_ACTIVE_HIGH>;	/* gpio7_12/sp1_cs2, HPD */
+};
+
+&mmc1 {
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev20_conf>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&ldo1_reg>;
+};
+
+&mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_rev20>;
+};
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
