From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 06/10] OMAP: NAND: Fix static declaration warning
Date: Tue, 21 Sep 2010 15:31:16 +0530
Message-ID: <1285063280-4057-7-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47482 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab0IUKCG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 06:02:06 -0400
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
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

