From: Adam Ford <aford173@gmail.com>
Subject: [RFC v2] ARM: dts: omap36xx: Enable thermal throttling
Date: Fri, 13 Sep 2019 11:49:19 -0500
Message-ID: <20190913164919.4565-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: neolynx@gmail.com, letux-kernel@openphoenux.org, andreas@kemnade.info, tony@atomide.com, adam.ford@logicpd.com, hns@goldelico.com, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The thermal sensor in the omap3 family isn't accurate, but it's
better than nothing.  The various OPP's enabled for the omap3630
support up to OPP1G, however the datasheet for the DM3730 states
that OPP130 and OPP1G are not available above TJ of 90C.

This patch configures the thermal throttling to limit the
operating points of the omap3630 to Only OPP50 and OPP100 if
the thermal sensor reads a value above 90C.

When forcing the high-temperature state, the scaling_max_freq
returns a value that corresponds to OPP100 showing that
OPP130 and OPP1G are not available.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Rebase after moving thermal info into a common omap3.
     This now only changes the cooling-device reference to remove the fastest
     two OPP's
     
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 77e9fcf60ba7..d8ba513f3deb 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -219,6 +219,13 @@
 	};
 };
 
+&cpu_cooling_maps {
+	map0 {
+		/* OPP130 and OPP1G are not available above 90C */
+		cooling-device = <&cpu 1 2>;
+	};
+};
+
 /* OMAP3630 needs dss_96m_fck for VENC */
 &venc {
 	clocks = <&dss_tv_fck>, <&dss_96m_fck>;
-- 
2.17.1
