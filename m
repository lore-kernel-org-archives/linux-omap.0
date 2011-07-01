From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v4 3/7] OMAP2+: PM: Initialise sleep_switch to a non-valid value
Date: Fri, 1 Jul 2011 23:27:02 +0200
Message-ID: <1309555626-22608-4-git-send-email-b-cousson@ti.com>
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59737 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab1GAV1T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:27:19 -0400
In-Reply-To: <1309555626-22608-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

sleep_switch which is initialised to 0 in omap_set_pwrdm_state
happens to be a valid sleep_switch type (FORCEWAKEUP_SWITCH)
which are defined as:

 #define FORCEWAKEUP_SWITCH      0
 #define LOWPOWERSTATE_SWITCH    1

This causes the function to wrongly program some clock domains
even when the Powerdomain is in ON state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 49486f5..d48813f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -106,7 +106,7 @@ static void omap2_init_processor_devices(void)
 int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
-	int sleep_switch = 0;
+	int sleep_switch = -1;
 	int ret = 0;
 
 	if (pwrdm == NULL || IS_ERR(pwrdm))
-- 
1.7.0.4

