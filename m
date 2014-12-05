From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan node
Date: Fri, 5 Dec 2014 11:32:18 -0600
Message-ID: <1417800739-13146-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>

TPS gpio now controls a 5v 500mA TL5209 regulator which may be supply
a fan (such as AFB02505HHB) over J1 connector for various purposes.
Provide device tree node to enable the same.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
Depends on the following:
https://patchwork.kernel.org/patch/5439201/
https://patchwork.kernel.org/patch/5439191/

enable and disable can be controlled by
echo '1' > /sys/class/hwmon/hwmon0/fan1_target
and
echo '0' > /sys/class/hwmon/hwmon0/fan1_target

requires CONFIG_GPIO_PALMAS and CONFIG_SENSORS_GPIO_FAN to be operational
Applies on 
https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.19/dt-v2

 arch/arm/boot/dts/am57xx-beagle-x15.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 49edbda..7fe82ef 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -80,6 +80,15 @@
 			default-state = "off";
 		};
 	};
+
+	gpio_fan {
+		/* Based on 5v 500mA AFB02505HHB */
+		compatible = "gpio-fan";
+		pinctrl-names = "default";
+		gpios =  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <0    0
+				      13000 1>;
+	};
 };
 
 &dra7_pmx_core {
@@ -314,6 +323,12 @@
 			wakeup-source;
 			ti,palmas-long-press-seconds = <12>;
 		};
+
+		tps659038_gpio: tps659038_gpio {
+			compatible = "ti,palmas-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
 	};
 
 	tmp102: tmp102@48 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
