From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/8] ARM: dts: dra7: Add MPU OPP supply node
Date: Tue, 19 Dec 2017 09:24:20 -0600
Message-ID: <1513697066-27732-3-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the OPP supply node for the MPU voltage rail to provide the
information needed by the ti-opp-supply driver to enable AVS Class 0.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d9f60144793b..33004e7f1ee9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -2057,6 +2057,19 @@
 			clocks = <&l3_iclk_div>;
 			clock-names = "fck";
 		};
+
+		opp_supply_mpu: opp-supply@4a003b20 {
+			compatible = "ti,omap5-opp-supply";
+			reg = <0x4a003b20 0xc>;
+			ti,efuse-settings = <
+			/* uV   offset */
+			1060000 0x0
+			1160000 0x4
+			1210000 0x8
+			>;
+			ti,absolute-max-voltage-uv = <1500000>;
+		};
+
 	};
 
 	thermal_zones: thermal-zones {
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
