From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] ARM: dts: am57xx: Introduce industrial grade thermal thresholds
Date: Thu, 28 Apr 2016 15:20:00 +0530
Message-ID: <1461837002-10393-3-git-send-email-j-keerthy@ti.com>
References: <1461837002-10393-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461837002-10393-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, inux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The silicon version ES2.0 onwards are industrial grade samples
and have higher thermal thresholds than commecial grade samples.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-industrial-grade.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/arm/boot/dts/am57xx-industrial-grade.dtsi

diff --git a/arch/arm/boot/dts/am57xx-industrial-grade.dtsi b/arch/arm/boot/dts/am57xx-industrial-grade.dtsi
new file mode 100644
index 0000000..70c8c4b
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-industrial-grade.dtsi
@@ -0,0 +1,23 @@
+&cpu_alert0 {
+	temperature = <90000>; /* milliCelsius */
+};
+
+&cpu_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&gpu_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&core_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&dspeve_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&iva_crit {
+	temperature = <105000>; /* milliCelsius */
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
