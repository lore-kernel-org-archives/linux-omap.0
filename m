From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: boot message is not an error
Date: Tue, 17 May 2011 20:32:45 +0530
Message-ID: <1305644565-26233-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51185 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961Ab1EQPCx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 11:02:53 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4HF2oNN008441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 10:02:52 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p4HF2njt028060
	for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 20:32:49 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

With current level, it shows up on the console
despite using 'silent' in bootargs.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---

 1) Couldn't find better text on commit message.
    Any suggestions?

 2) Though pm34xx.x is changed, the change itself
    is no related to power management. Hence, did
    annotate "pm:"

 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 343027f..7584ba8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -901,7 +901,7 @@ static int __init omap3_pm_init(void)
 
 	pm_errata_configure();
 
-	printk(KERN_ERR "Power Management for TI OMAP3.\n");
+	pr_info ("Power Management for TI OMAP3.\n");
 
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
-- 
1.7.2.2

