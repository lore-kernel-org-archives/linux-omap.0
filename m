From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 06/28] clk: ti: clkctrl: add support for retrying failed init
Date: Thu, 9 Nov 2017 11:15:16 +0200
Message-ID: <1510218917-1725-4-git-send-email-t-kristo@ti.com>
References: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

In case the clkctrl node contains assigned-clock-* entries, registering
the provider can fail with -EPROBE_DEFER. In this case, add the
provider to the retry_init clock list so it will be cleaned up later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clkctrl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 38dbcc1..7d82fff 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -414,6 +414,12 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
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
@@ -425,6 +431,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	struct omap_clkctrl_clk *clkctrl_clk;
 	const __be32 *addrp;
 	u32 addr;
+	int ret;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
 	addr = (u32)of_translate_address(node, addrp);
@@ -519,7 +526,10 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		reg_data++;
 	}
 
-	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	ret = of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	if (ret == -EPROBE_DEFER)
+		ti_clk_retry_init(node, provider, _clkctrl_add_provider);
+
 	return;
 
 cleanup:
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
