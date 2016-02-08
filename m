From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
Date: Mon, 8 Feb 2016 15:15:05 +0530
Message-ID: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The thermal threholds for am57xx are different from that of dra7.
Correcting the thresholds for the same.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---

Depends on: https://lkml.org/lkml/2016/2/8/90

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux/arch/arm/boot/dts/am57xx-beagle-x15.dts
===================================================================
--- linux.orig/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.514959101 +0530
+++ linux/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.510959168 +0530
@@ -825,3 +825,27 @@
 		status = "okay";
 	};
 };
+
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
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
