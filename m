From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/5] ARM: dts: AM33XX: Add pinctrl binding to gpio-leds node
Date: Wed, 27 Mar 2013 18:29:15 +0530
Message-ID: <1364389156-8273-5-git-send-email-hvaibhav@ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1364389156-8273-1-git-send-email-hvaibhav-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mporter-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Now gpio-leds driver is using devm_pinctrl_get_select_default()
api to set default pinmux configuration required for the
functionality of the driver, so this patch moves respective
pinctrl binding inside leds node.

Signed-off-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts  |    5 ++++-
 arch/arm/boot/dts/am335x-evmsk.dts |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 860630b..1d623e4 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -26,7 +26,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0>;
+		pinctrl-0 = <>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -65,6 +65,9 @@
 	};
 
 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
 		compatible = "gpio-leds";
 
 		led@2 {
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 15a3052..21d5a08 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0 &gpio_keys_s0>;
+		pinctrl-0 = <&gpio_keys_s0>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -121,6 +121,9 @@
 	};
 
 	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
 		compatible = "gpio-leds";
 
 		led@1 {
-- 
1.7.0.4
