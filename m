From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: OMAP2+: Disable omap3 PM init for ti81xx
Date: Tue, 13 Jan 2015 15:13:57 -0800
Message-ID: <1421190837-4692-8-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29340 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752646AbbAMXSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:18:03 -0500
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

We cannot use the omap3 pm support on 81xx.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b957776..e4a5630 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -568,7 +568,6 @@ void __init am35xx_init_late(void)
 void __init ti81xx_init_late(void)
 {
 	omap_common_late_init();
-	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
 #endif
-- 
2.1.4

