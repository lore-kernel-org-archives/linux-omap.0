From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [RESEND Patch 3/9] ARM: dts: am43x-epos-evm: add SD card hotplug support
Date: Mon, 3 Mar 2014 20:20:20 +0530
Message-ID: <1393858226-32595-5-git-send-email-mugunthanvnm@ti.com>
References: <1393858226-32595-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393858226-32595-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Add card detect gpio for SD card slot and include dt gpio header.

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi        | 1 +
 arch/arm/boot/dts/am43x-epos-evm.dts | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index b687869..36d523a 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index a3a53ce..167dbc8 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -132,6 +132,12 @@
 				0x19c (PIN_OUTPUT | MUX_MODE3)          /* mcasp0_ahclkr.spi1_cs0 */
 			>;
 		};
+
+		mmc1_pins: pinmux_mmc1_pins {
+			pinctrl-single,pins = <
+				0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -179,6 +185,9 @@
 	status = "okay";
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 };
 
 &mac {
-- 
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
