From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/6] ARM: dts: AM43XX: Add clk_32k_rtc node
Date: Mon, 10 Aug 2015 14:58:21 +0530
Message-ID: <1439198906-31189-2-git-send-email-j-keerthy@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439198906-31189-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
Cc: galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add the clk_32k_rtc this is the external clock source
for the rtc.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 6 ++++++
 drivers/clk/ti/clk-43xx.c            | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index d0c0dfa..31f1d96 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -159,6 +159,12 @@
 		clock-frequency = <32768>;
 	};
 
+	clk_32k_rtc: clk_32k_rtc {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
 	clk_rc32k_ck: clk_rc32k_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 3795fce..af393c2 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -22,6 +22,7 @@
 static struct ti_dt_clk am43xx_clks[] = {
 	DT_CLK(NULL, "clk_32768_ck", "clk_32768_ck"),
 	DT_CLK(NULL, "clk_rc32k_ck", "clk_rc32k_ck"),
+	DT_CLK(NULL, "clk_32k_rtc", "clk_32k_rtc"),
 	DT_CLK(NULL, "virt_19200000_ck", "virt_19200000_ck"),
 	DT_CLK(NULL, "virt_24000000_ck", "virt_24000000_ck"),
 	DT_CLK(NULL, "virt_25000000_ck", "virt_25000000_ck"),
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
