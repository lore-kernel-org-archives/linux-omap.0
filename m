From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] OMAP: Fix build failure on MEMBLOCK_REAL_LIMIT
Date: Tue,  2 Nov 2010 01:30:08 +0900
Message-ID: <1288629008-29767-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53332 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0KAQaU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Nov 2010 12:30:20 -0400
Received: by vws13 with SMTP id 13so3805839vws.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Nov 2010 09:30:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

The MEMBLOCK_REAL_LIMIT symbol was removed by the commit e63075a3c937
(memblock: Introduce default allocation limit and use it to replace
explicit ones) so it breaks beagle board build as follows:

  CC      drivers/video/omap2/vram.o
drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_memblock':
drivers/video/omap2/vram.c:573: error: 'MEMBLOCK_REAL_LIMIT' undeclared (first use in this function)
drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is reported only once
drivers/video/omap2/vram.c:573: error: for each function it appears in.)
make[5]: *** [drivers/video/omap2/vram.o] Error 1
make[4]: *** [drivers/video/omap2] Error 2
make[3]: *** [drivers/video] Error 2
make[2]: *** [drivers] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 drivers/video/omap2/vram.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index fed2a72..39b85f7 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -570,7 +570,8 @@ void __init omap_vram_reserve_sdram_memblock(void)
 			return;
 		}
 	} else {
-		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
+		paddr = memblock_alloc_base(size, PAGE_SIZE,
+					    MEMBLOCK_ALLOC_ACCESSIBLE);
 	}
 
 	omap_vram_add_region(paddr, size);
-- 
1.7.0.4

