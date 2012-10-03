From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/4] cpufreq: OMAP: ensure valid clock rate before scaling
Date: Wed,  3 Oct 2012 16:00:26 -0700
Message-ID: <1349305229-28480-2-git-send-email-khilman@deeprootsystems.com>
References: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50617 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443Ab2JCXAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 19:00:34 -0400
Received: by pbbrr4 with SMTP id rr4so10334005pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 16:00:34 -0700 (PDT)
In-Reply-To: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

From: Kevin Hilman <khilman@ti.com>

Ensure the clock rate that will be used is a valid one before
attempting to scale the voltage.  Currently the driver assumes it has
a valid frequency from the OPP table, but boards using different
system oscillators might not have exact matches with the OPP table,
and result in a failing call to clk_set_rate().

This is particularily bad because the voltage may be scaled even
though the frequency is not.  This will obviously lead to some
unpredictable behavior, especially if the frequency is high and
the voltage is dropped.

Thanks to Joni Lapilainen for reporting crashes seen on 3430/n900.

Reported-by: Joni Lapilainen <joni.lapilainen@gmail.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 65f8e9a..0fe395a 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -108,6 +108,14 @@ static int omap_target(struct cpufreq_policy *policy,
 	}
 
 	freq = freqs.new * 1000;
+	ret = clk_round_rate(mpu_clk, freq);
+	if (IS_ERR_VALUE(ret)) {
+		dev_warn(mpu_dev,
+			 "CPUfreq: Cannot find matching frequency for %lu\n",
+			 freq);
+		return ret;
+	}
+	freq = ret;
 
 	if (mpu_reg) {
 		opp = opp_find_freq_ceil(mpu_dev, &freq);
-- 
1.7.9.2

