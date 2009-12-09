From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] smc91x: remove OMAP specific bits
Date: Tue, 08 Dec 2009 16:50:11 -0800
Message-ID: <20091209005011.5944.98244.stgit@localhost>
References: <20091209004630.5944.40334.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52336 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967016AbZLIAuO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:50:14 -0500
In-Reply-To: <20091209004630.5944.40334.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-net@vger.kernel.org, linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

Now that all OMAP boards are using the board resources, we don't need
to keep the arch/board specific crap in the driver header.

Cc: linux-net@vger.kernel.org
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/smc91x.h |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index 7815bfc..5479954 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -206,21 +206,6 @@ SMC_outw(u16 val, void __iomem *ioaddr, int reg)
 	}
 }
 
-#elif	defined(CONFIG_ARCH_OMAP)
-
-/* We can only do 16-bit reads and writes in the static memory space. */
-#define SMC_CAN_USE_8BIT	0
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	0
-#define SMC_IO_SHIFT		0
-#define SMC_NOWAIT		1
-
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_insw(a, r, p, l)	readsw((a) + (r), p, l)
-#define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)
-#define	SMC_IRQ_FLAGS		(-1)	/* from resource */
-
 #elif	defined(CONFIG_SH_SH4202_MICRODEV)
 
 #define SMC_CAN_USE_8BIT	0

