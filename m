From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 2/2] cpufreq: ti-cpufreq: Use devres managed API in probe()
Date: Thu, 31 May 2018 17:21:44 -0500
Message-ID: <20180531222144.26739-3-s-anna@ti.com>
References: <20180531222144.26739-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180531222144.26739-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>, Zumeng Chen <zumeng.chen@gmail.com>
List-Id: linux-omap@vger.kernel.org

The ti_cpufreq_probe() function uses regular kzalloc to allocate
the ti_cpufreq_data structure and kfree for freeing this memory
on failures. Simplify this code by using the devres managed
API.

Cc: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ti-cpufreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 896caba5dfe5..3f0e2a14895a 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -217,7 +217,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (!match)
 		return -ENODEV;
 
-	opp_data = kzalloc(sizeof(*opp_data), GFP_KERNEL);
+	opp_data = devm_kzalloc(&pdev->dev, sizeof(*opp_data), GFP_KERNEL);
 	if (!opp_data)
 		return -ENOMEM;
 
@@ -226,8 +226,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	opp_data->cpu_dev = get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
 		pr_err("%s: Failed to get device for CPU0\n", __func__);
-		ret = -ENODEV;
-		goto free_opp_data;
+		return -ENODEV;
 	}
 
 	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
@@ -285,8 +284,6 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 fail_put_node:
 	of_node_put(opp_data->opp_node);
-free_opp_data:
-	kfree(opp_data);
 
 	return ret;
 }
-- 
2.17.0
