From: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 2/2] ARM: am33xx.dtsi: Added syscon compatible prcm_dev device
Date: Tue, 15 Nov 2016 09:44:04 +0100
Message-ID: <3071466.kDDk30H73u@corpeters>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch adds the PRM_DEV as a syscon compatible device to
am33xx.dtsi. This is needed for the watchdog bootstatus patch.

Signed-off-by: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 194d884..e8faf19 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -115,6 +115,7 @@
                        prcm: prcm@200000 {
                                compatible = "ti,am3-prcm";
                                reg = <0x200000 0x4000>;
+                               ranges = <0 0x200000 0x4000>;
 
                                prcm_clocks: clocks {
                                        #address-cells = <1>;
@@ -123,6 +124,11 @@
 
                                prcm_clockdomains: clockdomains {
                                };
+
+                               prcm_wkup: prcm-wkup@f00 {
+                                       compatible = "ti,omap3-prcm-dev", "syscon";
+                                       reg = <0xf00 0xff>;
+                               };
                        };
 
                        scm: scm@210000 {
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
