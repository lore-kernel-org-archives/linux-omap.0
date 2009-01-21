From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Subject: [PATCH] ARM OMAP: Fix race in OMAP2/3 DMA IRQ handling
Date: Wed, 21 Jan 2009 19:24:09 +0200
Message-ID: <20090121172409.GA23967@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:57658 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbZAURva (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jan 2009 12:51:30 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

CSR must be cleared before invoking the callback.

If the callback function starts a new, fast DMA transfer on the same
channel, the completion status might lost if CSR is cleared after
the callback invocation.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
---
 arch/arm/plat-omap/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 8e6475d..265351b 100755
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1898,11 +1898,11 @@ static int omap2_dma_handle_ch(int ch)
 		status = dma_read(CSR(ch));
 	}
 
+	dma_write(status, CSR(ch));
+
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
 
-	dma_write(status, CSR(ch));
-
 	return 0;
 }
 
-- 
1.5.6.5

