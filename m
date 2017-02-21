From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am57xx-idk: Add DCAN support
Date: Tue, 21 Feb 2017 15:30:03 +0530
Message-ID: <8981d49e7011a7246ff7dc6a9a9da0a56dfe5621.1487670384.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>

AM571x IDK and the AM572x IDK use CAN1 interface.
This patch enables it for both boards.

Tested on AM572x IDK using cansequence.

Signed-off-by: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
[nsekhar-l0cyMroinI0@public.gmane.org: move to use DRA7XX_CORE_IOPAD())
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 814a720d5c3d..abdee2e7a18e 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -97,6 +97,22 @@
 	};
 };
 
+&dra7_pmx_core {
+	dcan1_pins_default: dcan1_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37d0, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* dcan1_tx */
+			DRA7XX_CORE_IOPAD(0x37d4, PIN_INPUT_PULLUP | MUX_MODE0)		/* dcan1_rx */
+		>;
+	};
+
+	dcan1_pins_sleep: dcan1_pins_sleep {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37d0, MUX_MODE15 | PULL_UP)	/* dcan1_tx.off */
+			DRA7XX_CORE_IOPAD(0x37d4, MUX_MODE15 | PULL_UP)	/* dcan1_rx.off */
+		>;
+	};
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
@@ -387,6 +403,14 @@
 	max-frequency = <96000000>;
 };
 
+&dcan1 {
+	status = "okay";
+	pinctrl-names = "default", "sleep", "active";
+	pinctrl-0 = <&dcan1_pins_sleep>;
+	pinctrl-1 = <&dcan1_pins_sleep>;
+	pinctrl-2 = <&dcan1_pins_default>;
+};
+
 &qspi {
 	status = "okay";
 
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
