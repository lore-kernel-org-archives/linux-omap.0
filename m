From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: AM4372: Add the am4372-rtc compatible string
Date: Fri, 7 Aug 2015 10:37:19 +0530
Message-ID: <1438924039-4913-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

am4372-rtc string was already part of dts, introduced to identify
the rtc specific to am4372 family of SoCs. It was removed in one of the
previous patches. Adding back the same with appropriate documentation.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/rtc/rtc-omap.txt | 1 +
 arch/arm/boot/dts/am4372.dtsi                      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index 4ba4dbd..43a8366 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -8,6 +8,7 @@ Required properties:
 			    Wakeup generation for event Alarm. It can also be
 			    used to control an external PMIC via the
 			    pmic_power_en pin.
+	- "ti,am4372-rtc" - for RTC IP used similar to that on AM437X SoC family.
 - reg: Address range of rtc register set
 - interrupts: rtc timer, alarm interrupts in order
 - interrupt-parent: phandle for the interrupt controller
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 65c4334..d99b2ee 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -330,7 +330,8 @@
 		};
 
 		rtc: rtc@44e3e000 {
-			compatible = "ti,am3352-rtc", "ti,da830-rtc";
+			compatible = "ti,am4372-rtc", "ti,am3352-rtc",
+				     "ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
