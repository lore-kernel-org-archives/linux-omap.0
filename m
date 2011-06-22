From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 19/25] ARM: pm: sa1100: no need to re-enable clock switching
Date: Wed, 22 Jun 2011 16:14:57 +0100
Message-ID: <E1QZP8r-0002Wz-7p@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57677 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab1FVP3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 11:29:16 -0400
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

This is now taken care of by calling cpu_proc_init() in the resume
path, so eliminate this unnecessary call.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/pm.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index d49eaf2..259ed3b 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -77,9 +77,6 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	/* go zzz */
 	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, sa1100_finish_suspend);
 
-	/* Re-enable clock switching */
-	asm volatile("mcr p15, 0, %0, c15, c1, 2" : : "r" (0));
-
 	/*
 	 * Ensure not to come back here if it wasn't intended
 	 */
-- 
1.7.4.4

