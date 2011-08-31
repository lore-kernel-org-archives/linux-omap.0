From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 3/4] omap: smps: add smps regulator init to voltage.c
Date: Wed, 31 Aug 2011 18:11:17 +0300
Message-ID: <1314803478-15634-4-git-send-email-t-kristo@ti.com>
References: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53057 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756567Ab1HaPLv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 11:11:51 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7VFBoh1024166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:50 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7VFBo1T025334
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:50 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7VFBm4F023878
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:50 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

All voltagedomains that have support for vc and vp are now automatically
registered with SMPS regulator driver. Voltage.c builds a platform device
structure for this purpose during late init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   81 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index cebc8b1..30102a4 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -25,6 +25,9 @@
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/omap-smps.h>
 
 #include <plat/common.h>
 
@@ -238,6 +241,42 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 	}
 }
 
+static void smps_add_regulator_info(struct platform_device *smps_dev,
+			       struct voltagedomain *voltdm)
+{
+	struct omap_smps_platform_data *info;
+	struct regulator_init_data *init_data;
+	struct regulator_consumer_supply *supply;
+
+	if (!smps_dev || !voltdm)
+		return;
+
+	info = smps_dev->dev.platform_data;
+
+	init_data = kzalloc(sizeof(struct regulator_init_data), GFP_KERNEL);
+	supply = kzalloc(sizeof(struct regulator_consumer_supply), GFP_KERNEL);
+
+	if (!init_data || !supply) {
+		kfree(init_data);
+		kfree(supply);
+		return;
+	}
+	supply->supply = "vcc";
+	supply->dev_name = voltdm->proc_dev;
+	init_data->constraints.min_uV =
+		voltdm->pmic->vsel_to_uv(voltdm->pmic->vp_vddmin);
+	init_data->constraints.max_uV =
+		voltdm->pmic->vsel_to_uv(voltdm->pmic->vp_vddmax);
+	init_data->constraints.valid_modes_mask = REGULATOR_MODE_NORMAL;
+	init_data->constraints.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE;
+	init_data->num_consumer_supplies = 1;
+	init_data->consumer_supplies = supply;
+	init_data->driver_data = voltdm;
+
+	info->regulators[info->num_regulators++] = init_data;
+}
+
+
 /**
  * omap_voltage_late_init() - Init the various voltage parameters
  *
@@ -248,6 +287,11 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 int __init omap_voltage_late_init(void)
 {
 	struct voltagedomain *voltdm;
+	struct platform_device *smps_dev;
+	struct omap_smps_platform_data *smps_pdata;
+	struct regulator_init_data **reg_list;
+	int num_smps = 0;
+	int ret;
 
 	if (list_empty(&voltdm_list)) {
 		pr_err("%s: Voltage driver support not added\n",
@@ -279,8 +323,45 @@ int __init omap_voltage_late_init(void)
 			voltdm->scale = omap_vp_forceupdate_scale;
 			omap_vp_init(voltdm);
 		}
+
+		if (voltdm->vc && voltdm->vp)
+			num_smps++;
 	}
 
+	if (num_smps) {
+		smps_dev = platform_device_alloc("omap-smps", -1);
+
+		if (!smps_dev)
+			return -ENOMEM;
+
+		smps_pdata = kzalloc(sizeof(struct omap_smps_platform_data),
+			GFP_KERNEL);
+		reg_list = kzalloc(sizeof(void *) * num_smps, GFP_KERNEL);
+
+		if (!smps_pdata || !reg_list) {
+			kfree(smps_pdata);
+			kfree(reg_list);
+			return -ENOMEM;
+		}
+
+		smps_pdata->regulators = reg_list;
+
+		ret = platform_device_add_data(smps_dev, smps_pdata,
+			sizeof(struct omap_smps_platform_data));
+
+		if (ret) {
+			kfree(smps_pdata);
+			kfree(reg_list);
+			platform_device_put(smps_dev);
+			return ret;
+		}
+
+		list_for_each_entry(voltdm, &voltdm_list, node)
+			if (voltdm->vp && voltdm->vc)
+				smps_add_regulator_info(smps_dev, voltdm);
+
+		platform_device_add(smps_dev);
+	}
 	return 0;
 }
 
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

