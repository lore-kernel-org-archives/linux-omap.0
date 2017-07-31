From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v2 3/3] tty/serial/8250: add DT bindings description for mctrl_gpio helpers
Date: Mon, 31 Jul 2017 09:13:23 +0200
Message-ID: <1501485203-13185-4-git-send-email-yegorslists@googlemail.com>
References: <1501485203-13185-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501485203-13185-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Describe {rts,cts,dtr,dsr,rng,dcd}-gpios usage.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/8250.txt | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 419ff6c..1c09db2 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -48,6 +48,16 @@ Optional properties:
 - tx-threshold: Specify the TX FIFO low water indication for parts with
   programmable TX FIFO thresholds.
 - resets : phandle + reset specifier pairs
+- rts-gpios:
+- cts-gpios:
+- dtr-gpios:
+- dsr-gpios:
+- rng-gpios:
+- dcd-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
+  line respectively. It will use specified GPIO instead of the peripheral
+  function pin for the UART feature. If unsure, don't specify this property.
+  If "wakeup-source" property is specified for the device this GPIO
+  initialization will be aborted.
 
 Note:
 * fsl,ns16550:
@@ -69,3 +79,19 @@ Example:
 		interrupts = <10>;
 		reg-shift = <2>;
 	};
+
+Example for OMAP UART using GPIO-based modem control signals:
+
+	uart4: serial@49042000 {
+		compatible = "ti,omap3-uart";
+		reg = <0x49042000 0x400>;
+		interrupts = <80>;
+		ti,hwmods = "uart4";
+		clock-frequency = <48000000>;
+		cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
+		rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+		dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
