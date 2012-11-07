From: Joshua Emele <jemele@gmail.com>
Subject: [PATCH 2/4] cpufreq: OMAP: for omap3 devices, specify the iva clock name
Date: Tue,  6 Nov 2012 17:47:39 -0800
Message-ID: <1352252861-18384-3-git-send-email-jemele@gmail.com>
References: <1352252861-18384-1-git-send-email-jemele@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352252861-18384-1-git-send-email-jemele@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joshua Emele <jemele@gmail.com>
List-Id: linux-omap@vger.kernel.org


Signed-off-by: Joshua Emele <jemele@gmail.com>
---
 drivers/cpufreq/omap-cpufreq.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 1621208..d8a751f 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -335,9 +335,10 @@ static int __init omap_cpufreq_init(void)
 {
 	if (cpu_is_omap24xx())
 		mpu_clk_name = "virt_prcm_set";
-	else if (cpu_is_omap34xx())
+	else if (cpu_is_omap34xx()) {
 		mpu_clk_name = "dpll1_ck";
-	else if (cpu_is_omap44xx())
+		iva_clk_name = "dpll2_ck";
+	} else if (cpu_is_omap44xx())
 		mpu_clk_name = "dpll_mpu_ck";
 
 	if (!mpu_clk_name) {
-- 
1.7.6.5
