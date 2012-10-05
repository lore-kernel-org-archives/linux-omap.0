From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 14/15] mtd: nand: omap: gpmc header removal
Date: Fri, 5 Oct 2012 21:24:50 +0530
Message-ID: <483b3586b25cfe4069e9a1953733a94814b3db7b.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41250 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461Ab2JEPzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 11:55:06 -0400
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

nand driver no longer needs gpmc header, remove it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index e3fc8d7..d6664d7 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -28,7 +28,6 @@
 #endif
 
 #include <plat/dma.h>
-#include <plat/gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #define	DRIVER_NAME	"omap2-nand"
-- 
1.7.12

