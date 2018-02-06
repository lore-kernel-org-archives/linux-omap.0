From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 13/15] ARM: dts: am57xx-idk: Select pull down for mmc1_clk line in default mode
Date: Tue, 6 Feb 2018 18:28:04 +0530
Message-ID: <20180206125806.19350-14-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206125806.19350-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

During a short period when the bus voltage is switched from 3.3v to 1.8v,
(to enumerate UHS mode), the mmc module is disabled and the mmc IO lines
are kept in a state according to the programmed pad mux pull type.

According to 4.2.4.2 Timing to Switch Signal Voltage in "SD Specifications
Part 1 Physical Layer Specification Version 5.00 February 22, 2016", the
host should hold CLK low for at least 5ms.

In order to keep the card line low during voltage switch, the pad mux of
mmc1_clk line should be configured to pull down.

This is specific to am57xx-idk (and not all dra72/dra74 based boards)
since mmc1_clk line in am57xx-idk is not connected to an external
pullup.

While at that change the order of header files in am571x-idk.dts and
am572x-idk.dts so that the modified pinctrl values in am57xx-idk-common
could take effect.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am571x-idk.dts         |  2 +-
 arch/arm/boot/dts/am572x-idk.dts         |  3 +--
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 11 +++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 6d3c83743156..a2555140babc 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -10,8 +10,8 @@
 #include "dra72x.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "am57xx-idk-common.dtsi"
 #include "dra72x-mmc-iodelay.dtsi"
+#include "am57xx-idk-common.dtsi"
 
 / {
 	model = "TI AM5718 IDK";
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 9ab0af5017df..3a02ed720957 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -9,9 +9,8 @@
 /dts-v1/;
 
 #include "dra74x.dtsi"
-#include "am572x-idk-common.dtsi"
-#include "am57xx-idk-common.dtsi"
 #include "dra74x-mmc-iodelay.dtsi"
+#include "am572x-idk-common.dtsi"
 
 / {
 	model = "TI AM5728 IDK";
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43a6d0590f7c..43cdf523a8a0 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -115,6 +115,17 @@
 			DRA7XX_CORE_IOPAD(0x37d4, MUX_MODE15 | PULL_UP)	/* dcan1_rx.off */
 		>;
 	};
+
+	mmc1_pins_default: mmc1_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+		>;
+	};
 };
 
 &i2c1 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
