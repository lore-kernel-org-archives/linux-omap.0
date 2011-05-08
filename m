From: Rabin Vincent <rabin@rab.in>
Subject: [PATCH] OMAP: don't trace functions called from sched_clock
Date: Sun,  8 May 2011 14:51:54 +0530
Message-ID: <1304846514-15641-1-git-send-email-rabin@rab.in>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51458 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab1EHJVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 May 2011 05:21:31 -0400
Received: by pwi15 with SMTP id 15so1980958pwi.19
        for <linux-omap@vger.kernel.org>; Sun, 08 May 2011 02:21:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rabin Vincent <rabin@rab.in>

omap_readl() is used from the sched_clock() implementations and so must
be marked notrace to avoid recursion in ftrace.  Same thing with
mpu_read() for OMAP1.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/mach-omap1/io.c   |    2 +-
 arch/arm/mach-omap1/time.c |    2 +-
 arch/arm/mach-omap2/io.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 870886a..36ec2d7 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -158,7 +158,7 @@ u16 omap_readw(u32 pa)
 }
 EXPORT_SYMBOL(omap_readw);
 
-u32 omap_readl(u32 pa)
+u32 notrace omap_readl(u32 pa)
 {
 	return __raw_readl(OMAP1_IO_ADDRESS(pa));
 }
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 6885d2f..88c5c5e 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -203,7 +203,7 @@ static struct irqaction omap_mpu_timer2_irq = {
 	.handler	= omap_mpu_timer2_interrupt,
 };
 
-static cycle_t mpu_read(struct clocksource *cs)
+static cycle_t notrace mpu_read(struct clocksource *cs)
 {
 	return ~omap_mpu_timer_read(1);
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 441e79d..f1987b1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -441,7 +441,7 @@ u16 omap_readw(u32 pa)
 }
 EXPORT_SYMBOL(omap_readw);
 
-u32 omap_readl(u32 pa)
+u32 notrace omap_readl(u32 pa)
 {
 	return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
 }
-- 
1.7.4.1

