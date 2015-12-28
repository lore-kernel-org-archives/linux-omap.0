From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am4372: fix irq type for arm twd and global timer
Date: Mon, 28 Dec 2015 15:52:04 +0200
Message-ID: <1451310724-29454-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As per ARM documentation
PPI(0) ID27 - global timer interrupt is rising-edge sensitive.
PPI(2) ID29 - twd interrupt is rising-edge sensitive.

and the same is proved by GIC distributor register value
GIC_DIST_CONFIG(0xC04) = 0x7DC00000.

Hence, set IRQ triggering type to IRQ_TYPE_EDGE_RISING
for ARM TWD and Global timers.

Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index de8791a..dfa1a29 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -72,7 +72,7 @@
 	global_timer: timer@48240200 {
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0x48240200 0x100>;
-		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 		interrupt-parent = <&gic>;
 		clocks = <&mpu_periphclk>;
 	};
@@ -80,7 +80,7 @@
 	local_timer: timer@48240600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x48240600 0x100>;
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_EDGE_RISING>;
 		interrupt-parent = <&gic>;
 		clocks = <&mpu_periphclk>;
 	};
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
