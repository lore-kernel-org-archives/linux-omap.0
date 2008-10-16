From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/04] OMAP3 SRF: omap3 srf driver
Date: Thu, 16 Oct 2008 19:42:18 +0530
Message-ID: <022501c92f99$331425f0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbYJPOM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 10:12:26 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9GECJtX016162
	for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 09:12:25 -0500
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9GECJcC024266
	for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 19:42:19 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Adds init/change_level/validate_level calls for latency 
resources on OMAP3

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |  126 +++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-10-16 18:07:14.000000000 +0530
@@ -0,0 +1,126 @@
+/*
+ * linux/arch/arm/mach-omap2/resource34xx.c
+ * OMAP3 resource init/change_level/validate_level functions
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
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
+#include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
+#include "resource34xx.h"
+
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
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
+	u32 pd_lat_level, ind;
+	struct pd_latency_db *pd_lat_db;
+	struct powerdomain *pwrdm;
+
+	pd_lat_db = resp->resource_data;
+	pwrdm = pd_lat_db->pd;
+	pd_lat_level = PD_LATENCY_OFF;
+	/* using the latency db map to the appropriate PD state */
+	for (ind = 0; ind < PD_LATENCY_MAXLEVEL; ind++) {
+		if (pd_lat_db->latency[ind] < latency) {
+			pd_lat_level = ind;
+			break;
+		}
+	}
+
+	resp->curr_level = pd_lat_level;
+	set_pwrdm_state(pwrdm, pd_lat_level);
+	return 0;
+}

