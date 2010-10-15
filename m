From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] video: omap: vram: remove from normal memory
Date: Fri, 15 Oct 2010 15:46:23 +0300
Message-ID: <1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61800 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab0JONPr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 09:15:47 -0400
Received: by bwz15 with SMTP id 15so894197bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Oct 2010 06:15:45 -0700 (PDT)
In-Reply-To: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, mike@compulab.co.il, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

So that we can ioremap happily.

Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/video/omap2/vram.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index f6fdc20..1a99777 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -575,6 +575,8 @@ void __init omap_vram_reserve_sdram_memblock(void)
 		}
 	} else {
 		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
+		memblock_free(paddr, size);
+		memblock_remove(paddr, size);
 	}
 
 	omap_vram_add_region(paddr, size);
-- 
1.7.3.1.2.g7fe2b

