From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/13] staging: ti dspbridge: deh: ensure only tlb #0 is enabled
Date: Sun,  4 Jul 2010 16:34:32 +0300
Message-ID: <1278250479-16982-7-git-send-email-felipe.contreras@gmail.com>
References: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757698Ab0GDNez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:34:55 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295322bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:34:54 -0700 (PDT)
In-Reply-To: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

We don't want the DSP to continue writing into other mapped pages, no
matter how unlikely.

Based on extensive discussion with Fernando Guzman Lugo.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/ue_deh.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index 06167ed..793e982 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -186,6 +186,14 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
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

