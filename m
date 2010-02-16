From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 12/24] omap4: clocks: Make dmtimer clocks calls OMAP4 compatible
Date: Tue, 16 Feb 2010 21:28:03 +0530
Message-ID: <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52043 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019Ab0BPP6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:58:36 -0500
In-Reply-To: <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The gptimer library has been adapted for the OMAP4 way of clock calls.
In OMAP4, the iclk are hw controlled and no sw control is available.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 24bf692..e4bfeed 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -428,7 +428,9 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	if (cpu_class_is_omap2()) {
 		clk_enable(timer->fclk);
-		clk_enable(timer->iclk);
+		/* OMAP4 iclk are hw controlled and no sw control available */
+		if (!cpu_is_omap44xx())
+			clk_enable(timer->iclk);
 	}
 #endif
 
@@ -443,7 +445,9 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	if (cpu_class_is_omap2()) {
-		clk_disable(timer->iclk);
+		/* OMAP4 iclk are hw controlled and no sw control available */
+		if (!cpu_is_omap44xx())
+			clk_disable(timer->iclk);
 		clk_disable(timer->fclk);
 	}
 #endif
@@ -781,10 +785,19 @@ int __init omap_dm_timer_init(void)
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];
-			sprintf(clk_name, "gpt%d_ick", i + 1);
-			timer->iclk = clk_get(NULL, clk_name);
-			sprintf(clk_name, "gpt%d_fck", i + 1);
-			timer->fclk = clk_get(NULL, clk_name);
+			/*
+			 * OMAP4 iclks are hw controlled and no sw control
+			 * is available
+			 */
+			if (cpu_is_omap44xx()) {
+				sprintf(clk_name, "gptimer%d_ck", i + 1);
+				timer->fclk = clk_get(NULL, clk_name);
+			} else {
+				sprintf(clk_name, "gpt%d_ick", i + 1);
+				timer->iclk = clk_get(NULL, clk_name);
+				sprintf(clk_name, "gpt%d_fck", i + 1);
+				timer->fclk = clk_get(NULL, clk_name);
+			}
 		}
 #endif
 	}
-- 
1.6.0.4

