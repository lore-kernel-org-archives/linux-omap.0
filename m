From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/28] arm: omap1: remove dead code from timer32k.c
Date: Fri, 23 Apr 2010 16:11:05 -0700
Message-ID: <20100423231105.31953.57929.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56512 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab0DWXLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:05 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

Trivial patch, no functional changes

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/timer32k.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 9ad1185..20cfbcc 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -68,12 +68,6 @@ struct sys_timer omap_timer;
  * ---------------------------------------------------------------------------
  */
 
-#if defined(CONFIG_ARCH_OMAP16XX)
-#define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#else
-#error OMAP 32KHz timer does not currently work on 15XX!
-#endif
-
 /* 16xx specific defines */
 #define OMAP1_32K_TIMER_BASE		0xfffb9000
 #define OMAP1_32K_TIMER_CR		0x08
@@ -150,15 +144,6 @@ static struct clock_event_device clockevent_32k_timer = {
 	.set_mode	= omap_32k_timer_set_mode,
 };
 
-/*
- * The 32KHz synchronized timer is an additional timer on 16xx.
- * It is always running.
- */
-static inline unsigned long omap_32k_sync_timer_read(void)
-{
-	return omap_readl(TIMER_32K_SYNCHRONIZED);
-}
-
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_32k_timer;

