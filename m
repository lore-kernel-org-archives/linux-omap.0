From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH] ARM: dts: am335x-chilisom: Wakeup from RTC-only state by power on event
Date: Fri,  9 Dec 2016 12:33:27 +0100
Message-ID: <20161209113327.19727-1-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On chiliSOM TPS65217 nWAKEUP pin is connected to AM335x internal RTC
EXT_WAKEUP input. In RTC-only state TPS65217 is notifying about power on
events (such as power buton presses) by setting nWAKEUP output
low. After that it waits 5s for proper device boot. Currently it doesn't
happen, as the processor doesn't listen for such events. Consequently
TPS65217 changes state from SLEEP (RTC-only state) to OFF.

Enable EXT_WAKEUP input of AM335x's RTC, so the processor can properly
detect power on events and recover immediately from RTC-only states,
without powering off RTC and losing time.

Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
---
 arch/arm/boot/dts/am335x-chilisom.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index f9ee585..1b43ebd 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -124,6 +124,14 @@
 
 &rtc {
 	system-power-controller;
+
+	pinctrl-0 = <&ext_wakeup>;
+	pinctrl-names = "default";
+
+	ext_wakeup: ext-wakeup {
+		pins = "ext_wakeup0";
+		input-enable;
+	};
 };
 
 /* NAND Flash */
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
