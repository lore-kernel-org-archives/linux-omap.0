From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 03/04] OMAP3 SRF: omap3 srf driver
Date: Fri, 17 Oct 2008 17:11:00 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B038EC9E@dbde02.ent.ti.com>
References: <022501c92f99$331425f0$LocalHost@wipultra1382>
 <B85A65D85D7EB246BE421B3FB0FBB59301B038EC2B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37618 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbYJQLlL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 07:41:11 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9HBf4wD029500
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 06:41:10 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B038EC2B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

One final point
>>+int set_pd_latency(struct shared_resource *resp, u32 latency)
>>+{
>>+	u32 pd_lat_level, ind;
>>+	struct pd_latency_db *pd_lat_db;
>>+	struct powerdomain *pwrdm;
>>+
>>+	pd_lat_db = resp->resource_data;
>>+	pwrdm = pd_lat_db->pd;
>>+	pd_lat_level = PD_LATENCY_OFF;
>>+	/* using the latency db map to the appropriate PD state */
>>+	for (ind = 0; ind < PD_LATENCY_MAXLEVEL; ind++) {
>>+		if (pd_lat_db->latency[ind] < latency) {
>>+			pd_lat_level = ind;
>>+			break;
>>+		}
>>+	}
>>+
>[Romit] Again is this the right place for this?  It should be done only if
>set_pwrdm_state returns successfully. So I think that should be checked as well.
>>+	resp->curr_level = pd_lat_level;
>>+	set_pwrdm_state(pwrdm, pd_lat_level);
>>+	return 0;
>>+}

[Romit]  In retrospect, I think the code is not right. Someone sets a latency for say 30ms and what gets updated is the index in the curr_level. Next [s]he sets a latency value and we will be comparing index with time. Cant we have a function that would convert the latency (in time) to the right index? 
