From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/1] clk: ti: add support for external clock provider
Date: Fri, 1 Aug 2014 16:15:48 +0300
Message-ID: <1406898948-26113-2-git-send-email-t-kristo@ti.com>
References: <1406898948-26113-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42725 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbaHANPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2014 09:15:06 -0400
In-Reply-To: <1406898948-26113-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, linux-omap@vger.kernel.org, sassmann@kpanic.de, peter.ujfalusi@ti.com, jsarha@ti.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

External clock provider can now be used to register external clocks under
it. This is needed as the TI clock driver only registers clocks
hierarchically under clock providers, and external clocks do not belong
under any of the current ones.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ext-clocks.txt    |   32 ++++++++++++++++++++
 arch/arm/mach-omap2/io.c                           |   12 ++++++--
 drivers/clk/ti/clk.c                               |   23 ++++++++++++++
 include/linux/clk/ti.h                             |    2 ++
 4 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/ext-clocks.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/ext-clocks.txt b/Documentation/devicetree/bindings/arm/omap/ext-clocks.txt
new file mode 100644
index 0000000..8e784bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/ext-clocks.txt
@@ -0,0 +1,32 @@
+TI external clock provider properties
+
+External clock provider is used to group SoC external board specific
+clock nodes. A separate provider node is required as the TI clock
+driver registers clocks hierarchically.
+
+Required properties:
+- compatible:		Shall be: "ti,external-clocks"
+- clocks:		Contains the external clocks for the board
+- clockdomains:		Contains the external clockdomains for the board
+
+Example:
+
+ext_clocks {
+	compatible = "ti,external-clocks";
+
+	ext_clocks: clocks {
+	};
+
+	ext_clockdomains: clockdomains {
+	};
+};
+
+...
+
+&ext_clocks {
+	gpio_test_clock {
+		compatible = "gpio-clock";
+		#clock-cells = <0>;
+		enable-gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8f55945..77be18b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -21,6 +21,8 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
@@ -729,8 +731,14 @@ int __init omap_clk_init(void)
 		return 0;
 
 	ret = of_prcm_init();
-	if (!ret)
-		ret = omap_clk_soc_init();
+	if (ret)
+		return ret;
+
+	ret = ti_dt_clk_ext_init();
+	if (ret)
+		return ret;
+
+	ret = omap_clk_soc_init();
 
 	return ret;
 }
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index b1a6f71..c84ce4d 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -165,3 +165,26 @@ void ti_dt_clk_init_provider(struct device_node *parent, int index)
 		kfree(retry);
 	}
 }
+
+static struct of_device_id ti_ext_clk_match_table[] = {
+	{ .compatible = "ti,external-clocks" },
+	{ }
+};
+
+/**
+ * ti_dt_clk_ext_init - initialize external clocks from DT
+ *
+ * Some clocks are provided from external chips outside the main SoC.
+ * The details for these are given under a special DT node, which will
+ * be parsed by this function.
+ */
+int ti_dt_clk_ext_init(void)
+{
+	struct device_node *np;
+
+	for_each_matching_node(np, ti_ext_clk_match_table) {
+		ti_dt_clk_init_provider(np, -1);
+	}
+
+	return 0;
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index e8d8a35..188270c 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -310,6 +310,8 @@ int am43xx_dt_clk_init(void);
 int omap2420_dt_clk_init(void);
 int omap2430_dt_clk_init(void);
 
+int ti_dt_clk_ext_init(void);
+
 #ifdef CONFIG_OF
 void of_ti_clk_allow_autoidle_all(void);
 void of_ti_clk_deny_autoidle_all(void);
-- 
1.7.9.5

