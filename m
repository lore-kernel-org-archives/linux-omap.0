From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: UART: fix wakeup registers for OMAP24xx UART2
Date: Wed, 20 Oct 2010 16:19:03 -0700
Message-ID: <1287616743-23434-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64915 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab0JTXTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 19:19:07 -0400
Received: by gxk21 with SMTP id 21so1997817gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Oct 2010 16:19:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, govindraj.raja@ti.com

On OMAP24xx, UART2 WKEN and WKST registers are in PM_WKEN2_CORE and
PM_WKST2_CORE respecitvely.  Fix the OMAP2 register init to use the
correct registers on OMAP24xx.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Tony, this should probably squeeze in for 2.6.37 as well.

 arch/arm/mach-omap2/serial.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ba8a5cc..becf0e3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -515,14 +515,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = padconf;
 	} else if (cpu_is_omap24xx()) {
 		u32 wk_mask = 0;
+		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
 
-		if (cpu_is_omap2430()) {
-			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKEN1);
-			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKST1);
-		} else if (cpu_is_omap2420()) {
-			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1);
-			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1);
-		}
 		switch (uart->num) {
 		case 0:
 			wk_mask = OMAP24XX_ST_UART1_MASK;
@@ -531,10 +525,19 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 			wk_mask = OMAP24XX_ST_UART2_MASK;
 			break;
 		case 2:
+			wk_en = OMAP24XX_PM_WKEN2;
+			wk_st = OMAP24XX_PM_WKST2;
 			wk_mask = OMAP24XX_ST_UART3_MASK;
 			break;
 		}
 		uart->wk_mask = wk_mask;
+		if (cpu_is_omap2430()) {
+			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, wk_en);
+			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, wk_st);
+		} else if (cpu_is_omap2420()) {
+			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, wk_en);
+			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, wk_st);
+		}
 	} else {
 		uart->wk_en = NULL;
 		uart->wk_st = NULL;
-- 
1.7.2.1

