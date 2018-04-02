From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 1/2] cpufreq: ti-cpufreq: Fix an incorrect error return value
Date: Mon, 2 Apr 2018 11:49:57 -0500
Message-ID: <20180402164958.20057-2-s-anna@ti.com>
References: <20180402164958.20057-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180402164958.20057-1-s-anna@ti.com>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>, Zumeng Chen <zumeng.chen@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when
failure") has fixed a memory leak in the failure path, however
the patch returned a positive value on get_cpu_device() failure
instead of the previous negative value. Fix this incorrect error
return value properly.

Fixes: 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when failure")
Cc: Zumeng Chen <zumeng.chen@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index a099b7bf74cd..46d1ab2dea87 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -226,7 +226,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	opp_data->cpu_dev = get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
 		pr_err("%s: Failed to get device for CPU0\n", __func__);
-		ret = ENODEV;
+		ret = -ENODEV;
 		goto free_opp_data;
 	}
 
-- 
2.16.2
