From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] ARM: dts: DRA7: Add timer12 node
Date: Tue, 5 Apr 2016 16:44:10 -0500
Message-ID: <1459892652-47845-3-git-send-email-s-anna@ti.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459892652-47845-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the DT node for Timer12 present on DRA7 family of
SoCs. Timer12 is present in PD_WKUPAON power domain, and
has the same capabilities as the other timers, except for
the fact that it serves as a secure timer on HS devices
and is clocked only from the secure 32K clock.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
Changes from previous post:
Drop status = "disabled" line

 arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 66c7924e5491..955d562c70f0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -773,6 +773,15 @@
 			ti,hwmods = "timer11";
 		};
 
+		timer12: timer@4ae20000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4ae20000 0x80>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer12";
+			ti,timer-alwon;
+			ti,timer-secure;
+		};
+
 		timer13: timer@48828000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48828000 0x80>;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
