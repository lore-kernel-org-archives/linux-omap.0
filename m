From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 23/28] OMAP: PM: Clear DMA channel state after a wakeup
Date: Thu,  1 Oct 2009 16:58:53 -0700
Message-ID: <1254441538-9257-24-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-17-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-18-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-19-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-20-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-21-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-22-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-23-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58920 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbZJAX7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:35 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so574597pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:39 -0700 (PDT)
In-Reply-To: <1254441538-9257-23-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Clear DMA channel states so that users can assume a known initial state.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/plat-omap/dma.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index b3e1f77..f24d989 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2358,6 +2358,8 @@ EXPORT_SYMBOL(omap_dma_global_context_save);
 
 void omap_dma_global_context_restore(void)
 {
+	int ch;
+
 	dma_write(omap_dma_global_context.dma_gcr, GCR);
 	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
 		OCP_SYSCONFIG);
@@ -2372,6 +2374,10 @@ void omap_dma_global_context_restore(void)
 	 */
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
 		dma_write(0x3 , IRQSTATUS_L0);
+
+	for (ch = 0; ch < dma_chan_count; ch++)
+		if (dma_chan[ch].dev_id != -1)
+			omap_clear_dma(ch);
 }
 EXPORT_SYMBOL(omap_dma_global_context_restore);
 
-- 
1.6.4.3

