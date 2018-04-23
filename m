From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/16] bus: ti-sysc: Handle simple-bus for nested children
Date: Mon, 23 Apr 2018 10:45:40 -0700
Message-ID: <20180423174549.57412-8-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Otherwise child devices that some interconnect target module devices
have won't probe using simple-bus.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1314,6 +1314,11 @@ static void ti_sysc_idle(struct work_struct *work)
 		pm_runtime_put_sync(ddata->dev);
 }
 
+static const struct of_device_id sysc_match_table[] = {
+	{ .compatible = "simple-bus", },
+	{ /* sentinel */ },
+};
+
 static int sysc_probe(struct platform_device *pdev)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -1375,8 +1380,8 @@ static int sysc_probe(struct platform_device *pdev)
 	sysc_show_registers(ddata);
 
 	ddata->dev->type = &sysc_device_type;
-	error = of_platform_populate(ddata->dev->of_node,
-				     NULL, pdata ? pdata->auxdata : NULL,
+	error = of_platform_populate(ddata->dev->of_node, sysc_match_table,
+				     pdata ? pdata->auxdata : NULL,
 				     ddata->dev);
 	if (error)
 		goto err;
-- 
2.17.0
