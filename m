From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/28] omap: DMA: Init CDAC to zero
Date: Fri, 23 Apr 2010 16:11:12 -0700
Message-ID: <20100423231112.31953.32544.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61367 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab0DWXLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:13 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Govindraj R <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Manjunatha GK <manjugk@ti.com>

From: manjugk manjugk <manjugk@ti.com>

The register DMA4_CDAC needs to be initialized to zero
before starting DMA transfer.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Reported-by:S, Venkatraman <svenkatr@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..f6c9bdc 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -936,6 +936,15 @@ void omap_start_dma(int lch)
 {
 	u32 l;
 
+	/*
+	 * The CPC/CDAC register needs to be initialized to zero
+	 * before starting dma transfer.
+	 */
+	if (cpu_is_omap15xx())
+		dma_write(0, CPC(lch));
+	else
+		dma_write(0, CDAC(lch));
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];

