From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/27] clk: ti: clkctrl: add support for retrying failed init
Date: Mon, 30 Oct 2017 15:04:23 +0200
Message-ID: <1509368685-29112-6-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

In case the clkctrl node contains assigned-clock-* entries, registering
the provider can fail with -EPROBE_DEFER. In this case, add the
provider to the retry_init clock list so it will be cleaned up later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clkctrl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 91ddc92..0f78219 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -403,6 +403,12 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
 	}
 }
 
+static void __init _clkctrl_add_provider(void *data,
+					 struct device_node *np)
+{
+	of_clk_add_hw_provider(np, _ti_omap4_clkctrl_xlate, data);
+}
+
 static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 {
 	struct omap_clkctrl_provider *provider;
@@ -414,6 +420,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	struct omap_clkctrl_clk *clkctrl_clk;
 	const __be32 *addrp;
 	u32 addr;
+	int ret;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
 	addr = (u32)of_translate_address(node, addrp);
@@ -508,7 +515,11 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		reg_data++;
 	}
 
-	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	ret = of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	if (ret == -EPROBE_DEFER)
+		ti_clk_retry_init(node, (void *)provider,
+				  (ti_of_clk_init_cb_t)_clkctrl_add_provider);
+
 	return;
 
 cleanup:
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
