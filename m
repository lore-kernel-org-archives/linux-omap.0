From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH] OMAP: clockdomain: Remove redundant call to pwrdm_wait_transition()
Date: Thu, 26 May 2011 16:08:10 +0530
Message-ID: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57378 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584Ab1EZKie (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 06:38:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

The call to pwrdm_wait_transition() in clkdm_clk_enable()
is redundant since the function pwrdm_clkdm_state_switch()
which is called next also does the same thing.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6cb6c03..4fbbbfc 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -834,7 +834,6 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 		 clk->name);
 
 	arch_clkdm->clkdm_clk_enable(clkdm);
-	pwrdm_wait_transition(clkdm->pwrdm.ptr);
 	pwrdm_clkdm_state_switch(clkdm);
 
 	return 0;
-- 
1.6.2.4

