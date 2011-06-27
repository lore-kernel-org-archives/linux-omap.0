From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 5/8] OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
Date: Mon, 27 Jun 2011 18:11:40 +0200
Message-ID: <1309191103-8817-6-git-send-email-b-cousson@ti.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59786 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab1F0QM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 12:12:58 -0400
In-Reply-To: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, toddpoynor@google.com

From: Rajendra Nayak <rnayak@ti.com>

Since MMC driver is yet to be adapted to
runtime PM and still uses direct clock
calls to enable/disable module, its needed
that the clockdomain (for MMC) is always kept force
enabled since the next few patches move
the clockdomain handling from clock framework
to hwmod framework and break MMC.

This will certainlly gate any CORE low power
transitions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 66090f2..863006a 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -494,7 +494,7 @@ static struct clockdomain l3_init_44xx_clkdm = {
 	.dep_bit	  = OMAP4430_L3INIT_STATDEP_SHIFT,
 	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-- 
1.7.0.4

