From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] ARM: dts: DRA7: Add timer12 node
Date: Thu, 1 Oct 2015 14:32:39 -0500
Message-ID: <1443727960-32232-4-git-send-email-s-anna@ti.com>
References: <1443727960-32232-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443727960-32232-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the DT node for Timer12 present on DRA7 family of
SoCs. Timer12 is present in PD_WKUPAON power domain, and
has the same capabilities as the other timers, except for
the fact that it serves as a secure timer on HS devices
and is clocked only from the secure 32K clock.

The node is marked disabled for now, and the kernel should
refrain from using this secure timer on HS devices.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e289c706d27d..37d632dad576 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -762,6 +762,16 @@
 			ti,hwmods = "timer11";
 		};
 
+		timer12: timer@4ae20000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4ae20000 0x80>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer12";
+			ti,timer-alwon;
+			ti,timer-secure;
+			status = "disabled";
+		};
+
 		timer13: timer@48828000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48828000 0x80>;
-- 
2.6.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
