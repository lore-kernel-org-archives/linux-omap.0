From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 11/15] ARM: dts: dra71-evm: Correct evm_sd regulator max voltage
Date: Tue, 6 Feb 2018 18:28:02 +0530
Message-ID: <20180206125806.19350-12-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206125806.19350-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>

Correct vpo_sd_1v8_3v3 regulator max voltage to 3.3V

Fixes: 9868bc585ae2 ("ARM: dts: Add support for dra718-evm")
Signed-off-by: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra71-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 41c9132eb550..64363f75c01a 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -24,13 +24,13 @@
 
 		regulator-name = "vddshv8";
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		vin-supply = <&evm_5v0>;
 
 		gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0
-			  3000000 0x1>;
+			  3300000 0x1>;
 	};
 
 	evm_1v8_sw: fixedregulator-evm_1v8 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
