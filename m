From: Luciano Coelho <coelho@ti.com>
Subject: [PATCH v2 7/9] wlcore: sdio: add wilink clock providers
Date: Tue, 2 Jul 2013 17:55:46 +0300
Message-ID: <1372776948-24840-8-git-send-email-coelho@ti.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372776948-24840-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-wireless@vger.kernel.org, tony@atomide.com, nsekhar@ti.com
Cc: mturquette@linaro.org, mark.rutland@arm.com, balbi@ti.com, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, coelho@ti.com
List-Id: linux-omap@vger.kernel.org

Add refclock and tcxoclock as clock providers in WiLink.  These clocks
are not accesible outside the WiLink module, but they are registered
in the clock framework anyway.  Only the WiLink chip consumes these
clocks.

In theory, the WiLink chip could be connected to external clocks
instead of using these internal clocks, so make the clock consumer
code generic enough.  If external clocks are used, then the internal
clock device tree nodes are not necessary, but the external ones must
be specified.

Signed-off-by: Luciano Coelho <coelho@ti.com>
---
 drivers/net/wireless/ti/wlcore/sdio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 9370d7e..980bf3d 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -34,6 +34,7 @@
 #include <linux/wl12xx.h>
 #include <linux/pm_runtime.h>
 #include <linux/printk.h>
+#include <linux/clk-provider.h>
 
 #include "wlcore.h"
 #include "wl12xx_80211.h"
@@ -214,10 +215,15 @@ static struct wl1271_if_operations sdio_ops = {
 	.set_block_size = wl1271_sdio_set_block_size,
 };
 
+static const struct of_device_id wlcore_sdio_of_clk_match_table[] = {
+	{ .compatible = "ti,wilink-clock" },
+};
+
 static struct wl12xx_platform_data *wlcore_get_pdata_from_of(struct device *dev)
 {
 	struct wl12xx_platform_data *pdata;
 	struct device_node *np = dev->of_node;
+	struct device_node *clock_node;
 
 	if (!np) {
 		np = of_find_matching_node(NULL, dev->driver->of_match_table);
@@ -241,6 +247,9 @@ static struct wl12xx_platform_data *wlcore_get_pdata_from_of(struct device *dev)
 		goto out_free;
 	}
 
+	for_each_matching_node(clock_node, wlcore_sdio_of_clk_match_table)
+		of_fixed_clk_setup(clock_node);
+
 	goto out;
 
 out_free:
-- 
1.7.10.4
