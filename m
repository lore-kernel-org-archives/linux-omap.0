From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 2/3] OMAP: VRAM: Fix boot-time memory allocation
Date: Wed, 10 Nov 2010 11:45:19 +0200
Message-ID: <1289382320-17412-2-git-send-email-tomi.valkeinen@nokia.com>
References: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:30916 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab0KJJnq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 04:43:46 -0500
In-Reply-To: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Use memblock_free() and memblock_remove() to remove the allocated or
reserved VRAM area from normal kernel memory.

This is a slightly modified version of patches from Felipe Contreras and
Namhyung Kim.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Reported-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/vram.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index bb5ee06..2fd7e52 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -576,9 +576,12 @@ void __init omap_vram_reserve_sdram_memblock(void)
 			return;
 		}
 	} else {
-		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
+		paddr = memblock_alloc(size, PAGE_SIZE);
 	}
 
+	memblock_free(paddr, size);
+	memblock_remove(paddr, size);
+
 	omap_vram_add_region(paddr, size);
 
 	pr_info("Reserving %u bytes SDRAM for VRAM\n", size);
-- 
1.7.1

