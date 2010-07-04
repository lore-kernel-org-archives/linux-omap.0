From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/13] staging: ti dspbridge: deh: free dummy page immediately
Date: Sun,  4 Jul 2010 16:34:29 +0300
Message-ID: <1278250479-16982-4-git-send-email-felipe.contreras@gmail.com>
References: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757698Ab0GDNeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:34:50 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295322bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:34:49 -0700 (PDT)
In-Reply-To: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

There's no need to keep it around. DSP should stop trying to access
system memory.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/ue_deh.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index ee2d23a..50868a4 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -52,8 +52,6 @@
 #include <dspbridge/io_sm.h>
 
 
-static void *dummy_va_addr;
-
 int bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj)
 {
@@ -154,6 +152,7 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		.element_size = HW_ELEM_SIZE16BIT,
 		.mixed_size = HW_MMU_CPUES,
 	};
+	void *dummy_va_addr;
 
 	if (!deh_mgr)
 		return;
@@ -214,6 +213,9 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 				HW_MMU_TRANSLATION_FAULT);
 		dump_dsp_stack(dev_context);
 		dsp_clk_disable(DSP_CLK_GPT8);
+
+		hw_mmu_disable(resources->dw_dmmu_base);
+		free_page((unsigned long)dummy_va_addr);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
@@ -276,6 +278,4 @@ int bridge_deh_get_info(struct deh_mgr *deh_mgr,
 
 void bridge_deh_release_dummy_mem(void)
 {
-	free_page((unsigned long)dummy_va_addr);
-	dummy_va_addr = NULL;
 }
-- 
1.7.1

