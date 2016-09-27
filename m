From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 2/3] DT: EVM: add LEDs
Date: Tue, 27 Sep 2016 07:26:09 +0200
Message-ID: <d68619a23d642eacf12fd0a3c51f19d006436cbe.1474953969.git.hns@goldelico.com>
References: <cover.1474953969.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1474953969.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1474953969.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1474953969.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index be659e8..19f5f0a 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -17,6 +17,66 @@
 		device_type = "memory";
 		reg = <0x80000000 0x7F000000>; /* 2032 MB */
 	};
+
+	evm_leds {
+		compatible = "gpio-leds";
+
+		led@1 {
+			label = "omap5:red:led";
+			gpios = <&gpio9 17 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led@2 {
+			label = "omap5:green:led";
+			gpios = <&gpio9 18 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+			default-state = "off";
+		};
+
+		led@3 {
+			label = "omap5:blue:led";
+			gpios = <&gpio9 19 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc2";
+			default-state = "off";
+		};
+
+		led@4 {
+			label = "omap5:green:led1";
+			gpios = <&gpio9 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+			default-state = "off";
+		};
+
+		led@5 {
+			label = "omap5:green:led2";
+			gpios = <&gpio9 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+			default-state = "off";
+		};
+
+		led@6 {
+			label = "omap5:green:led3";
+			gpios = <&gpio9 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led@7 {
+			label = "omap5:green:led4";
+			gpios = <&gpio9 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led@8 {
+			label = "omap5:green:led5";
+			gpios = <&gpio9 6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
 };
 
 &hdmi {
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
