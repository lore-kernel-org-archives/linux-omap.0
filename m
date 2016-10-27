From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] ARM: dts: AM335X-bone-common: Add the internal and external clock nodes for rtc
Date: Thu, 27 Oct 2016 11:18:06 +0530
Message-ID: <1477547288-5041-2-git-send-email-j-keerthy@ti.com>
References: <1477547288-5041-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477547288-5041-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

rtc can either be supplied from internal 32k clock or external crystal
generated 32k clock. Internal clock is SoC specific and the external
clock is board dependent. Assigning the corresponding clocks.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 5 +++++
 arch/arm/boot/dts/am33xx.dtsi             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 007b5e5..ca9f7ce 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -393,3 +393,8 @@
 &sham {
 	status = "okay";
 };
+
+&rtc {
+	clocks = <&clk_32768_ck>, <&clkdiv32k_ick>;
+	clock-names = "ext-clk", "int-clk";
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 194d884..d52fa1c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -505,6 +505,8 @@
 			interrupts = <75
 				      76>;
 			ti,hwmods = "rtc";
+			clocks = <&clkdiv32k_ick>;
+			clock-names = "int-clk";
 		};
 
 		spi0: spi@48030000 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
