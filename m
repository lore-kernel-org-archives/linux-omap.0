From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] dt-bindings: power/supply: Update TPS65217 properties
Date: Fri,  9 Dec 2016 15:28:32 +0900
Message-ID: <20161209062833.5768-4-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209062833.5768-1-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add interrupt specifiers for USB and AC charger input. Interrupt numbers
are from the datasheet.
Fix wrong property for compatible string.

Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
index 98d131a..a11072c 100644
--- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
@@ -2,11 +2,16 @@ TPS65217 Charger
 
 Required Properties:
 -compatible: "ti,tps65217-charger"
+-interrupts: TPS65217 interrupt numbers for the AC and USB charger input change.
+             Should be <0> for the USB charger and <1> for the AC adapter.
+-interrupt-names: Should be "USB" and "AC"
 
 This node is a subnode of the tps65217 PMIC.
 
 Example:
 
 	tps65217-charger {
-		compatible = "ti,tps65090-charger";
+		compatible = "ti,tps65217-charger";
+		interrupts = <0>, <1>;
+		interrupt-names = "USB", "AC";
 	};
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
