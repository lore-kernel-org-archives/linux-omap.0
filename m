From: Thara Gopinath <thara@ti.com>
Subject: [PM-OPP][PATCH 2/4] OMAP: Correct the return value check after call into find_device_opp
Date: Tue, 13 Jul 2010 11:17:04 +0530
Message-ID: <1279000026-24042-3-git-send-email-thara@ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com>
 <1279000026-24042-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab0GMFrV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jul 2010 01:47:21 -0400
In-Reply-To: <1279000026-24042-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, b-cousson@ti.com, sawant@ti.com, vishwanath.bs@ti.com, premi@ti.com, Thara Gopinath <thara@ti.com>

Earlier we were checking on !dev_opp where as find_device_opp returns
a error pointer in case of error. So correcting the check as in the earlier
code even if find_device_opp returns an error opp_init_cpufreq_table
was not exiting.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/opp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index a06b88d..d88a2e0 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -457,8 +457,10 @@ void opp_init_cpufreq_table(struct device *dev,
 	int i = 0;
 
 	dev_opp = find_device_opp(dev);
-	if (WARN_ON(!dev_opp))
+	if (IS_ERR(dev_opp)) {
+		WARN_ON(1);
 		return;
+	}
 
 	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
 			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
-- 
1.7.0.rc1.33.g07cf0f

