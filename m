From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am437x: pixcir_tangoc: use correct flags for irq types
Date: Mon, 28 Dec 2015 15:52:39 +0200
Message-ID: <1451310759-29536-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Now IRQs for Pixcir Tangoc touchscreen are defined using
IRQ_TYPE_NONE in am437x-gp-evm.dts and am43x-epos-evm.dts wich
do not correspond HW.

Hence, update am437x-gp-evm.dts and am43x-epos-evm.dts files
and use correct flag IRQ_TYPE_EDGE_FALLING for irq types.

While here, remove duplicated irq declaration for pixcir_ts@5c node
in am437x-gp-evm.dts.

Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 4 +---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index d2450ab..fc4c371 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -590,8 +590,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pixcir_ts_pins>;
 		reg = <0x5c>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <22 0>;
 
 		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 
@@ -599,7 +597,7 @@
 		 * 0x264 represents the offset of padconf register of
 		 * gpio3_22 from am43xx_pinmux base.
 		 */
-		interrupts-extended = <&gpio3 22 IRQ_TYPE_NONE>,
+		interrupts-extended = <&gpio3 22 IRQ_TYPE_EDGE_FALLING>,
 				      <&am43xx_pinmux 0x264>;
 		interrupt-names = "tsc", "wakeup";
 
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 47954ed..29c6580 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -491,7 +491,7 @@
 		pinctrl-0 = <&pixcir_ts_pins>;
 		reg = <0x5c>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <17 0>;
+		interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
 
 		attb-gpio = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
