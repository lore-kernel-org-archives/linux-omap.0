From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] cpufreq: OMAP: Register an Energy Model
Date: Wed,  6 Feb 2019 23:35:50 -0500
Message-ID: <20190207043550.3890-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, quentin.perret@arm.com, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Try and register an Energy Model from omap-cpufreq.c to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/omap-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 71e81bbf031b..68052b74d28f 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -133,8 +133,10 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 
 	/* FIXME: what's the actual transition time? */
 	result = cpufreq_generic_init(policy, freq_table, 300 * 1000);
-	if (!result)
+	if (!result) {
+		dev_pm_opp_of_register_em(policy->cpus);
 		return 0;
+	}
 
 	freq_table_free();
 fail:
-- 
2.17.0
