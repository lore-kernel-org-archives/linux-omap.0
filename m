From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v4 4/4] memory: emif: add device tree support to emif driver
Date: Tue, 17 Jul 2012 22:37:45 +0530
Message-ID: <CAMQu2gw2Zt3E8byD=_nUXya-xU=gOA71arbbSh7gzxQhet0Vtg@mail.gmail.com>
References: <1340977407-7594-1-git-send-email-santosh.shilimkar@ti.com>
 <1340977407-7594-5-git-send-email-santosh.shilimkar@ti.com>
 <CAMQu2gz6jdcR4hQPPbmyO8vrkdmppHeCkZmV3_9w27LOzKrUuA@mail.gmail.com>
 <20120630042356.GC1816@kroah.com> <CAMQu2gy0MmP4JLW4P1FreJqMMEBYSTjkLHJb8WX=aXLA6hxtZg@mail.gmail.com>
 <CAMQu2gxZ-tWJXAOeh20NsF1uyvs9fqwYtggFv=d7-qX+WFumRQ@mail.gmail.com>
 <CAMQu2gw_ZB7gVyL95B-h27B1fQh0d-YB3weaWRN6DNaGtSypDw@mail.gmail.com> <20120717163602.GA7167@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3005dc56044bd204c509979f
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:52631 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751589Ab2GQRII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 13:08:08 -0400
Received: by qcab12 with SMTP id b12so429299qca.4
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 10:08:06 -0700 (PDT)
In-Reply-To: <20120717163602.GA7167@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, tony@atomide.com

--20cf3005dc56044bd204c509979f
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jul 17, 2012 at 10:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 09, 2012 at 07:02:36PM +0530, Shilimkar, Santosh wrote:
>> Greg,
>>

[...]

>> > To elaborate more, I have created below patch.
>> > Let me know what do you think ?
>> >
>> Any comments ??
>
> Becides the obvious one of sending a line-wrapped patch that can not be
> applied?  :)
>
My bad. Sorry about that.
Sending it again and also attaching it in case mailer screws it up.

-->>
>From 74688a87fd490909e9122bf757c0096480e9fc11 Mon Sep 17 00:00:00 2001
From: Aneesh V <aneesh@ti.com>
Date: Mon, 30 Jan 2012 20:06:30 +0530
Subject: [PATCH 4/4] memory: emif: add device tree support to emif driver

Device tree support for the EMIF driver. LPDDR2 generic timings
extraction from device is managed using couple of helper
functions which can be used by other memory controller
drivers.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/memory/Makefile    |    1 +
 drivers/memory/emif.c      |  182 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/memory/of_memory.c |  153 +++++++++++++++++++++++++++++++++++++
 drivers/memory/of_memory.h |   36 +++++++++
 4 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/of_memory.c
 create mode 100644 drivers/memory/of_memory.h

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 42b3ce9..cd8486b 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -2,6 +2,7 @@
 # Makefile for memory devices
 #

+obj-$(CONFIG_OF)		+= of_memory.o
 obj-$(CONFIG_TI_EMIF)		+= emif.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 33a4396..06b4eb7 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
@@ -25,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <memory/jedec_ddr.h>
 #include "emif.h"
