From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] ARM: dts: DRA7: Enable Timers 13 through 16
Date: Tue, 5 Apr 2016 16:44:09 -0500
Message-ID: <1459892652-47845-2-git-send-email-s-anna@ti.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459892652-47845-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The Timers 13 through 16 have been added previously in
disabled state. These timers are common timers that are
present on all DRA7 family of SoCs, so enable these
devices by default like the rest of the DMTimers.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 13ac88279427..66c7924e5491 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -778,7 +778,6 @@
 			reg = <0x48828000 0x80>;
 			interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer13";
-			status = "disabled";
 		};
 
 		timer14: timer@4882a000 {
@@ -786,7 +785,6 @@
 			reg = <0x4882a000 0x80>;
 			interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer14";
-			status = "disabled";
 		};
 
 		timer15: timer@4882c000 {
@@ -794,7 +792,6 @@
 			reg = <0x4882c000 0x80>;
 			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer15";
-			status = "disabled";
 		};
 
 		timer16: timer@4882e000 {
@@ -802,7 +799,6 @@
 			reg = <0x4882e000 0x80>;
 			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer16";
-			status = "disabled";
 		};
 
 		wdt2: wdt@4ae14000 {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
