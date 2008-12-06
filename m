From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP2: PM: fix fault in enter_full_retention()
Date: Fri,  5 Dec 2008 23:55:10 -0800
Message-ID: <1228550110-6675-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:10282 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYLFHzP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Dec 2008 02:55:15 -0500
Received: by yx-out-2324.google.com with SMTP id 8so181714yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Dec 2008 23:55:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

In omap24xx_cpu_suspend assembly routine, the r2 register which holds
the address of the SDRC_POWER reg is set to zero before the value is
written back triggering a fault due to writing to address zero.

It's hard to tell where this change was introduced since this file
has been moved and merged.

While this fix prevents a crash, suspend on my n810 is broken with
current kernels.  I never come out of suspend.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sleep24xx.S |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
index 43336b9..bf9e961 100644
--- a/arch/arm/mach-omap2/sleep24xx.S
+++ b/arch/arm/mach-omap2/sleep24xx.S
@@ -93,9 +93,8 @@ ENTRY(omap24xx_cpu_suspend)
 	orr	r4, r4, #0x40		@ enable self refresh on idle req
 	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
 	str	r4, [r2]		@ make it so
-	mov	r2, #0
 	nop
-	mcr	p15, 0, r2, c7, c0, 4	@ wait for interrupt
+	mcr	p15, 0, r3, c7, c0, 4	@ wait for interrupt
 	nop
 loop:
 	subs	r5, r5, #0x1		@ awake, wait just a bit
-- 
1.6.0.3

