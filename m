From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 1/8] ARM: OMAP2+: Remove AES crypto device DMA channel definitions
Date: Sat, 15 Jun 2013 11:31:02 +0300
Message-ID: <1371285069-6834-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33788 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab3FOIbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:41 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

These became unused after commit 660ffd6
("ARM: OMAP2xxx: hwmod: Convert AES crypto devcie data to hwmod").

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/dma.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.h b/arch/arm/mach-omap2/dma.h
index 65f80ca..4141ef0 100644
--- a/arch/arm/mach-omap2/dma.h
+++ b/arch/arm/mach-omap2/dma.h
@@ -25,8 +25,6 @@
 #define OMAP24XX_DMA_EXT_DMAREQ0	2	/* S_DMA_1 */
 #define OMAP24XX_DMA_EXT_DMAREQ1	3	/* S_DMA_2 */
 #define OMAP24XX_DMA_GPMC		4	/* S_DMA_3 */
-#define OMAP24XX_DMA_AES_TX		9	/* S_DMA_8 */
-#define OMAP24XX_DMA_AES_RX		10	/* S_DMA_9 */
 #define OMAP242X_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
 #define OMAP242X_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
 #define OMAP242X_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
-- 
1.7.10.4

