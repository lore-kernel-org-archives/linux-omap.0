From: Aneesh V <aneesh@ti.com>
Subject: [PATCH 4/4] misc: emif: add device tree support to emif driver
Date: Thu,  8 Mar 2012 22:03:57 +0530
Message-ID: <1331224437-4808-5-git-send-email-aneesh@ti.com>
References: <1331224437-4808-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45634 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756706Ab2CHQeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 11:34:36 -0500
Received: by mail-gx0-f174.google.com with SMTP id e5so323318ggh.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 08:34:35 -0800 (PST)
In-Reply-To: <1331224437-4808-1-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
---
Changes since RFC v4:
- Rebased to the latest version of EMIF series
- Replace kzalloc()/kfree() with devm_* variants
---
 drivers/misc/emif.c |  289 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 288 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/emif.c b/drivers/misc/emif.c
index 79fb161..0aaa61e 100644
--- a/drivers/misc/emif.c
+++ b/drivers/misc/emif.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
@@ -49,6 +50,7 @@
  *				frequency in effect at the moment)
  * @plat_data:			Pointer to saved platform data.
  * @debugfs_root:		dentry to the root folder for EMIF in debugfs
+ * @np_ddr:			Pointer to ddr device tree node
  */
 struct emif_data {
 	u8				duplicate;
@@ -63,6 +65,9 @@ struct emif_data {
 	struct emif_regs		*curr_regs;
 	struct emif_platform_data	*plat_data;
 	struct dentry			*debugfs_root;
+#if defined(CONFIG_OF)
+	struct device_node		*np_ddr;
+#endif
 };
 
 static struct emif_data *emif1;
@@ -1147,6 +1152,270 @@ static int is_custom_config_valid(struct emif_custom_configs *cust_cfgs,
 	return valid;
 }
 
+#if defined(CONFIG_OF)
+static void __init of_get_custom_configs(struct device_node *np_emif,
+		struct emif_data *emif)
+{
+	struct emif_custom_configs	*cust_cfgs = NULL;
+	int				len;
+	const int			*lpmode, *poll_intvl;
+
+	lpmode = of_get_property(np_emif, "low-power-mode", &len);
+	poll_intvl = of_get_property(np_emif, "temp-alert-poll-interval", &len);
+
+	if (lpmode || poll_intvl)
+		cust_cfgs = devm_kzalloc(emif->dev, sizeof(*cust_cfgs),
+			GFP_KERNEL);
+
+	if (!cust_cfgs)
+		return;
+
+	if (lpmode) {
+		cust_cfgs->mask |= EMIF_CUSTOM_CONFIG_LPMODE;
+		cust_cfgs->lpmode = *lpmode;
+		of_property_read_u32(np_emif,
+				"low-power-mode-timeout-performance",
+				&cust_cfgs->lpmode_timeout_performance);
+		of_property_read_u32(np_emif,
+				"low-power-mode-timeout-power",
+				&cust_cfgs->lpmode_timeout_power);
+		of_property_read_u32(np_emif,
+				"low-power-mode-freq-threshold",
+				&cust_cfgs->lpmode_freq_threshold);
+	}
+
+	if (poll_intvl) {
+		cust_cfgs->mask |=
+				EMIF_CUSTOM_CONFIG_TEMP_ALERT_POLL_INTERVAL;
+		cust_cfgs->temp_alert_poll_interval_ms = *poll_intvl;
+	}
+
+	if (!is_custom_config_valid(cust_cfgs, emif->dev)) {
+		devm_kfree(emif->dev, cust_cfgs);
+		return;
+	}
+
+	emif->plat_data->custom_configs = cust_cfgs;
+}
+
+static void __init of_get_min_tck(struct device_node *np,
+		struct emif_data *emif)
+{
+	int			ret = 0;
+	struct lpddr2_min_tck	*min;
+
+	min = devm_kzalloc(emif->dev, sizeof(*min), GFP_KERNEL);
+	if (!min)
+		goto default_min_tck;
+
+	ret |= of_property_read_u32(np, "tRPab-min-tck", &min->tRPab);
+	ret |= of_property_read_u32(np, "tRCD-min-tck", &min->tRCD);
+	ret |= of_property_read_u32(np, "tWR-min-tck", &min->tWR);
+	ret |= of_property_read_u32(np, "tRASmin-min-tck", &min->tRASmin);
+	ret |= of_property_read_u32(np, "tRRD-min-tck", &min->tRRD);
+	ret |= of_property_read_u32(np, "tWTR-min-tck", &min->tWTR);
+	ret |= of_property_read_u32(np, "tXP-min-tck", &min->tXP);
+	ret |= of_property_read_u32(np, "tRTP-min-tck", &min->tRTP);
+	ret |= of_property_read_u32(np, "tCKE-min-tck", &min->tCKE);
+	ret |= of_property_read_u32(np, "tCKESR-min-tck", &min->tCKESR);
+	ret |= of_property_read_u32(np, "tFAW-min-tck", &min->tFAW);
+
+	if (ret) {
+		devm_kfree(emif->dev, min);
+		goto default_min_tck;
+	}
+
+	emif->plat_data->min_tck = min;
+	return;
+
+default_min_tck:
+	dev_warn(emif->dev, "%s: using default min-tck values\n", __func__);
+	emif->plat_data->min_tck = &lpddr2_min_tck;
+}
+
+static int __init of_do_get_timings(struct device_node *np,
+		struct lpddr2_timings *tim)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "max-freq", &tim->max_freq);
+	ret |= of_property_read_u32(np, "min-freq", &tim->min_freq);
+	ret |= of_property_read_u32(np, "tRPab", &tim->tRPab);
+	ret |= of_property_read_u32(np, "tRCD", &tim->tRCD);
+	ret |= of_property_read_u32(np, "tWR", &tim->tWR);
+	ret |= of_property_read_u32(np, "tRAS-min", &tim->tRAS_min);
+	ret |= of_property_read_u32(np, "tRRD", &tim->tRRD);
+	ret |= of_property_read_u32(np, "tWTR", &tim->tWTR);
+	ret |= of_property_read_u32(np, "tXP", &tim->tXP);
+	ret |= of_property_read_u32(np, "tRTP", &tim->tRTP);
+	ret |= of_property_read_u32(np, "tCKESR", &tim->tCKESR);
+	ret |= of_property_read_u32(np, "tDQSCK-max", &tim->tDQSCK_max);
+	ret |= of_property_read_u32(np, "tFAW", &tim->tFAW);
+	ret |= of_property_read_u32(np, "tZQCS", &tim->tZQCS);
+	ret |= of_property_read_u32(np, "tZQCL", &tim->tZQCL);
+	ret |= of_property_read_u32(np, "tZQinit", &tim->tZQinit);
+	ret |= of_property_read_u32(np, "tRAS-max-ns", &tim->tRAS_max_ns);
+	ret |= of_property_read_u32(np, "tDQSCK-max-derated",
+		&tim->tDQSCK_max_derated);
+
+	return ret;
+}
+
+static void __init of_get_ddr_timings(struct device_node *np_ddr,
+		struct emif_data *emif)
+{
+	struct lpddr2_timings	*timings = NULL;
+	u32			arr_sz = 0, i = 0;
+	struct device_node	*np_tim;
+	char			*tim_compat;
+
+	switch (emif->plat_data->device_info->type) {
+	case DDR_TYPE_LPDDR2_S2:
+	case DDR_TYPE_LPDDR2_S4:
+		tim_compat = "jedec,lpddr2-timings";
+		break;
+	default:
+		dev_warn(emif->dev, "%s: un-supported memory type\n", __func__);
+	}
+
+	for_each_child_of_node(np_ddr, np_tim)
+		if (of_device_is_compatible(np_tim, tim_compat))
+			arr_sz++;
+
+	if (arr_sz)
+		timings = devm_kzalloc(emif->dev, sizeof(*timings) * arr_sz,
+			GFP_KERNEL);
+
+	if (!timings)
+		goto default_timings;
+
+	for_each_child_of_node(np_ddr, np_tim) {
+		if (of_device_is_compatible(np_tim, tim_compat)) {
+			if (of_do_get_timings(np_tim, &timings[i])) {
+				devm_kfree(emif->dev, timings);
+				goto default_timings;
+			}
+			i++;
+		}
+	}
+
+	emif->plat_data->timings = timings;
+	emif->plat_data->timings_arr_size = arr_sz;
+
+	return;
+
+default_timings:
+	get_default_timings(emif);
+
+	return;
+}
+
+static void __init of_get_ddr_info(struct device_node *np_emif,
+		struct device_node *np_ddr,
+		struct ddr_device_info *dev_info)
+{
+	u32 density = 0, io_width = 0;
+	int len;
+
+	if (of_find_property(np_emif, "cs1-used", &len))
+		dev_info->cs1_used = true;
+
+	if (of_find_property(np_emif, "cal-resistor-per-cs", &len))
+		dev_info->cal_resistors_per_cs = true;
+
+	if (of_device_is_compatible(np_ddr , "jedec,lpddr2-s4"))
+		dev_info->type = DDR_TYPE_LPDDR2_S4;
+	else if (of_device_is_compatible(np_ddr , "jedec,lpddr2-s2"))
+		dev_info->type = DDR_TYPE_LPDDR2_S2;
+
+	of_property_read_u32(np_ddr, "density", &density);
+	of_property_read_u32(np_ddr, "io-width", &io_width);
+
+	/* Convert from density in Mb to the density encoding in jedc_ddr.h */
+	if (density & (density - 1))
+		dev_info->density = 0;
+	else
+		dev_info->density = __fls(density) - 5;
+
+	/* Convert from io_width in bits to io_width encoding in jedc_ddr.h */
+	if (io_width & (io_width - 1))
+		dev_info->io_width = 0;
+	else
+		dev_info->io_width = __fls(io_width) - 1;
+}
+
+static struct emif_data * __init of_get_device_details(
+		struct device_node *np_emif, struct device *dev)
+{
+	struct emif_data		*emif = NULL;
+	struct ddr_device_info		*dev_info = NULL;
+	struct emif_platform_data	*pd = NULL;
+	struct device_node		*np_ddr;
+	int				len;
+
+	np_ddr = of_parse_phandle(np_emif, "device-handle", 0);
+	if (!np_ddr)
+		goto error;
+	emif	= devm_kzalloc(dev, sizeof(struct emif_data), GFP_KERNEL);
+	pd	= devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	dev_info = devm_kzalloc(dev, sizeof(*dev_info), GFP_KERNEL);
+
+	if (!emif || !pd || !dev_info) {
+		dev_err(dev, "%s: of_get_device_details() failure!!\n",
+			__func__);
+		goto error;
+	}
+
+	emif->plat_data		= pd;
+	pd->device_info		= dev_info;
+	emif->dev		= dev;
+	emif->np_ddr		= np_ddr;
+	emif->temperature_level	= SDRAM_TEMP_NOMINAL;
+
+	if (of_device_is_compatible(np_emif, "ti,emif-4d"))
+		emif->plat_data->ip_rev = EMIF_4D;
+	else if (of_device_is_compatible(np_emif, "ti,emif-4d5"))
+		emif->plat_data->ip_rev = EMIF_4D5;
+
+	of_property_read_u32(np_emif, "phy-type", &pd->phy_type);
+
+	if (of_find_property(np_emif, "hw-caps-ll-interface", &len))
+		pd->hw_caps |= EMIF_HW_CAPS_LL_INTERFACE;
+
+	of_get_ddr_info(np_emif, np_ddr, dev_info);
+	if (!is_dev_data_valid(pd->device_info->type, pd->device_info->density,
+			pd->device_info->io_width, pd->phy_type, pd->ip_rev,
+			emif->dev)) {
+		dev_err(dev, "%s: invalid device data!!\n", __func__);
+		goto error;
+	}
+	/*
+	 * For EMIF instances other than EMIF1 see if the devices connected
+	 * are exactly same as on EMIF1(which is typically the case). If so,
+	 * mark it as a duplicate of EMIF1. This will save some memory and
+	 * computation.
+	 */
+	if (emif1 && emif1->np_ddr == np_ddr) {
+		emif->duplicate = true;
+		goto out;
+	} else if (emif1) {
+		dev_warn(emif->dev, "%s: Non-symmetric DDR geometry\n",
+			__func__);
+	}
+
+
+	of_get_custom_configs(np_emif, emif);
+	of_get_ddr_timings(np_ddr, emif);
+	of_get_min_tck(np_ddr, emif);
+	goto out;
+
+error:
+	return NULL;
+out:
+	return emif;
+}
+#endif
+
 static struct emif_data * __init get_device_details(
 		struct platform_device *pdev)
 {
@@ -1266,7 +1535,13 @@ static int __init emif_probe(struct platform_device *pdev)
 	struct resource		*res;
 	int			irq;
 
-	emif = get_device_details(pdev);
+#if defined(CONFIG_OF)
+	if (pdev->dev.of_node)
+		emif = of_get_device_details(pdev->dev.of_node, &pdev->dev);
+	else
+#endif
+		emif = get_device_details(pdev);
+
 	if (!emif) {
 		pr_err("%s: error getting device data\n", __func__);
 		goto error;
@@ -1643,11 +1918,23 @@ static void __attribute__((unused)) freq_post_notify_handling(void)
 	spin_unlock_irqrestore(&emif_lock, irq_state);
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id emif_of_match[] = {
+		{ .compatible = "ti,emif-4d" },
+		{ .compatible = "ti,emif-4d5" },
+		{},
+};
+MODULE_DEVICE_TABLE(of, emif_of_match);
+#endif
+
 static struct platform_driver emif_driver = {
 	.remove		= __exit_p(emif_remove),
 	.shutdown	= emif_shutdown,
 	.driver = {
 		.name = "emif",
+#if defined(CONFIG_OF)
+		.of_match_table = of_match_ptr(emif_of_match),
+#endif
 	},
 };
 
-- 
1.7.1

