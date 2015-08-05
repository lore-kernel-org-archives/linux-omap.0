From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/8] rtc: omap: Add external clock enabling support
Date: Wed, 5 Aug 2015 16:19:47 +0530
Message-ID: <1438771792-12604-4-git-send-email-j-keerthy@ti.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438771792-12604-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Based on the board property switch the source from internal
to external clock. Switching to external source is needed for
rtcwake to work in low power modes.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  2 ++
 drivers/rtc/rtc-omap.c                             | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index 4ba4dbd..0c44755 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -15,6 +15,7 @@ Required properties:
 Optional properties:
 - system-power-controller: whether the rtc is controlling the system power
   through pmic_power_en
+- ext-clk-src: Whether the rtc can be sourced by external clock
 
 Example:
 
@@ -25,4 +26,5 @@ rtc@1c23000 {
 		      19>;
 	interrupt-parent = <&intc>;
 	system-power-controller;
+	ext-clk-src;
 };
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 8b6355f..cb8936a 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -107,6 +107,7 @@
 
 /* OMAP_RTC_OSC_REG bit fields: */
 #define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
+#define OMAP_RTC_OSC_SEL_32KCLK_SRC	BIT(3)
 
 /* OMAP_RTC_IRQWAKEEN bit fields: */
 #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
@@ -136,6 +137,7 @@ struct omap_rtc {
 	int irq_timer;
 	u8 interrupts_reg;
 	bool is_pmic_controller;
+	bool is_ext_src;
 	const struct omap_rtc_device_type *type;
 };
 
@@ -540,6 +542,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
 				of_property_read_bool(pdev->dev.of_node,
 						"system-power-controller");
+		rtc->is_ext_src = of_property_read_bool(pdev->dev.of_node,
+						"ext-clk-src");
 	} else {
 		id_entry = platform_get_device_id(pdev);
 		rtc->type = (void *)id_entry->driver_data;
@@ -627,6 +631,12 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (reg != new_ctrl)
 		rtc_write(rtc, OMAP_RTC_CTRL_REG, new_ctrl);
 
+	if (rtc->is_ext_src) {
+		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
+		rtc_writel(rtc, OMAP_RTC_OSC_REG,
+			   reg | OMAP_RTC_OSC_SEL_32KCLK_SRC);
+	}
+
 	rtc->type->lock(rtc);
 
 	device_init_wakeup(&pdev->dev, true);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
