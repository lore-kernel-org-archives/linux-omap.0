From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/14] dspbridge: deh: ensure only tlb #0 is enabled
Date: Sun, 16 May 2010 18:45:58 +0300
Message-ID: <1274024765-21076-8-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51910 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab0EPPqX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:23 -0400
Received: by fxm6 with SMTP id 6so2977823fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:22 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

We don't want the DSP to continue writing into other mapped pages, no
matter how unlikely.

Based on extensive discussion with Fernando Guzman Lugo.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/ue_deh.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 61e5e4e..f661aaf 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -235,6 +235,14 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		print_dsp_trace_buffer(dev_context);
 		dump_dl_modules(dev_context);
 
+		/*
+		 * Before acking the MMU fault, let's make sure MMU can only
+		 * access entry #0. Then add a new entry so that the DSP OS
+		 * can continue in order to dump the stack.
+		 */
+		hw_mmu_twl_disable(resources->dw_dmmu_base);
+		hw_mmu_tlb_flush_all(resources->dw_dmmu_base);
+
 		hw_mmu_tlb_add(resources->dw_dmmu_base,
 				virt_to_phys(dummy_va_addr), fault_addr,
 				HW_PAGE_SIZE4KB, 1,
-- 
1.7.1

