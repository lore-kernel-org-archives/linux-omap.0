From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] omap: dsp: remove shm from normal memory
Date: Sun,  7 Nov 2010 23:43:25 +0200
Message-ID: <1289166209-32251-2-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab0KGVoT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 16:44:19 -0500
Received: by mail-fx0-f46.google.com with SMTP id 16so3600214fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 13:44:18 -0800 (PST)
In-Reply-To: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Also, don't be picky about the location, which incidentally fixes the
build since MEMBLOCK_REAL_LIMIT is gone on 2.6.37.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/devices.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 6f42a18..fc81912 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -284,12 +284,14 @@ void __init omap_dsp_reserve_sdram_memblock(void)
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
1.7.3.2.3.gf8529

