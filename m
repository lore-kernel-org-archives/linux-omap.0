From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAPFB: remove warning when trying to alloc at certain paddress
Date: Fri, 7 Dec 2012 13:55:07 +0200
Message-ID: <1354881309-17625-3-git-send-email-tomi.valkeinen@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43536 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668Ab2LGLz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Dec 2012 06:55:29 -0500
In-Reply-To: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb gives a WARN_ONCE if a predefined physical address is given for
allocating the framebuffer memory, as this is not currently supported.

However, the same warning happens if omapfb fails to allocate memory
during runtime, as when the allocation has failed, omapfb tries to
re-allocate the old memory with the physical address of the old memory
area.

Remove the warning from omapfb_alloc_fbmem, as it serves no purpose on
the failure case above, and move it to omapfb_parse_vram_param, so that
we only warn if physical address is given via omapfb module parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 28b2a21..1df973e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1391,9 +1391,6 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 
 	size = PAGE_ALIGN(size);
 
-	WARN_ONCE(paddr,
-		"reserving memory at predefined address not supported\n");
-
 	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
 
 	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
@@ -1521,6 +1518,9 @@ static int omapfb_parse_vram_param(const char *param, int max_entries,
 
 		}
 
+		WARN_ONCE(paddr,
+			"reserving memory at predefined address not supported\n");
+
 		paddrs[fbnum] = paddr;
 		sizes[fbnum] = size;
 
-- 
1.7.10.4

