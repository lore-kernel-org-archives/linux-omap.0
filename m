From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global timer's nodes
Date: Wed, 18 Nov 2015 16:01:55 +0200
Message-ID: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: slash.tmp-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Keep ARM TWD and Global timer's nodes disabled by default - if someone
would like to use them then those nodes have to be enabled explicitly
in board file.

The reason for this change is:
- ARM TWD is not always-on timer on am437x and it will stop in low
  CPUIdle states and, therefore, broadcast timer has to configured
  properly if CPU_IDLE=y.
- ARM Global timer is not always-on timer on am437x and it can't be
  used as clocksource device if CPU_IDLE=y.
- ARM Global timer driver doesn't support CPUfreq now.

Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d83ff9c..11376e3 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -75,6 +75,7 @@
 		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
 		clocks = <&dpll_mpu_m2_ck>;
+		status = "disabled";
 	};
 
 	local_timer: timer@48240600 {
@@ -83,6 +84,7 @@
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
 		clocks = <&dpll_mpu_m2_ck>;
+		status = "disabled";
 	};
 
 	l2-cache-controller@48242000 {
-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
