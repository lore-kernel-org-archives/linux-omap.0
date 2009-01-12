From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] ARM: OMAP: Fix DMA CCR programming for request line > 63
Date: Mon, 12 Jan 2009 16:44:53 +0200
Message-ID: <20090112144453.24205.18451.stgit@localhost>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63877 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbZALOo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:44:57 -0500
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

Bug in existing code causes synchro control to be set +32 if request
line greater than 63 is used.

Reported by Wenbiao Wang

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 692d2b4..6152586 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -279,10 +279,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 
 		val = dma_read(CCR(lch));
 		val &= ~(3 << 19);
-		if (dma_trigger > 63)
-			val |= 1 << 20;
-		if (dma_trigger > 31)
-			val |= 1 << 19;
+		val |= ((dma_trigger & ~(0x1f)) << 14);
 
 		val &= ~(0x1f);
 		val |= (dma_trigger & 0x1f);

