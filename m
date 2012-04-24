From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 05/18][V3] ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
Date: Tue, 24 Apr 2012 16:05:26 +0200
Message-ID: <1335276339-11135-6-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33562 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab2DXOFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:05:51 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so716062wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:05:51 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

We initialize the omap4_idle_data variable at compile time allowing us
to remove in the next patch the initialization done at boot time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 38ecd27..9e3effa 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -31,9 +31,24 @@ struct omap4_idle_statedata {
 	u32 mpu_state;
 };
 
-#define OMAP4_NUM_STATES 3
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
 
-static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
 static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
 
 /**
@@ -152,7 +167,7 @@ struct cpuidle_driver omap4_idle_driver = {
 			.desc = "MPUSS OSWR",
 		},
 	},
-	.state_count = OMAP4_NUM_STATES,
+	.state_count = ARRAY_SIZE(omap4_idle_data),
 	.safe_state_index = 0,
 };
 
-- 
1.7.5.4

