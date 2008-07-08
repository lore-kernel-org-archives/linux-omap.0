From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/09] omap3 srf driver
Date: Tue, 8 Jul 2008 17:09:25 +0530
Message-ID: <030a01c8e0ef$45da0220$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:36452 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661AbYGHLjd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:39:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m68BdQ9I013236
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 06:39:31 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m68BdIxI005245
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 17:09:25 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the init/change_level/validate_level calls for OMAP3
resources

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/resource34xx.c |  148 +++++++++++++++++++++++++++++++++++++
 1 files changed, 148 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-07-07 10:23:16.268846221 +0530
@@ -0,0 +1,148 @@
+/*
+ * linux/arch/arm/mach-omap2/resource34xx.c
+ * OMAP3 resource init/change_level/validate_level functions
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Written by Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ * History:
+ *
+ */
+
+#include <linux/pm_qos_params.h>
+#include <asm/arch/powerdomain.h>
+#include <asm/arch/clockdomain.h>
+#include "resource34xx.h"
+
+/**
+ * init_latency - Initializes the mpu/core latency resource.
+ * @resp: Latency resource to be initalized
+ *
+ * No return value.
+ */
+void init_latency(struct shared_resource *resp)
+{
+	resp->no_of_users = 0;
+	resp->curr_level = RES_DEFAULTLEVEL;
+	*((u8 *)resp->resource_data) = 0;
+	return;
+}
+
+/**
+ * set_latency - Adds/Updates and removes the CPU_DMA_LATENCY in *pm_qos_params.
+ * @resp: resource pointer
+ * @latency: target latency to be set
+ *
+ * Returns 0 on success, or error values as returned by
+ * pm_qos_update_requirement/pm_qos_add_requirement.
+ */
+int set_latency(struct shared_resource *resp, u32 latency)
+{
+	u8 *pm_qos_req_added;
+
+	if (resp->curr_level == latency)
+		return 0;
+	else
+		/* Update the resources current level */
+		resp->curr_level = latency;
+
+	pm_qos_req_added = resp->resource_data;
+	if (latency == RES_DEFAULTLEVEL)
+		/* No more users left, remove the pm_qos_req if present */
+		if (*pm_qos_req_added) {
+			pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
+							resp->name);
+			*pm_qos_req_added = 0;
+			return 0;
+		}
+
+	if (*pm_qos_req_added) {
+		return pm_qos_update_requirement(PM_QOS_CPU_DMA_LATENCY,
+						resp->name, latency);
+	} else {
+		*pm_qos_req_added = 1;
+		return pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY,
+						resp->name, latency);
+	}
+}
+
+/**
+ * init_pd_latency - Initializes the power domain latency resource.
+ * @resp: Power Domain Latency resource to be initialized.
+ *
+ * No return value.
+ */
+void init_pd_latency(struct shared_resource *resp)
+{
+	struct pd_latency_db *pd_lat_db;
+
+	resp->no_of_users = 0;
+	resp->curr_level = PD_LATENCY_OFF;
+	pd_lat_db = resp->resource_data;
+	/* Populate the power domain associated with the latency resource */
+	pd_lat_db->pd = pwrdm_lookup(pd_lat_db->pwrdm_name);
+	return;
+}
+
+/**
+ * set_pd_latency - Updates the curr_level of the power domain resource.
+ * @resp: Power domain latency resource.
+ * @latency: New latency value acceptable.
+ *
+ * This function maps the latency in microsecs to the acceptable
+ * Power domain state using the latency DB.
+ * It then programs the power domain to enter the target state.
+ * Always returns 0.
+ */
+int set_pd_latency(struct shared_resource *resp, u32 latency)
+{
+	u32 pd_lat_level, ind, i;
+	struct pd_latency_db *pd_lat_db;
+	struct powerdomain *pwrdm;
+
+	pd_lat_db = resp->resource_data;
+	pwrdm = pd_lat_db->pd;
+	pd_lat_level = PD_LATENCY_OFF;
+	/* using the latency db map to the appropriate PD state */
+	for (ind = 0; ind < PD_LATENCY_MAXLEVEL; ind++)
+		if (pd_lat_db->latency[ind] < latency)
+			pd_lat_level = ind;
+
+	resp->curr_level = pd_lat_level;
+	switch (pd_lat_level) {
+	case PWRDM_POWER_OFF:
+	case PWRDM_POWER_RET:
+		/* Errata 1.29: No transitions from INACTIVE to RET/OFF
+		 * possible.
+		 * Need to be taken care of here.
+		 */
+		if (pwrdm_read_pwrst(pwrdm) != PWRDM_POWER_ON) {
+			/* Force the clock domains to ON */
+			for (i = 0; pwrdm->pwrdm_clkdms[i]; i++) {
+				omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[i]);
+				omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[i]);
+			}
+			pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
+			pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
+			for (i = 0; pwrdm->pwrdm_clkdms[i]; i++) {
+				omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[i]);
+				omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[i]);
+			}
+		} else
+			pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
+		break;
+	case PWRDM_POWER_ON:
+		pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}

