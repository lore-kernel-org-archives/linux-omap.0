From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 15/17][V2] ARM: OMAP3: set omap3_idle_data as static
Date: Wed,  4 Apr 2012 22:12:49 +0200
Message-ID: <1333570371-1389-16-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59126 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab2DDUNW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 16:13:22 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so417996wej.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 13:13:22 -0700 (PDT)
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 35a1471..f54e6ae 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -46,7 +46,7 @@ struct omap3_idle_statedata {
 
 #define OMAP3_NUM_STATES 7
 
-struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES] = {
+static struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES] = {
 	{
 		.mpu_state = PWRDM_POWER_ON,
 		.core_state = PWRDM_POWER_ON,
-- 
1.7.5.4

