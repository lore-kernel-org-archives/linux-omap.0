From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: AM335X-evm: Add the internal and external clock nodes for rtc
Date: Thu, 27 Oct 2016 11:18:07 +0530
Message-ID: <1477547288-5041-3-git-send-email-j-keerthy@ti.com>
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
 arch/arm/boot/dts/am335x-evm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e82432c..c2186ec 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -783,3 +783,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&dcan1_pins_default>;
 };
+
+&rtc {
+	clocks = <&clk_32768_ck>, <&clkdiv32k_ick>;
+	clock-names = "ext-clk", "int-clk";
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
