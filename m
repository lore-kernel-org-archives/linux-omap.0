From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
Date: Fri, 8 May 2015 14:57:30 -0500
Message-ID: <1431115050-23693-2-git-send-email-balbi@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60112 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbbEHT7r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2015 15:59:47 -0400
In-Reply-To: <1431115050-23693-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Felipe Balbi <balbi@ti.com>

by adding the missing MODULE_ALIAS(), cpufreq-dt
can be autoloaded by udev/systemd.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cpufreq/cpufreq-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db54b7e..528a82bf5038 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -416,6 +416,7 @@ static struct platform_driver dt_cpufreq_platdrv = {
 };
 module_platform_driver(dt_cpufreq_platdrv);
 
+MODULE_ALIAS("platform:cpufreq-dt");
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
 MODULE_DESCRIPTION("Generic cpufreq driver");
-- 
2.4.0.rc3

