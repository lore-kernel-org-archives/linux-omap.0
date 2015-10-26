From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: fix incorrect INT_DMA_LCD
Date: Mon, 26 Oct 2015 20:41:43 +0200
Message-ID: <1445884903-12224-1-git-send-email-aaro.koskinen@iki.fi>
References: <20151020144707.GA3078@atomide.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20151020144707.GA3078@atomide.com>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit 685e2d08c54b ("ARM: OMAP1: Change interrupt numbering for
sparse IRQ") turned on SPARSE_IRQ on OMAP1, but forgot to change
the number of INT_DMA_LCD. This broke the boot at least on Nokia 770,
where the device hangs during framebuffer initialization.

Fix by defining INT_DMA_LCD like the other interrupts.

Cc: stable@vger.kernel.org
Fixes: 685e2d08c54b ("ARM: OMAP1: Change interrupt numbering for sparse IRQ")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/linux/omap-dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index e5a7013..88fa8af 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -17,7 +17,7 @@
 
 #include <linux/platform_device.h>
 
-#define INT_DMA_LCD			25
+#define INT_DMA_LCD			(NR_IRQS_LEGACY + 25)
 
 #define OMAP1_DMA_TOUT_IRQ		(1 << 0)
 #define OMAP_DMA_DROP_IRQ		(1 << 1)
-- 
2.4.0
