From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 03/04] OMAP3 SRF: omap3 srf driver
Date: Fri, 17 Oct 2008 16:34:37 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B038EC2B@dbde02.ent.ti.com>
References: <022501c92f99$331425f0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59592 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYJQLEt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 07:04:49 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9HB4fUG016262
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 06:04:47 -0500
In-Reply-To: <022501c92f99$331425f0$LocalHost@wipultra1382>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>+ */
>+int set_latency(struct shared_resource *resp, u32 latency)
>+{
>+	u8 *pm_qos_req_added;
>+
>+	if (resp->curr_level == latency)
>+		return 0;
>+	else
>+		/* Update the resources current level */
>+		resp->curr_level = latency;
>+
[Romit] I think this should be done outside this function, in update_resource_level function. 
>+	pm_qos_req_added = resp->resource_data;
>+	if (latency == RES_DEFAULTLEVEL)
>+		/* No more users left, remove the pm_qos_req if present */
>+		if (*pm_qos_req_added) {
>+
>	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
>+							resp->name);
>+			*pm_qos_req_added = 0;
>+			return 0;
>+		}
>+
>+	if (*pm_qos_req_added) {
>+		return
>pm_qos_update_requirement(PM_QOS_CPU_DMA_LATENCY,
>+						resp->name, latency);
>+	} else {
[Romit] Shouldn't the following line execute only if pm_qos_add_requirement returns successfully?
>+		*pm_qos_req_added = 1;
>+		return pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY,
>+						resp->name, latency);
>+	}
>+}
>+
>+int set_pd_latency(struct shared_resource *resp, u32 latency)
>+{
>+	u32 pd_lat_level, ind;
>+	struct pd_latency_db *pd_lat_db;
>+	struct powerdomain *pwrdm;
>+
>+	pd_lat_db = resp->resource_data;
>+	pwrdm = pd_lat_db->pd;
>+	pd_lat_level = PD_LATENCY_OFF;
>+	/* using the latency db map to the appropriate PD state */
>+	for (ind = 0; ind < PD_LATENCY_MAXLEVEL; ind++) {
>+		if (pd_lat_db->latency[ind] < latency) {
>+			pd_lat_level = ind;
>+			break;
>+		}
>+	}
>+
[Romit] Again is this the right place for this?  It should be done only if set_pwrdm_state returns successfully. So I think that should be checked as well.
>+	resp->curr_level = pd_lat_level;
>+	set_pwrdm_state(pwrdm, pd_lat_level);
>+	return 0;
>+}
