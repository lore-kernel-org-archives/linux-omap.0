From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/4] OMAP2+: PM: Initialise sleep_switch to a non-valid value
Date: Tue,  5 Apr 2011 18:14:56 +0530
Message-ID: <1302007497-10525-4-git-send-email-rnayak@ti.com>
References: <1302007497-10525-1-git-send-email-rnayak@ti.com>
 <1302007497-10525-2-git-send-email-rnayak@ti.com>
 <1302007497-10525-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46299 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab1DEMpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 08:45:19 -0400
In-Reply-To: <1302007497-10525-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

sleep_switch which is initialised to 0 in omap_set_pwrdm_state
happens to be a valid sleep_switch type (FORCEWAKEUP_SWITCH)
which are defined as
#define FORCEWAKEUP_SWITCH      0
#define LOWPOWERSTATE_SWITCH    1

This causes the function to wrongly program some clock domains
even when the Powerdomain is in ON state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 30af335..04b6da7 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -105,7 +105,7 @@ static void omap2_init_processor_devices(void)
 int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
-	int sleep_switch = 0;
+	int sleep_switch = -1;
 	int ret = 0;
 
 	if (pwrdm == NULL || IS_ERR(pwrdm))
-- 
1.7.0.4

