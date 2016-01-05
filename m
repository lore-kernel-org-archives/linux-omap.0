From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: omap5-board-common: enable iio gpadc for Palmas
Date: Tue,  5 Jan 2016 13:01:38 +0100
Message-ID: <597ffe6d0b9178ae2901949dc33c5ae27b1bdedd.1451995297.git.hns@goldelico.com>
References: <cover.1451995297.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1451995297.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1451995297.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1451995297.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

tested on OMP5432 EVM

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 30c0d3b..56429ce 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -366,6 +366,16 @@
 			ti,backup-battery-charge-high-current;
 		};
 
+		gpadc {
+			compatible = "ti,palmas-gpadc";
+			interrupts = <18 0
+				      16 0
+				      17 0>;
+			#io-channel-cells = <1>;
+			ti,channel0-current-microamp = <5>;
+			ti,channel3-current-microamp = <10>;
+		};
+
 		palmas_pmic {
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
