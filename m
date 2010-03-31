From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 1/2] arm: omap1: remove dead code from timer32k.c
Date: Wed, 31 Mar 2010 14:05:48 +0300
Message-ID: <1270033549-26408-2-git-send-email-felipe.balbi@nokia.com>
References: <1270033549-26408-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44930 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab0CaLGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 07:06:36 -0400
In-Reply-To: <1270033549-26408-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Trivial patch, no functional changes

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
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
-- 
1.7.0.rc0.33.g7c3932

