From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ARM: OMAP: dma: Mark expected switch fall-throughs
Date: Sun, 28 Jul 2019 18:22:40 -0500
Message-ID: <20190728232240.GA22393@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>
List-Id: linux-omap@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

arch/arm/plat-omap/dma.c: In function 'omap_set_dma_src_burst_mode':
arch/arm/plat-omap/dma.c:384:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (dma_omap2plus()) {
      ^
arch/arm/plat-omap/dma.c:393:2: note: here
  case OMAP_DMA_DATA_BURST_16:
  ^~~~
arch/arm/plat-omap/dma.c:394:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (dma_omap2plus()) {
      ^
arch/arm/plat-omap/dma.c:402:2: note: here
  default:
  ^~~~~~~
arch/arm/plat-omap/dma.c: In function 'omap_set_dma_dest_burst_mode':
arch/arm/plat-omap/dma.c:473:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (dma_omap2plus()) {
      ^
arch/arm/plat-omap/dma.c:481:2: note: here
  default:
  ^~~~~~~

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/plat-omap/dma.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 79f43acf9acb..08c99413d02c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -388,17 +388,15 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 		/*
 		 * not supported by current hardware on OMAP1
 		 * w |= (0x03 << 7);
-		 * fall through
 		 */
+		/* fall through */
 	case OMAP_DMA_DATA_BURST_16:
 		if (dma_omap2plus()) {
 			burst = 0x3;
 			break;
 		}
-		/*
-		 * OMAP1 don't support burst 16
-		 * fall through
-		 */
+		/* OMAP1 don't support burst 16 */
+		/* fall through */
 	default:
 		BUG();
 	}
@@ -474,10 +472,8 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 			burst = 0x3;
 			break;
 		}
-		/*
-		 * OMAP1 don't support burst 16
-		 * fall through
-		 */
+		/* OMAP1 don't support burst 16 */
+		/* fall through */
 	default:
 		printk(KERN_ERR "Invalid DMA burst mode\n");
 		BUG();
-- 
2.22.0
