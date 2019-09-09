From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
Date: Mon,  9 Sep 2019 10:45:01 -0500
Message-ID: <20190909154502.19804-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: neolynx@gmail.com, letux-kernel@openphoenux.org, andreas@kemnade.info, tony@atomide.com, adam.ford@logicpd.com, hns@goldelico.com, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The AM3517 only lists 600MHz @ 1.2V, but the revister values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch simply enable adds the am3517 to the compatible table
using the omap3630 structure instead of the 3430.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f2f58d689320..6b69fb1d6bdf 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -270,6 +270,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
 
 static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
+	{ .compatible = "ti,am3517", .data = &omap36xx_soc_data, },
 	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
 	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
-- 
2.17.1
