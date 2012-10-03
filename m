From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/4] cpufreq: OMAP: use get_cpu_device() instead of omap_device API
Date: Wed,  3 Oct 2012 16:00:29 -0700
Message-ID: <1349305229-28480-5-git-send-email-khilman@deeprootsystems.com>
References: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62147 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531Ab2JCXAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 19:00:40 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so6813738pad.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 16:00:40 -0700 (PDT)
In-Reply-To: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

From: Kevin Hilman <khilman@ti.com>

OMAP PM core code has moved to using the existing, generic CPU devices
for attaching OPPs, so the CPUfreq driver can now use the generic
get_cpu_device() API instead of the OMAP-specific omap_device API.

This allows us to remove the last <plat/*> include from this driver.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5d1f5e4..1f3417a 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -30,8 +30,6 @@
 #include <asm/smp_plat.h>
 #include <asm/cpu.h>
 
-#include <plat/omap_device.h>
-
 /* OPP tolerance in percentage */
 #define	OPP_TOLERANCE	4
 
@@ -255,10 +253,10 @@ static struct cpufreq_driver omap_driver = {
 
 static int __init omap_cpufreq_init(void)
 {
-	mpu_dev = omap_device_get_by_hwmod_name("mpu");
-	if (IS_ERR(mpu_dev)) {
+	mpu_dev = get_cpu_device(0);
+	if (!mpu_dev) {
 		pr_warning("%s: unable to get the mpu device\n", __func__);
-		return PTR_ERR(mpu_dev);
+		return -EINVAL;
 	}
 
 	mpu_reg = regulator_get(mpu_dev, "vcc");
-- 
1.7.9.2

