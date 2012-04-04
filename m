From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 17/17][V2] ARM: OMAP3: cpuidle - set global variables static
Date: Wed,  4 Apr 2012 22:12:51 +0200
Message-ID: <1333570371-1389-18-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59126 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab2DDUN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 16:13:27 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so417996wej.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 13:13:26 -0700 (PDT)
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

and check the powerdomain lookup is successful.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 882d349..413aac4 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -75,7 +75,7 @@ static struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES] = {
 	},
 };
 
-struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
@@ -364,6 +364,9 @@ int __init omap3_idle_init(void)
 	per_pd = pwrdm_lookup("per_pwrdm");
 	cam_pd = pwrdm_lookup("cam_pwrdm");
 
+	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
+		return -ENODEV;
+
 	/*
 	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
 	 * enable OFF mode in a stable form for previous revisions.
-- 
1.7.5.4

