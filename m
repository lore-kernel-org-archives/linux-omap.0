From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 08/11] OMAP: NAND: Fix static declaration warning
Date: Fri, 27 Aug 2010 02:26:46 +0530
Message-ID: <1282856209-15645-9-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41788 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab0HZU6Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 16:58:16 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

This patch fixes sparse warning for static declaration of variable "use_dma"

drivers/mtd/nand/omap2.c:114:11: warning: symbol 'use_dma' was not declared. Should it be static?

Signed-off-by: Manjunatha GK <manjugk@ti.com>
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

