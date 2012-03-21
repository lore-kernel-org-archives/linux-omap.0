From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 5/7] ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
Date: Wed, 21 Mar 2012 10:27:48 +0100
Message-ID: <1332322070-24577-6-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44783 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab2CUJ17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 05:27:59 -0400
Received: by wibhr17 with SMTP id hr17so5432423wib.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:27:58 -0700 (PDT)
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 254f97b..e14cd56 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -33,7 +33,24 @@ struct omap4_idle_statedata {
 
 #define OMAP4_NUM_STATES 3
 
-static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
+static struct omap4_idle_statedata omap4_idle_data[] = {
+	{
+		.cpu_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_POWER_ON,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_OFF,
+	},
+};
+
 static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
 
 /**
-- 
1.7.5.4

