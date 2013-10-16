From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V7 6/8] ARM: dts: OMAP5: Add CPU OPP table
Date: Wed, 16 Oct 2013 10:39:06 -0500
Message-ID: <1381937948-27057-7-git-send-email-nm@ti.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381937948-27057-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Add DT OPP table for OMAP54xx family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

The data is based on OMAP543x ES2.0 DM Operating Condition Addendum
Version 0.6(April 2013)

NOTE: The voltage and frequency values work well only on NOM samples
and are supposed to work properly only with ABB/AVS for ALL OPPs.

TODO: Add SPEED BIN OPP after ABB and AVS support so the cpufreq works
on all samples seamlessly. Clock node is pending alignment for clock
dts conversion

[nm-l0cyMroinI0@public.gmane.org: sync to latest and fixes]
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 40aac32..69874de 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -37,6 +37,13 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+
+			operating-points = <
+				/* kHz    uV */
+				500000  880000
+				1000000 1060000
+				1500000 1250000
+			>;
 		};
 		cpu@1 {
 			device_type = "cpu";
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