+#include "of_memory.h"

 /**
  * struct emif_data - Per device static data for driver's use
@@ -49,6 +51,7 @@
  *				frequency in effect at the moment)
  * @plat_data:			Pointer to saved platform data.
  * @debugfs_root:		dentry to the root folder for EMIF in debugfs
+ * @np_ddr:			Pointer to ddr device tree node
  */
 struct emif_data {
 	u8				duplicate;
@@ -63,6 +66,7 @@ struct emif_data {
 	struct emif_regs		*curr_regs;
 	struct emif_platform_data	*plat_data;
 	struct dentry			*debugfs_root;
+	struct device_node		*np_ddr;
 };

 static struct emif_data *emif1;
@@ -1148,6 +1152,168 @@ static int is_custom_config_valid(struct
emif_custom_configs *cust_cfgs,
 	return valid;
 }

+#if defined(CONFIG_OF)
+static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
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
+static void __init_or_module of_get_ddr_info(struct device_node *np_emif,
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
+static struct emif_data * __init_or_module of_get_device_details(
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
+	of_get_custom_configs(np_emif, emif);
+	emif->plat_data->timings = of_get_ddr_timings(np_ddr, emif->dev,
+					emif->plat_data->device_info->type,
+					&emif->plat_data->timings_arr_size);
+
+	emif->plat_data->min_tck = of_get_min_tck(np_ddr, emif->dev);
+	goto out;
+
+error:
+	return NULL;
+out:
+	return emif;
+}
+
+#else
+
+static struct emif_data * __init_or_module of_get_device_details(
+		struct device_node *np_emif, struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static struct emif_data *__init_or_module get_device_details(
 		struct platform_device *pdev)
 {
@@ -1267,7 +1433,11 @@ static int __init_or_module emif_probe(struct
platform_device *pdev)
 	struct resource		*res;
 	int			irq;

-	emif = get_device_details(pdev);
+	if (pdev->dev.of_node)
+		emif = of_get_device_details(pdev->dev.of_node, &pdev->dev);
+	else
+		emif = get_device_details(pdev);
+
 	if (!emif) {
 		pr_err("%s: error getting device data\n", __func__);
 		goto error;
@@ -1644,11 +1814,21 @@ static void __attribute__((unused))
freq_post_notify_handling(void)
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
+		.of_match_table = of_match_ptr(emif_of_match),
 	},
 };

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
new file mode 100644
index 0000000..6007435
--- /dev/null
+++ b/drivers/memory/of_memory.c
@@ -0,0 +1,153 @@
+/*
+ * OpenFirmware helpers for memory drivers
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/gfp.h>
+#include <memory/jedec_ddr.h>
+#include <linux/export.h>
+
+/**
+ * of_get_min_tck() - extract min timing values for ddr
+ * @np: pointer to ddr device tree node
+ * @device: device requesting for min timing values
+ *
+ * Populates the lpddr2_min_tck structure by extracting data
+ * from device tree node. Returns a pointer to the populated
+ * structure. If any error in populating the structure, returns
+ * default min timings provided by JEDEC.
+ */
+const struct lpddr2_min_tck *of_get_min_tck(struct device_node *np,
+		struct device *dev)
+{
+	int			ret = 0;
+	struct lpddr2_min_tck	*min;
+
+	min = devm_kzalloc(dev, sizeof(*min), GFP_KERNEL);
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
+		devm_kfree(dev, min);
+		goto default_min_tck;
+	}
+
+	return min;
+
+default_min_tck:
+	dev_warn(dev, "%s: using default min-tck values\n", __func__);
+	return &lpddr2_jedec_min_tck;
+}
+EXPORT_SYMBOL(of_get_min_tck);
+
+static int of_do_get_timings(struct device_node *np,
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
+/**
+ * of_get_ddr_timings() - extracts the ddr timings and updates no of
+ * frequencies available.
+ * @np_ddr: Pointer to ddr device tree node
+ * @dev: Device requesting for ddr timings
+ * @device_type: Type of ddr(LPDDR2 S2/S4)
+ * @nr_frequencies: No of frequencies available for ddr
+ * (updated by this function)
+ *
+ * Populates lpddr2_timings structure by extracting data from device
+ * tree node. Returns pointer to populated structure. If any error
+ * while populating, returns default timings provided by JEDEC.
+ */
+const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
+		struct device *dev, u32 device_type, u32 *nr_frequencies)
+{
+	struct lpddr2_timings	*timings = NULL;
+	u32			arr_sz = 0, i = 0;
+	struct device_node	*np_tim;
+	char			*tim_compat;
+
+	switch (device_type) {
+	case DDR_TYPE_LPDDR2_S2:
+	case DDR_TYPE_LPDDR2_S4:
+		tim_compat = "jedec,lpddr2-timings";
+		break;
+	default:
+		dev_warn(dev, "%s: un-supported memory type\n", __func__);
+	}
+
+	for_each_child_of_node(np_ddr, np_tim)
+		if (of_device_is_compatible(np_tim, tim_compat))
+			arr_sz++;
+
+	if (arr_sz)
+		timings = devm_kzalloc(dev, sizeof(*timings) * arr_sz,
+			GFP_KERNEL);
+
+	if (!timings)
+		goto default_timings;
+
+	for_each_child_of_node(np_ddr, np_tim) {
+		if (of_device_is_compatible(np_tim, tim_compat)) {
+			if (of_do_get_timings(np_tim, &timings[i])) {
+				devm_kfree(dev, timings);
+				goto default_timings;
+			}
+			i++;
+		}
+	}
+
+	*nr_frequencies = arr_sz;
+
+	return timings;
+
+default_timings:
+	dev_warn(dev, "%s: using default timings\n", __func__);
+	*nr_frequencies = ARRAY_SIZE(lpddr2_jedec_timings);
+	return lpddr2_jedec_timings;
+}
+EXPORT_SYMBOL(of_get_ddr_timings);
diff --git a/drivers/memory/of_memory.h b/drivers/memory/of_memory.h
new file mode 100644
index 0000000..20b496e
--- /dev/null
+++ b/drivers/memory/of_memory.h
@@ -0,0 +1,36 @@
+/*
+ * OpenFirmware helpers for memory drivers
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_MEMORY_OF_REG_H
+#define __LINUX_MEMORY_OF_REG_H
+
+#ifdef CONFIG_OF
+extern const struct lpddr2_min_tck *of_get_min_tck(struct device_node *np,
+		struct device *dev);
+extern const struct lpddr2_timings
+	*of_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
+	u32 device_type, u32 *nr_frequencies);
+#else
+static inline const struct lpddr2_min_tck
+	*of_get_min_tck(struct device_node *np, struct device *dev)
+{
+	return NULL;
+}
+
+static inline const struct lpddr2_timings
+	*of_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
+	u32 device_type, u32 *nr_frequencies)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
+#endif /* __LINUX_MEMORY_OF_REG_ */
-- 
1.7.9.5

--20cf3005dc56044bd204c509979f
Content-Type: application/octet-stream;
	name="0004-memory-emif-add-device-tree-support-to-emif-driver.patch"
Content-Disposition: attachment;
	filename="0004-memory-emif-add-device-tree-support-to-emif-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h4r8f7iw0

RnJvbSA3NDY4OGE4N2ZkNDkwOTA5ZTkxMjJiZjc1N2MwMDk2NDgwZTlmYzExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmVlc2ggViA8YW5lZXNoQHRpLmNvbT4KRGF0ZTogTW9uLCAz
MCBKYW4gMjAxMiAyMDowNjozMCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggNC80XSBtZW1vcnk6IGVt
aWY6IGFkZCBkZXZpY2UgdHJlZSBzdXBwb3J0IHRvIGVtaWYgZHJpdmVyCgpEZXZpY2UgdHJlZSBz
dXBwb3J0IGZvciB0aGUgRU1JRiBkcml2ZXIuIExQRERSMiBnZW5lcmljIHRpbWluZ3MKZXh0cmFj
dGlvbiBmcm9tIGRldmljZSBpcyBtYW5hZ2VkIHVzaW5nIGNvdXBsZSBvZiBoZWxwZXIKZnVuY3Rp
b25zIHdoaWNoIGNhbiBiZSB1c2VkIGJ5IG90aGVyIG1lbW9yeSBjb250cm9sbGVyCmRyaXZlcnMu
CgpSZXZpZXdlZC1ieTogQmVub2l0IENvdXNzb24gPGItY291c3NvbkB0aS5jb20+ClJldmlld2Vk
LWJ5OiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIuY2E+ClRlc3RlZC1ieTog
TG9rZXNoIFZ1dGxhIDxsb2tlc2h2dXRsYUB0aS5jb20+ClNpZ25lZC1vZmYtYnk6IEFuZWVzaCBW
IDxhbmVlc2hAdGkuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9z
aC5zaGlsaW1rYXJAdGkuY29tPgpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4KLS0tCiBkcml2ZXJzL21lbW9yeS9NYWtlZmlsZSAgICB8ICAgIDEgKwog
ZHJpdmVycy9tZW1vcnkvZW1pZi5jICAgICAgfCAgMTgyICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystCiBkcml2ZXJzL21lbW9yeS9vZl9tZW1vcnkuYyB8ICAxNTMg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9tZW1vcnkvb2Zf
bWVtb3J5LmggfCAgIDM2ICsrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAzNzEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVtb3J5L29m
X21lbW9yeS5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZW1vcnkvb2ZfbWVtb3J5LmgK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9NYWtlZmlsZSBiL2RyaXZlcnMvbWVtb3J5L01h
a2VmaWxlCmluZGV4IDQyYjNjZTkuLmNkODQ4NmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVtb3J5
L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvbWVtb3J5L01ha2VmaWxlCkBAIC0yLDYgKzIsNyBAQAog
IyBNYWtlZmlsZSBmb3IgbWVtb3J5IGRldmljZXMKICMKIAorb2JqLSQoQ09ORklHX09GKQkJKz0g
b2ZfbWVtb3J5Lm8KIG9iai0kKENPTkZJR19USV9FTUlGKQkJKz0gZW1pZi5vCiBvYmotJChDT05G
SUdfVEVHUkEyMF9NQykJKz0gdGVncmEyMC1tYy5vCiBvYmotJChDT05GSUdfVEVHUkEzMF9NQykJ
Kz0gdGVncmEzMC1tYy5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9lbWlmLmMgYi9kcml2
ZXJzL21lbW9yeS9lbWlmLmMKaW5kZXggMzNhNDM5Ni4uMDZiNGViNyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9tZW1vcnkvZW1pZi5jCisrKyBiL2RyaXZlcnMvbWVtb3J5L2VtaWYuYwpAQCAtMTgsNiAr
MTgsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgogI2luY2x1ZGUgPGxp
bnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51
eC9vZi5oPgogI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4KICNpbmNsdWRlIDxsaW51eC9zZXFf
ZmlsZS5oPgogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgpAQCAtMjUsNiArMjYsNyBAQAogI2lu
Y2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+CiAjaW5jbHVkZSA8bWVtb3J5L2plZGVjX2Rkci5oPgog
I2luY2x1ZGUgImVtaWYuaCIKKyNpbmNsdWRlICJvZl9tZW1vcnkuaCIKIAogLyoqCiAgKiBzdHJ1
Y3QgZW1pZl9kYXRhIC0gUGVyIGRldmljZSBzdGF0aWMgZGF0YSBmb3IgZHJpdmVyJ3MgdXNlCkBA
IC00OSw2ICs1MSw3IEBACiAgKgkJCQlmcmVxdWVuY3kgaW4gZWZmZWN0IGF0IHRoZSBtb21lbnQp
CiAgKiBAcGxhdF9kYXRhOgkJCVBvaW50ZXIgdG8gc2F2ZWQgcGxhdGZvcm0gZGF0YS4KICAqIEBk
ZWJ1Z2ZzX3Jvb3Q6CQlkZW50cnkgdG8gdGhlIHJvb3QgZm9sZGVyIGZvciBFTUlGIGluIGRlYnVn
ZnMKKyAqIEBucF9kZHI6CQkJUG9pbnRlciB0byBkZHIgZGV2aWNlIHRyZWUgbm9kZQogICovCiBz
dHJ1Y3QgZW1pZl9kYXRhIHsKIAl1OAkJCQlkdXBsaWNhdGU7CkBAIC02Myw2ICs2Niw3IEBAIHN0
cnVjdCBlbWlmX2RhdGEgewogCXN0cnVjdCBlbWlmX3JlZ3MJCSpjdXJyX3JlZ3M7CiAJc3RydWN0
IGVtaWZfcGxhdGZvcm1fZGF0YQkqcGxhdF9kYXRhOwogCXN0cnVjdCBkZW50cnkJCQkqZGVidWdm
c19yb290OworCXN0cnVjdCBkZXZpY2Vfbm9kZQkJKm5wX2RkcjsKIH07CiAKIHN0YXRpYyBzdHJ1
Y3QgZW1pZl9kYXRhICplbWlmMTsKQEAgLTExNDgsNiArMTE1MiwxNjggQEAgc3RhdGljIGludCBp
c19jdXN0b21fY29uZmlnX3ZhbGlkKHN0cnVjdCBlbWlmX2N1c3RvbV9jb25maWdzICpjdXN0X2Nm
Z3MsCiAJcmV0dXJuIHZhbGlkOwogfQogCisjaWYgZGVmaW5lZChDT05GSUdfT0YpCitzdGF0aWMg
dm9pZCBfX2luaXRfb3JfbW9kdWxlIG9mX2dldF9jdXN0b21fY29uZmlncyhzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5wX2VtaWYsCisJCXN0cnVjdCBlbWlmX2RhdGEgKmVtaWYpCit7CisJc3RydWN0IGVt
aWZfY3VzdG9tX2NvbmZpZ3MJKmN1c3RfY2ZncyA9IE5VTEw7CisJaW50CQkJCWxlbjsKKwljb25z
dCBpbnQJCQkqbHBtb2RlLCAqcG9sbF9pbnR2bDsKKworCWxwbW9kZSA9IG9mX2dldF9wcm9wZXJ0
eShucF9lbWlmLCAibG93LXBvd2VyLW1vZGUiLCAmbGVuKTsKKwlwb2xsX2ludHZsID0gb2ZfZ2V0
X3Byb3BlcnR5KG5wX2VtaWYsICJ0ZW1wLWFsZXJ0LXBvbGwtaW50ZXJ2YWwiLCAmbGVuKTsKKwor
CWlmIChscG1vZGUgfHwgcG9sbF9pbnR2bCkKKwkJY3VzdF9jZmdzID0gZGV2bV9remFsbG9jKGVt
aWYtPmRldiwgc2l6ZW9mKCpjdXN0X2NmZ3MpLAorCQkJR0ZQX0tFUk5FTCk7CisKKwlpZiAoIWN1
c3RfY2ZncykKKwkJcmV0dXJuOworCisJaWYgKGxwbW9kZSkgeworCQljdXN0X2NmZ3MtPm1hc2sg
fD0gRU1JRl9DVVNUT01fQ09ORklHX0xQTU9ERTsKKwkJY3VzdF9jZmdzLT5scG1vZGUgPSAqbHBt
b2RlOworCQlvZl9wcm9wZXJ0eV9yZWFkX3UzMihucF9lbWlmLAorCQkJCSJsb3ctcG93ZXItbW9k
ZS10aW1lb3V0LXBlcmZvcm1hbmNlIiwKKwkJCQkmY3VzdF9jZmdzLT5scG1vZGVfdGltZW91dF9w
ZXJmb3JtYW5jZSk7CisJCW9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wX2VtaWYsCisJCQkJImxvdy1w
b3dlci1tb2RlLXRpbWVvdXQtcG93ZXIiLAorCQkJCSZjdXN0X2NmZ3MtPmxwbW9kZV90aW1lb3V0
X3Bvd2VyKTsKKwkJb2ZfcHJvcGVydHlfcmVhZF91MzIobnBfZW1pZiwKKwkJCQkibG93LXBvd2Vy
LW1vZGUtZnJlcS10aHJlc2hvbGQiLAorCQkJCSZjdXN0X2NmZ3MtPmxwbW9kZV9mcmVxX3RocmVz
aG9sZCk7CisJfQorCisJaWYgKHBvbGxfaW50dmwpIHsKKwkJY3VzdF9jZmdzLT5tYXNrIHw9CisJ
CQkJRU1JRl9DVVNUT01fQ09ORklHX1RFTVBfQUxFUlRfUE9MTF9JTlRFUlZBTDsKKwkJY3VzdF9j
ZmdzLT50ZW1wX2FsZXJ0X3BvbGxfaW50ZXJ2YWxfbXMgPSAqcG9sbF9pbnR2bDsKKwl9CisKKwlp
ZiAoIWlzX2N1c3RvbV9jb25maWdfdmFsaWQoY3VzdF9jZmdzLCBlbWlmLT5kZXYpKSB7CisJCWRl
dm1fa2ZyZWUoZW1pZi0+ZGV2LCBjdXN0X2NmZ3MpOworCQlyZXR1cm47CisJfQorCisJZW1pZi0+
cGxhdF9kYXRhLT5jdXN0b21fY29uZmlncyA9IGN1c3RfY2ZnczsKK30KKworc3RhdGljIHZvaWQg
X19pbml0X29yX21vZHVsZSBvZl9nZXRfZGRyX2luZm8oc3RydWN0IGRldmljZV9ub2RlICpucF9l
bWlmLAorCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wX2RkciwKKwkJc3RydWN0IGRkcl9kZXZpY2Vf
aW5mbyAqZGV2X2luZm8pCit7CisJdTMyIGRlbnNpdHkgPSAwLCBpb193aWR0aCA9IDA7CisJaW50
IGxlbjsKKworCWlmIChvZl9maW5kX3Byb3BlcnR5KG5wX2VtaWYsICJjczEtdXNlZCIsICZsZW4p
KQorCQlkZXZfaW5mby0+Y3MxX3VzZWQgPSB0cnVlOworCisJaWYgKG9mX2ZpbmRfcHJvcGVydHko
bnBfZW1pZiwgImNhbC1yZXNpc3Rvci1wZXItY3MiLCAmbGVuKSkKKwkJZGV2X2luZm8tPmNhbF9y
ZXNpc3RvcnNfcGVyX2NzID0gdHJ1ZTsKKworCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShu
cF9kZHIgLCAiamVkZWMsbHBkZHIyLXM0IikpCisJCWRldl9pbmZvLT50eXBlID0gRERSX1RZUEVf
TFBERFIyX1M0OworCWVsc2UgaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wX2RkciAsICJq
ZWRlYyxscGRkcjItczIiKSkKKwkJZGV2X2luZm8tPnR5cGUgPSBERFJfVFlQRV9MUEREUjJfUzI7
CisKKwlvZl9wcm9wZXJ0eV9yZWFkX3UzMihucF9kZHIsICJkZW5zaXR5IiwgJmRlbnNpdHkpOwor
CW9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wX2RkciwgImlvLXdpZHRoIiwgJmlvX3dpZHRoKTsKKwor
CS8qIENvbnZlcnQgZnJvbSBkZW5zaXR5IGluIE1iIHRvIHRoZSBkZW5zaXR5IGVuY29kaW5nIGlu
IGplZGNfZGRyLmggKi8KKwlpZiAoZGVuc2l0eSAmIChkZW5zaXR5IC0gMSkpCisJCWRldl9pbmZv
LT5kZW5zaXR5ID0gMDsKKwllbHNlCisJCWRldl9pbmZvLT5kZW5zaXR5ID0gX19mbHMoZGVuc2l0
eSkgLSA1OworCisJLyogQ29udmVydCBmcm9tIGlvX3dpZHRoIGluIGJpdHMgdG8gaW9fd2lkdGgg
ZW5jb2RpbmcgaW4gamVkY19kZHIuaCAqLworCWlmIChpb193aWR0aCAmIChpb193aWR0aCAtIDEp
KQorCQlkZXZfaW5mby0+aW9fd2lkdGggPSAwOworCWVsc2UKKwkJZGV2X2luZm8tPmlvX3dpZHRo
ID0gX19mbHMoaW9fd2lkdGgpIC0gMTsKK30KKworc3RhdGljIHN0cnVjdCBlbWlmX2RhdGEgKiBf
X2luaXRfb3JfbW9kdWxlIG9mX2dldF9kZXZpY2VfZGV0YWlscygKKwkJc3RydWN0IGRldmljZV9u
b2RlICpucF9lbWlmLCBzdHJ1Y3QgZGV2aWNlICpkZXYpCit7CisJc3RydWN0IGVtaWZfZGF0YQkJ
KmVtaWYgPSBOVUxMOworCXN0cnVjdCBkZHJfZGV2aWNlX2luZm8JCSpkZXZfaW5mbyA9IE5VTEw7
CisJc3RydWN0IGVtaWZfcGxhdGZvcm1fZGF0YQkqcGQgPSBOVUxMOworCXN0cnVjdCBkZXZpY2Vf
bm9kZQkJKm5wX2RkcjsKKwlpbnQJCQkJbGVuOworCisJbnBfZGRyID0gb2ZfcGFyc2VfcGhhbmRs
ZShucF9lbWlmLCAiZGV2aWNlLWhhbmRsZSIsIDApOworCWlmICghbnBfZGRyKQorCQlnb3RvIGVy
cm9yOworCWVtaWYJPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2Yoc3RydWN0IGVtaWZfZGF0YSks
IEdGUF9LRVJORUwpOworCXBkCT0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwZCksIEdGUF9L
RVJORUwpOworCWRldl9pbmZvID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkZXZfaW5mbyks
IEdGUF9LRVJORUwpOworCisJaWYgKCFlbWlmIHx8ICFwZCB8fCAhZGV2X2luZm8pIHsKKwkJZGV2
X2VycihkZXYsICIlczogb2ZfZ2V0X2RldmljZV9kZXRhaWxzKCkgZmFpbHVyZSEhXG4iLAorCQkJ
X19mdW5jX18pOworCQlnb3RvIGVycm9yOworCX0KKworCWVtaWYtPnBsYXRfZGF0YQkJPSBwZDsK
KwlwZC0+ZGV2aWNlX2luZm8JCT0gZGV2X2luZm87CisJZW1pZi0+ZGV2CQk9IGRldjsKKwllbWlm
LT5ucF9kZHIJCT0gbnBfZGRyOworCWVtaWYtPnRlbXBlcmF0dXJlX2xldmVsCT0gU0RSQU1fVEVN
UF9OT01JTkFMOworCisJaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wX2VtaWYsICJ0aSxl
bWlmLTRkIikpCisJCWVtaWYtPnBsYXRfZGF0YS0+aXBfcmV2ID0gRU1JRl80RDsKKwllbHNlIGlm
IChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucF9lbWlmLCAidGksZW1pZi00ZDUiKSkKKwkJZW1p
Zi0+cGxhdF9kYXRhLT5pcF9yZXYgPSBFTUlGXzRENTsKKworCW9mX3Byb3BlcnR5X3JlYWRfdTMy
KG5wX2VtaWYsICJwaHktdHlwZSIsICZwZC0+cGh5X3R5cGUpOworCisJaWYgKG9mX2ZpbmRfcHJv
cGVydHkobnBfZW1pZiwgImh3LWNhcHMtbGwtaW50ZXJmYWNlIiwgJmxlbikpCisJCXBkLT5od19j
YXBzIHw9IEVNSUZfSFdfQ0FQU19MTF9JTlRFUkZBQ0U7CisKKwlvZl9nZXRfZGRyX2luZm8obnBf
ZW1pZiwgbnBfZGRyLCBkZXZfaW5mbyk7CisJaWYgKCFpc19kZXZfZGF0YV92YWxpZChwZC0+ZGV2
aWNlX2luZm8tPnR5cGUsIHBkLT5kZXZpY2VfaW5mby0+ZGVuc2l0eSwKKwkJCXBkLT5kZXZpY2Vf
aW5mby0+aW9fd2lkdGgsIHBkLT5waHlfdHlwZSwgcGQtPmlwX3JldiwKKwkJCWVtaWYtPmRldikp
IHsKKwkJZGV2X2VycihkZXYsICIlczogaW52YWxpZCBkZXZpY2UgZGF0YSEhXG4iLCBfX2Z1bmNf
Xyk7CisJCWdvdG8gZXJyb3I7CisJfQorCS8qCisJICogRm9yIEVNSUYgaW5zdGFuY2VzIG90aGVy
IHRoYW4gRU1JRjEgc2VlIGlmIHRoZSBkZXZpY2VzIGNvbm5lY3RlZAorCSAqIGFyZSBleGFjdGx5
IHNhbWUgYXMgb24gRU1JRjEod2hpY2ggaXMgdHlwaWNhbGx5IHRoZSBjYXNlKS4gSWYgc28sCisJ
ICogbWFyayBpdCBhcyBhIGR1cGxpY2F0ZSBvZiBFTUlGMS4gVGhpcyB3aWxsIHNhdmUgc29tZSBt
ZW1vcnkgYW5kCisJICogY29tcHV0YXRpb24uCisJICovCisJaWYgKGVtaWYxICYmIGVtaWYxLT5u
cF9kZHIgPT0gbnBfZGRyKSB7CisJCWVtaWYtPmR1cGxpY2F0ZSA9IHRydWU7CisJCWdvdG8gb3V0
OworCX0gZWxzZSBpZiAoZW1pZjEpIHsKKwkJZGV2X3dhcm4oZW1pZi0+ZGV2LCAiJXM6IE5vbi1z
eW1tZXRyaWMgRERSIGdlb21ldHJ5XG4iLAorCQkJX19mdW5jX18pOworCX0KKworCW9mX2dldF9j
dXN0b21fY29uZmlncyhucF9lbWlmLCBlbWlmKTsKKwllbWlmLT5wbGF0X2RhdGEtPnRpbWluZ3Mg
PSBvZl9nZXRfZGRyX3RpbWluZ3MobnBfZGRyLCBlbWlmLT5kZXYsCisJCQkJCWVtaWYtPnBsYXRf
ZGF0YS0+ZGV2aWNlX2luZm8tPnR5cGUsCisJCQkJCSZlbWlmLT5wbGF0X2RhdGEtPnRpbWluZ3Nf
YXJyX3NpemUpOworCisJZW1pZi0+cGxhdF9kYXRhLT5taW5fdGNrID0gb2ZfZ2V0X21pbl90Y2so
bnBfZGRyLCBlbWlmLT5kZXYpOworCWdvdG8gb3V0OworCitlcnJvcjoKKwlyZXR1cm4gTlVMTDsK
K291dDoKKwlyZXR1cm4gZW1pZjsKK30KKworI2Vsc2UKKworc3RhdGljIHN0cnVjdCBlbWlmX2Rh
dGEgKiBfX2luaXRfb3JfbW9kdWxlIG9mX2dldF9kZXZpY2VfZGV0YWlscygKKwkJc3RydWN0IGRl
dmljZV9ub2RlICpucF9lbWlmLCBzdHJ1Y3QgZGV2aWNlICpkZXYpCit7CisJcmV0dXJuIE5VTEw7
Cit9CisjZW5kaWYKKwogc3RhdGljIHN0cnVjdCBlbWlmX2RhdGEgKl9faW5pdF9vcl9tb2R1bGUg
Z2V0X2RldmljZV9kZXRhaWxzKAogCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewpA
QCAtMTI2Nyw3ICsxNDMzLDExIEBAIHN0YXRpYyBpbnQgX19pbml0X29yX21vZHVsZSBlbWlmX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJc3RydWN0IHJlc291cmNlCQkqcmVz
OwogCWludAkJCWlycTsKIAotCWVtaWYgPSBnZXRfZGV2aWNlX2RldGFpbHMocGRldik7CisJaWYg
KHBkZXYtPmRldi5vZl9ub2RlKQorCQllbWlmID0gb2ZfZ2V0X2RldmljZV9kZXRhaWxzKHBkZXYt
PmRldi5vZl9ub2RlLCAmcGRldi0+ZGV2KTsKKwllbHNlCisJCWVtaWYgPSBnZXRfZGV2aWNlX2Rl
dGFpbHMocGRldik7CisKIAlpZiAoIWVtaWYpIHsKIAkJcHJfZXJyKCIlczogZXJyb3IgZ2V0dGlu
ZyBkZXZpY2UgZGF0YVxuIiwgX19mdW5jX18pOwogCQlnb3RvIGVycm9yOwpAQCAtMTY0NCwxMSAr
MTgxNCwyMSBAQCBzdGF0aWMgdm9pZCBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSBmcmVxX3Bvc3Rf
bm90aWZ5X2hhbmRsaW5nKHZvaWQpCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZW1pZl9sb2Nr
LCBpcnFfc3RhdGUpOwogfQogCisjaWYgZGVmaW5lZChDT05GSUdfT0YpCitzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBlbWlmX29mX21hdGNoW10gPSB7CisJCXsgLmNvbXBhdGlibGUg
PSAidGksZW1pZi00ZCIgfSwKKwkJeyAuY29tcGF0aWJsZSA9ICJ0aSxlbWlmLTRkNSIgfSwKKwkJ
e30sCit9OworTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgZW1pZl9vZl9tYXRjaCk7CisjZW5kaWYK
Kwogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZW1pZl9kcml2ZXIgPSB7CiAJLnJlbW92
ZQkJPSBfX2V4aXRfcChlbWlmX3JlbW92ZSksCiAJLnNodXRkb3duCT0gZW1pZl9zaHV0ZG93biwK
IAkuZHJpdmVyID0gewogCQkubmFtZSA9ICJlbWlmIiwKKwkJLm9mX21hdGNoX3RhYmxlID0gb2Zf
bWF0Y2hfcHRyKGVtaWZfb2ZfbWF0Y2gpLAogCX0sCiB9OwogCmRpZmYgLS1naXQgYS9kcml2ZXJz
L21lbW9yeS9vZl9tZW1vcnkuYyBiL2RyaXZlcnMvbWVtb3J5L29mX21lbW9yeS5jCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjYwMDc0MzUKLS0tIC9kZXYvbnVsbAorKysgYi9k
cml2ZXJzL21lbW9yeS9vZl9tZW1vcnkuYwpAQCAtMCwwICsxLDE1MyBAQAorLyoKKyAqIE9wZW5G
aXJtd2FyZSBoZWxwZXJzIGZvciBtZW1vcnkgZHJpdmVycworICoKKyAqIENvcHlyaWdodCAoQykg
MjAxMiBUZXhhcyBJbnN0cnVtZW50cywgSW5jLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24g
MiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4KKyNpbmNsdWRlIDxsaW51
eC9vZi5oPgorI2luY2x1ZGUgPGxpbnV4L2dmcC5oPgorI2luY2x1ZGUgPG1lbW9yeS9qZWRlY19k
ZHIuaD4KKyNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4KKworLyoqCisgKiBvZl9nZXRfbWluX3Rj
aygpIC0gZXh0cmFjdCBtaW4gdGltaW5nIHZhbHVlcyBmb3IgZGRyCisgKiBAbnA6IHBvaW50ZXIg
dG8gZGRyIGRldmljZSB0cmVlIG5vZGUKKyAqIEBkZXZpY2U6IGRldmljZSByZXF1ZXN0aW5nIGZv
ciBtaW4gdGltaW5nIHZhbHVlcworICoKKyAqIFBvcHVsYXRlcyB0aGUgbHBkZHIyX21pbl90Y2sg
c3RydWN0dXJlIGJ5IGV4dHJhY3RpbmcgZGF0YQorICogZnJvbSBkZXZpY2UgdHJlZSBub2RlLiBS
ZXR1cm5zIGEgcG9pbnRlciB0byB0aGUgcG9wdWxhdGVkCisgKiBzdHJ1Y3R1cmUuIElmIGFueSBl
cnJvciBpbiBwb3B1bGF0aW5nIHRoZSBzdHJ1Y3R1cmUsIHJldHVybnMKKyAqIGRlZmF1bHQgbWlu
IHRpbWluZ3MgcHJvdmlkZWQgYnkgSkVERUMuCisgKi8KK2NvbnN0IHN0cnVjdCBscGRkcjJfbWlu
X3RjayAqb2ZfZ2V0X21pbl90Y2soc3RydWN0IGRldmljZV9ub2RlICpucCwKKwkJc3RydWN0IGRl
dmljZSAqZGV2KQoreworCWludAkJCXJldCA9IDA7CisJc3RydWN0IGxwZGRyMl9taW5fdGNrCSpt
aW47CisKKwltaW4gPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKm1pbiksIEdGUF9LRVJORUwp
OworCWlmICghbWluKQorCQlnb3RvIGRlZmF1bHRfbWluX3RjazsKKworCXJldCB8PSBvZl9wcm9w
ZXJ0eV9yZWFkX3UzMihucCwgInRSUGFiLW1pbi10Y2siLCAmbWluLT50UlBhYik7CisJcmV0IHw9
IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFJDRC1taW4tdGNrIiwgJm1pbi0+dFJDRCk7CisJ
cmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFdSLW1pbi10Y2siLCAmbWluLT50V1Ip
OworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInRSQVNtaW4tbWluLXRjayIsICZt
aW4tPnRSQVNtaW4pOworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInRSUkQtbWlu
LXRjayIsICZtaW4tPnRSUkQpOworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInRX
VFItbWluLXRjayIsICZtaW4tPnRXVFIpOworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihu
cCwgInRYUC1taW4tdGNrIiwgJm1pbi0+dFhQKTsKKwlyZXQgfD0gb2ZfcHJvcGVydHlfcmVhZF91
MzIobnAsICJ0UlRQLW1pbi10Y2siLCAmbWluLT50UlRQKTsKKwlyZXQgfD0gb2ZfcHJvcGVydHlf
cmVhZF91MzIobnAsICJ0Q0tFLW1pbi10Y2siLCAmbWluLT50Q0tFKTsKKwlyZXQgfD0gb2ZfcHJv
cGVydHlfcmVhZF91MzIobnAsICJ0Q0tFU1ItbWluLXRjayIsICZtaW4tPnRDS0VTUik7CisJcmV0
IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidEZBVy1taW4tdGNrIiwgJm1pbi0+dEZBVyk7
CisKKwlpZiAocmV0KSB7CisJCWRldm1fa2ZyZWUoZGV2LCBtaW4pOworCQlnb3RvIGRlZmF1bHRf
bWluX3RjazsKKwl9CisKKwlyZXR1cm4gbWluOworCitkZWZhdWx0X21pbl90Y2s6CisJZGV2X3dh
cm4oZGV2LCAiJXM6IHVzaW5nIGRlZmF1bHQgbWluLXRjayB2YWx1ZXNcbiIsIF9fZnVuY19fKTsK
KwlyZXR1cm4gJmxwZGRyMl9qZWRlY19taW5fdGNrOworfQorRVhQT1JUX1NZTUJPTChvZl9nZXRf
bWluX3Rjayk7CisKK3N0YXRpYyBpbnQgb2ZfZG9fZ2V0X3RpbWluZ3Moc3RydWN0IGRldmljZV9u
b2RlICpucCwKKwkJc3RydWN0IGxwZGRyMl90aW1pbmdzICp0aW0pCit7CisJaW50IHJldDsKKwor
CXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAibWF4LWZyZXEiLCAmdGltLT5tYXhfZnJl
cSk7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAibWluLWZyZXEiLCAmdGltLT5t
aW5fZnJlcSk7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFJQYWIiLCAmdGlt
LT50UlBhYik7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFJDRCIsICZ0aW0t
PnRSQ0QpOworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInRXUiIsICZ0aW0tPnRX
Uik7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFJBUy1taW4iLCAmdGltLT50
UkFTX21pbik7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFJSRCIsICZ0aW0t
PnRSUkQpOworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInRXVFIiLCAmdGltLT50
V1RSKTsKKwlyZXQgfD0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJ0WFAiLCAmdGltLT50WFAp
OworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInRSVFAiLCAmdGltLT50UlRQKTsK
KwlyZXQgfD0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJ0Q0tFU1IiLCAmdGltLT50Q0tFU1Ip
OworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInREUVNDSy1tYXgiLCAmdGltLT50
RFFTQ0tfbWF4KTsKKwlyZXQgfD0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJ0RkFXIiwgJnRp
bS0+dEZBVyk7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFpRQ1MiLCAmdGlt
LT50WlFDUyk7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFpRQ0wiLCAmdGlt
LT50WlFDTCk7CisJcmV0IHw9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAidFpRaW5pdCIsICZ0
aW0tPnRaUWluaXQpOworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInRSQVMtbWF4
LW5zIiwgJnRpbS0+dFJBU19tYXhfbnMpOworCXJldCB8PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihu
cCwgInREUVNDSy1tYXgtZGVyYXRlZCIsCisJCSZ0aW0tPnREUVNDS19tYXhfZGVyYXRlZCk7CisK
KwlyZXR1cm4gcmV0OworfQorCisvKioKKyAqIG9mX2dldF9kZHJfdGltaW5ncygpIC0gZXh0cmFj
dHMgdGhlIGRkciB0aW1pbmdzIGFuZCB1cGRhdGVzIG5vIG9mCisgKiBmcmVxdWVuY2llcyBhdmFp
bGFibGUuCisgKiBAbnBfZGRyOiBQb2ludGVyIHRvIGRkciBkZXZpY2UgdHJlZSBub2RlCisgKiBA
ZGV2OiBEZXZpY2UgcmVxdWVzdGluZyBmb3IgZGRyIHRpbWluZ3MKKyAqIEBkZXZpY2VfdHlwZTog
VHlwZSBvZiBkZHIoTFBERFIyIFMyL1M0KQorICogQG5yX2ZyZXF1ZW5jaWVzOiBObyBvZiBmcmVx
dWVuY2llcyBhdmFpbGFibGUgZm9yIGRkcgorICogKHVwZGF0ZWQgYnkgdGhpcyBmdW5jdGlvbikK
KyAqCisgKiBQb3B1bGF0ZXMgbHBkZHIyX3RpbWluZ3Mgc3RydWN0dXJlIGJ5IGV4dHJhY3Rpbmcg
ZGF0YSBmcm9tIGRldmljZQorICogdHJlZSBub2RlLiBSZXR1cm5zIHBvaW50ZXIgdG8gcG9wdWxh
dGVkIHN0cnVjdHVyZS4gSWYgYW55IGVycm9yCisgKiB3aGlsZSBwb3B1bGF0aW5nLCByZXR1cm5z
IGRlZmF1bHQgdGltaW5ncyBwcm92aWRlZCBieSBKRURFQy4KKyAqLworY29uc3Qgc3RydWN0IGxw
ZGRyMl90aW1pbmdzICpvZl9nZXRfZGRyX3RpbWluZ3Moc3RydWN0IGRldmljZV9ub2RlICpucF9k
ZHIsCisJCXN0cnVjdCBkZXZpY2UgKmRldiwgdTMyIGRldmljZV90eXBlLCB1MzIgKm5yX2ZyZXF1
ZW5jaWVzKQoreworCXN0cnVjdCBscGRkcjJfdGltaW5ncwkqdGltaW5ncyA9IE5VTEw7CisJdTMy
CQkJYXJyX3N6ID0gMCwgaSA9IDA7CisJc3RydWN0IGRldmljZV9ub2RlCSpucF90aW07CisJY2hh
cgkJCSp0aW1fY29tcGF0OworCisJc3dpdGNoIChkZXZpY2VfdHlwZSkgeworCWNhc2UgRERSX1RZ
UEVfTFBERFIyX1MyOgorCWNhc2UgRERSX1RZUEVfTFBERFIyX1M0OgorCQl0aW1fY29tcGF0ID0g
ImplZGVjLGxwZGRyMi10aW1pbmdzIjsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJZGV2X3dhcm4o
ZGV2LCAiJXM6IHVuLXN1cHBvcnRlZCBtZW1vcnkgdHlwZVxuIiwgX19mdW5jX18pOworCX0KKwor
CWZvcl9lYWNoX2NoaWxkX29mX25vZGUobnBfZGRyLCBucF90aW0pCisJCWlmIChvZl9kZXZpY2Vf
aXNfY29tcGF0aWJsZShucF90aW0sIHRpbV9jb21wYXQpKQorCQkJYXJyX3N6Kys7CisKKwlpZiAo
YXJyX3N6KQorCQl0aW1pbmdzID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCp0aW1pbmdzKSAq
IGFycl9zeiwKKwkJCUdGUF9LRVJORUwpOworCisJaWYgKCF0aW1pbmdzKQorCQlnb3RvIGRlZmF1
bHRfdGltaW5nczsKKworCWZvcl9lYWNoX2NoaWxkX29mX25vZGUobnBfZGRyLCBucF90aW0pIHsK
KwkJaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wX3RpbSwgdGltX2NvbXBhdCkpIHsKKwkJ
CWlmIChvZl9kb19nZXRfdGltaW5ncyhucF90aW0sICZ0aW1pbmdzW2ldKSkgeworCQkJCWRldm1f
a2ZyZWUoZGV2LCB0aW1pbmdzKTsKKwkJCQlnb3RvIGRlZmF1bHRfdGltaW5nczsKKwkJCX0KKwkJ
CWkrKzsKKwkJfQorCX0KKworCSpucl9mcmVxdWVuY2llcyA9IGFycl9zejsKKworCXJldHVybiB0
aW1pbmdzOworCitkZWZhdWx0X3RpbWluZ3M6CisJZGV2X3dhcm4oZGV2LCAiJXM6IHVzaW5nIGRl
ZmF1bHQgdGltaW5nc1xuIiwgX19mdW5jX18pOworCSpucl9mcmVxdWVuY2llcyA9IEFSUkFZX1NJ
WkUobHBkZHIyX2plZGVjX3RpbWluZ3MpOworCXJldHVybiBscGRkcjJfamVkZWNfdGltaW5nczsK
K30KK0VYUE9SVF9TWU1CT0wob2ZfZ2V0X2Rkcl90aW1pbmdzKTsKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWVtb3J5L29mX21lbW9yeS5oIGIvZHJpdmVycy9tZW1vcnkvb2ZfbWVtb3J5LmgKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMjBiNDk2ZQotLS0gL2Rldi9udWxsCisrKyBi
L2RyaXZlcnMvbWVtb3J5L29mX21lbW9yeS5oCkBAIC0wLDAgKzEsMzYgQEAKKy8qCisgKiBPcGVu
RmlybXdhcmUgaGVscGVycyBmb3IgbWVtb3J5IGRyaXZlcnMKKyAqCisgKiBDb3B5cmlnaHQgKEMp
IDIwMTIgVGV4YXMgSW5zdHJ1bWVudHMsIEluYy4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJs
aXNoZWQgYnkKKyAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9u
IDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJz
aW9uLgorICovCisKKyNpZm5kZWYgX19MSU5VWF9NRU1PUllfT0ZfUkVHX0gKKyNkZWZpbmUgX19M
SU5VWF9NRU1PUllfT0ZfUkVHX0gKKworI2lmZGVmIENPTkZJR19PRgorZXh0ZXJuIGNvbnN0IHN0
cnVjdCBscGRkcjJfbWluX3RjayAqb2ZfZ2V0X21pbl90Y2soc3RydWN0IGRldmljZV9ub2RlICpu
cCwKKwkJc3RydWN0IGRldmljZSAqZGV2KTsKK2V4dGVybiBjb25zdCBzdHJ1Y3QgbHBkZHIyX3Rp
bWluZ3MKKwkqb2ZfZ2V0X2Rkcl90aW1pbmdzKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnBfZGRyLCBz
dHJ1Y3QgZGV2aWNlICpkZXYsCisJdTMyIGRldmljZV90eXBlLCB1MzIgKm5yX2ZyZXF1ZW5jaWVz
KTsKKyNlbHNlCitzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBscGRkcjJfbWluX3RjaworCSpv
Zl9nZXRfbWluX3RjayhzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBzdHJ1Y3QgZGV2aWNlICpkZXYp
Cit7CisJcmV0dXJuIE5VTEw7Cit9CisKK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGxwZGRy
Ml90aW1pbmdzCisJKm9mX2dldF9kZHJfdGltaW5ncyhzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wX2Rk
ciwgc3RydWN0IGRldmljZSAqZGV2LAorCXUzMiBkZXZpY2VfdHlwZSwgdTMyICpucl9mcmVxdWVu
Y2llcykKK3sKKwlyZXR1cm4gTlVMTDsKK30KKyNlbmRpZiAvKiBDT05GSUdfT0YgKi8KKworI2Vu
ZGlmIC8qIF9fTElOVVhfTUVNT1JZX09GX1JFR18gKi8KLS0gCjEuNy45LjUKCg==
--20cf3005dc56044bd204c509979f--
