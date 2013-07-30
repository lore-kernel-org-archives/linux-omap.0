From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] arm: dts: omap4-panda-common: add WiLink6 device tree nodes
Date: Tue, 30 Jul 2013 20:27:26 +0300
Message-ID: <1375205248-25708-3-git-send-email-coelho@ti.com>
References: <1375205248-25708-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375205248-25708-1-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, coelho-l0cyMroinI0@public.gmane.org, luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add the WiLink device tree nodes.  On omap4-panda, a WiLink6 module is
connected on MMC5 and a GPIO interrupt is used.  The refclock
frequency is 38.4MHz.

Signed-off-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index b3f6e1f..77e4a42 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -117,6 +117,20 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	wlan {
+		compatible = "ti,wilink6";
+		interrupt-parent = <&gpio2>;
+		interrupts = <21 0x4>;	/* gpio line 53, high level triggered */
+		clocks = <&refclock>;
+		clock-names = "refclock";
+
+		refclock: refclock {
+			compatible = "ti,wilink-clock";
+			#clock-cells = <0>;
+			clock-frequency = <38400000>;
+		};
+	 };
 };
 
 &omap4_pmx_wkup {
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
