From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/9] ARM: OMAP: Fix race in OMAP2/3 DMA IRQ handling
Date: Wed, 28 Jan 2009 10:25:40 -0800
Message-ID: <20090128182540.21007.97833.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56188 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbZA1SZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:25:44 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org

From: Juha Yrjola <juha.yrjola@solidboot.com>

CSR must be cleared before invoking the callback.

If the callback function starts a new, fast DMA transfer on the same
channel, the completion status might lost if CSR is cleared after
the callback invocation.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index e77373c..bec8e36 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1888,11 +1888,11 @@ static int omap2_dma_handle_ch(int ch)
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
 

