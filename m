From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3] OMAP: NAND: Fix static declaration warning
Date: Wed,  6 Oct 2010 03:26:56 +0530
Message-ID: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42183 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab0JEV42 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 17:56:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

This patch fixes sparse warning for static declaration of variable "use_dma"

drivers/mtd/nand/omap2.c:114:11: warning: symbol 'use_dma' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mtd@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
Changes since v1:
 - no logical changes, patch seperated from series based Tony's suggestion.

 drivers/mtd/nand/omap2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 133d515..439e80d 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -111,11 +111,11 @@ static int use_dma = 1;
 module_param(use_dma, bool, 0);
 MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
 #else
-const int use_dma;
+static const int use_dma;
 #endif
 #else
 const int use_prefetch;
-const int use_dma;
+static const int use_dma;
 #endif
 
 struct omap_nand_info {
-- 
1.7.0.4

