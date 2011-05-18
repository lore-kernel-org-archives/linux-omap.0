From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3: pm: Boot message is not an error, remove it
Date: Wed, 18 May 2011 14:44:40 +0530
Message-ID: <1305710080-2647-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57315 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755493Ab1ERJPE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 05:15:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>, jhnikula@gmail.com

It shows up on the console despite using "silent"
in the bootargs.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Cc: jhnikula@gmail.com
---

 v2: Changed the subject.
     Removed the print altogether

 v1: Convert printk to pr_info

 arch/arm/mach-omap2/pm34xx.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 343027f..ba6c524 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -901,8 +901,6 @@ static int __init omap3_pm_init(void)
 
 	pm_errata_configure();
 
-	printk(KERN_ERR "Power Management for TI OMAP3.\n");
-
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
-- 
1.7.2.2

