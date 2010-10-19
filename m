From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] omap: dsp: remove shm from normal memory
Date: Tue, 19 Oct 2010 10:37:24 +0300
Message-ID: <1287473844-6228-2-git-send-email-felipe.contreras@gmail.com>
References: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58656 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871Ab0JSHhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 03:37:43 -0400
Received: by mail-bw0-f46.google.com with SMTP id 10so56549bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 00:37:42 -0700 (PDT)
In-Reply-To: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Also, don't be picky about the location.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/devices.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 4c8f9b9..da10433 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -285,12 +285,14 @@ void __init omap_dsp_reserve_sdram_memblock(void)
 	if (!size)
 		return;
 
-	paddr = __memblock_alloc_base(size, SZ_1M, MEMBLOCK_REAL_LIMIT);
+	paddr = memblock_alloc(size, SZ_1M);
 	if (!paddr) {
 		pr_err("%s: failed to reserve %x bytes\n",
 				__func__, size);
 		return;
 	}
+	memblock_free(paddr, size);
+	memblock_remove(paddr, size);
 
 	omap_dsp_phys_mempool_base = paddr;
 }
-- 
1.7.3.1.2.g7fe2b

