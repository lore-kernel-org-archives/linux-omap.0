From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 10/13] ARM: OMAP2+: gpmc: handle connected peripherals
Date: Fri, 22 Jun 2012 18:27:29 +0530
Message-ID: <9d38a98179a4cf8250f71a0a60a2a22786a02859.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40035 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab2FVNMt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:49 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Platform will provide driver with configuration details for
each CS like configuration, timing, interrupts. Setup GPMC
based on it. Platform data also provides platform data &
resources used for connected peripheral (eg. gpio irq).
GPMC driver tunnels those information to respective driver.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |  142 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 15688da..ac66267 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -156,6 +156,8 @@ struct gpmc_peripheral {
 	struct platform_device	*pdev;
 };
 
+static struct gpmc_peripheral gpmc_peripheral[GPMC_CS_NUM];
+static unsigned gpmc_num_peripheral;
 static unsigned gpmc_waitpin_map;
 static unsigned gpmc_waitpin_nr = GPMC_MAX_NR_WAITPIN;
 
@@ -1229,6 +1231,37 @@ static int gpmc_setup_cs_waitpin(struct gpmc_peripheral *g_per, unsigned cs,
 	return 0;
 }
 
+static int gpmc_setup_cs_config_timing(struct gpmc_peripheral *g_per,
+						struct gpmc_cs_data *cs)
+{
+	int ret;
+
+	/* some boards rely on bootloader for configuration */
+	if (cs->have_config) {
+		gpmc_setup_cs_config(cs->cs, cs->config);
+		ret = gpmc_setup_cs_waitpin(g_per, cs->cs, cs->config);
+		if (IS_ERR_VALUE(ret)) {
+			dev_err(gpmc_dev, "error: waitpin on CS %d\n", cs->cs);
+			return ret;
+		}
+	} else
+		gpmc_print_cs_config(cs->cs);
+
+	/* some boards rely on bootloader for timing */
+	if (cs->time_ctrl.type == has_period) {
+		ret = gpmc_cs_set_timings(cs->cs, &cs->time_ctrl.timings);
+		if (IS_ERR_VALUE(ret)) {
+			dev_err(gpmc_dev, "error: timing on CS: %d\n", cs->cs);
+			return ret;
+		}
+	} else if (cs->time_ctrl.type == has_clock)
+		gpmc_cs_set_register_timings(cs->cs, &cs->time_ctrl.timings);
+	else
+		gpmc_print_cs_timings(cs->cs);
+
+	return 0;
+}
+
 static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
 						struct resource *res)
 {
@@ -1301,11 +1334,99 @@ static int gpmc_setup_waitpin(struct gpmc_peripheral *g_per)
 	return 0;
 }
 
+static __devinit int gpmc_setup_cs(struct gpmc_peripheral *g_per,
+				struct gpmc_cs_data *cs, struct resource *res)
+{
+	int num, ret;
+
+	ret = gpmc_setup_cs_mem(cs, res);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	ret = gpmc_setup_cs_config_timing(g_per, cs);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	num = gpmc_setup_cs_irq(cs, res + 1); /* +1 to account for memory */
+
+	return num + 1; /* +1 to account for memory*/
+}
+
+static __devinit int gpmc_setup_device(struct gpmc_peripheral *g_per,
+					struct gpmc_device_pdata *gdp)
+{
+	int i, n, ret;
+	struct gpmc_cs_data *cs;
+
+	for (i = 0, n = gdp->num_cs, cs = gdp->cs_data;
+				i < gdp->num_cs; i++, cs++)
+		n += hweight32(cs->irq_config);
+
+	g_per->gpmc_res = devm_kzalloc(gpmc_dev, sizeof(*g_per->gpmc_res) * n,
+								GFP_KERNEL);
+	if (g_per->gpmc_res == NULL) {
+		dev_err(gpmc_dev, "error: memory allocation\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0, cs = gdp->cs_data, g_per->gpmc_res_cnt = 0;
+			i < gdp->num_cs; cs++, i++) {
+		ret = gpmc_setup_cs(g_per, cs,
+					g_per->gpmc_res + g_per->gpmc_res_cnt);
+		if (IS_ERR_VALUE(ret) ||
+				IS_ERR_VALUE(gpmc_setup_waitpin(g_per))) {
+			dev_err(gpmc_dev, "error: setup for %s\n", gdp->name);
+			devm_kfree(gpmc_dev, g_per->gpmc_res);
+			g_per->gpmc_res = NULL;
+			g_per->gpmc_res_cnt = 0;
+			return -EINVAL;
+		} else
+			g_per->gpmc_res_cnt += ret;
+	}
+
+	g_per->name = gdp->name;
+	g_per->id = gdp->id;
+	g_per->pdata = gdp->pdata;
+	g_per->pdata_size = gdp->pdata_size;
+	g_per->per_res = gdp->per_res;
+	g_per->per_res_cnt = gdp->per_res_cnt;
+
+	return 0;
+}
+
+static __devinit
+struct platform_device *gpmc_create_device(struct gpmc_peripheral *p)
+{
+	int num = p->per_res_cnt + p->gpmc_res_cnt;
+	struct resource *res;
+
+	res = devm_kzalloc(gpmc_dev, sizeof(struct resource) * num,
+								GFP_KERNEL);
+	if (!res) {
+		dev_err(gpmc_dev, "error: allocating memory\n");
+		return NULL;
+	}
+
+	memcpy((char *)res, (const char *) p->gpmc_res,
+				sizeof(struct resource) * p->gpmc_res_cnt);
+	memcpy((char *)(res + p->gpmc_res_cnt), (const char *)p->per_res,
+				sizeof(struct resource) * p->per_res_cnt);
+
+	p->pdev = platform_device_register_resndata(gpmc_dev, p->name, p->id,
+					res, num, p->pdata, p->pdata_size);
+
+	devm_kfree(gpmc_dev, res);
+
+	return p->pdev;
+}
+
 static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	u32 l;
 	struct resource *res;
 	struct gpmc_pdata *gp = dev_get_platdata(&pdev->dev);
+	struct gpmc_device_pdata **gdq = NULL;
+	struct gpmc_peripheral *g_per = NULL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL)
@@ -1343,11 +1464,32 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 	if (gp->waitpin_nr)
 		gpmc_waitpin_nr = gp->waitpin_nr;
 
+	/* Traverse NULL terminated array of peripheral pointers and setup */
+	for (gdq = gp->device_pdata, g_per = gpmc_peripheral; *gdq; gdq++)
+		if (IS_ERR_VALUE(gpmc_setup_device(g_per, *gdq)))
+			dev_err(gpmc_dev, "gpmc setup on %s failed\n",
+								(*gdq)->name);
+		else
+			g_per++;
+	gpmc_num_peripheral = g_per - gpmc_peripheral;
+
+	for (l = 0, g_per = gpmc_peripheral;
+			l < gpmc_num_peripheral; l++, g_per++)
+		if (IS_ERR(gpmc_create_device(g_per)))
+			dev_err(gpmc_dev, "device creation on %s failed\n",
+								g_per->name);
+
 	return 0;
 }
 
 static __exit int gpmc_remove(struct platform_device *pdev)
 {
+	struct gpmc_peripheral *g_per = gpmc_peripheral;
+
+	for (; gpmc_num_peripheral; g_per++, gpmc_num_peripheral--)
+		platform_device_unregister(g_per->pdev);
+
+	gpmc_waitpin_map = 0;
 	gpmc_waitpin_nr = GPMC_MAX_NR_WAITPIN;
 	gpmc_free_irq();
 	gpmc_mem_exit();
-- 
1.7.10.2

