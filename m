From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 3/5] omap3: add common twl configurations for vdd1 and vdd2
Date: Fri, 9 Dec 2011 17:29:47 +0200
Message-ID: <1323444589-19940-4-git-send-email-t-kristo@ti.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58798 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab1LIPaC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 10:30:02 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pB9FU1pK004724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:30:01 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pB9FU1Kj009616
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:30:01 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FU05O018748
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:30:01 -0600 (CST)
Received: from localhost.localdomain (h88-4.vpn.ti.com [172.24.88.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTtvE006466	for
 <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:59 -0600
In-Reply-To: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
are needed by DVFS.

Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manual.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index daa056e..7cf5347 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -115,6 +115,38 @@ static struct regulator_init_data omap3_vpll2_idata = {
 	.consumer_supplies		= omap3_vpll2_supplies,
 };
 
+static struct regulator_consumer_supply omap3_vdd1_supply[] = {
+	REGULATOR_SUPPLY("vcc", "mpu.0"),
+};
+
+static struct regulator_consumer_supply omap3_vdd2_supply[] = {
+	REGULATOR_SUPPLY("vcc", "l3_main.0"),
+};
+
+static struct regulator_init_data omap3_vdd1 = {
+	.constraints = {
+		.name			= "VDD1",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd1_supply),
+	.consumer_supplies		= omap3_vdd1_supply,
+};
+
+static struct regulator_init_data omap3_vdd2 = {
+	.constraints = {
+		.name			= "VDD2",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd2_supply),
+	.consumer_supplies		= omap3_vdd2_supply,
+};
+
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
@@ -122,6 +154,10 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 		pmic_data->irq_base = TWL4030_IRQ_BASE;
 	if (!pmic_data->irq_end)
 		pmic_data->irq_end = TWL4030_IRQ_END;
+	if (!pmic_data->vdd1)
+		pmic_data->vdd1 = &omap3_vdd1;
+	if (!pmic_data->vdd2)
+		pmic_data->vdd2 = &omap3_vdd2;
 
 	/* Common platform data configurations */
 	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
-- 
1.7.4.1

