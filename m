From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/2] cpufreq: OMAP: Handle missing frequency table on SMP systems
Date: Wed, 8 Aug 2012 16:24:13 +0530
Message-ID: <1344423254-3475-2-git-send-email-rnayak@ti.com>
References: <1344423254-3475-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57160 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967Ab2HHKyn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 06:54:43 -0400
In-Reply-To: <1344423254-3475-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, linux-pm@vger.kernel.org

On OMAP4, if the first CPU fails to get a valid frequency table (this
could happen if the platform does not register any OPP table), the
subsequent CPU instances end up dealing with a NULL freq_table and
crash. Add a check for a NULL freq_table to help error the rest
of the CPU instances out.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/cpufreq/omap-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 17fa04d..0ee824c 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -221,7 +221,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (atomic_inc_return(&freq_table_users) == 1)
 		result = opp_init_cpufreq_table(mpu_dev, &freq_table);
 
-	if (result) {
+	if (result || !freq_table) {
 		dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
 				__func__, policy->cpu, result);
 		goto fail_ck;
-- 
1.7.9.5

