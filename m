From: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: dm816x: Correct the state of the write protect pin
Date: Wed, 21 Jun 2017 07:42:27 -0400
Message-ID: <1498045347-27324-2-git-send-email-trini@konsulko.com>
References: <1498045347-27324-1-git-send-email-trini@konsulko.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498045347-27324-1-git-send-email-trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mihail Grigorov <michael.grigorov-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Mihail Grigorov <michael.grigorov-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Commit 599c376c4932 ("ARM: dts: Fix gpio interrupts for dm816x")
corrected some problems with the MMC.  However, it gets the write
protect pin backwards.  It needs to be ACTIVE_HIGH not ACTIVE_LOW.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mihail Grigorov <michael.grigorov-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Signed-off-by: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/dm8168-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 996eba0c2e7a..c72a2132aa82 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -196,7 +196,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 };
 
 /* At least dm8168-evm rev c won't support multipoint, later may */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
