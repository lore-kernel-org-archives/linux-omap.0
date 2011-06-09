From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 5/8] OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
Date: Thu, 9 Jun 2011 16:24:10 +0530
Message-ID: <1307616853-28395-6-git-send-email-rnayak@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
 <1307616853-28395-2-git-send-email-rnayak@ti.com>
 <1307616853-28395-3-git-send-email-rnayak@ti.com>
 <1307616853-28395-4-git-send-email-rnayak@ti.com>
 <1307616853-28395-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49946 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757209Ab1FIKyb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 06:54:31 -0400
In-Reply-To: <1307616853-28395-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

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
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index a607ec1..ff38764 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -493,7 +493,7 @@ static struct clockdomain l3_init_44xx_clkdm = {
 	.dep_bit	  = OMAP4430_L3INIT_STATDEP_SHIFT,
 	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-- 
1.7.0.4

