From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/18] AM35xx EMAC : define submodule offsets
Date: Wed, 05 May 2010 12:33:04 -0700
Message-ID: <20100505193304.21568.48003.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49728 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab0EETdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:33:04 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sriramakrishnan <srk@ti.com>, linux-omap@vger.kernel.org

From: Sriram <srk@ti.com>

Define offsets for EMAC sub modules.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/am35xx.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/include/mach/am35xx.h
index 0636263..f1e13d1 100644
--- a/arch/arm/mach-omap2/include/mach/am35xx.h
+++ b/arch/arm/mach-omap2/include/mach/am35xx.h
@@ -32,4 +32,13 @@
 #define AM35XX_HECC_INT_LINE		(0x0)
 #define AM35XX_HECC_VERSION		(0x1)
 
-#endif /*  __ASM_ARCH_AM35XX_H */
+#define AM35XX_EMAC_CNTRL_OFFSET	(0x10000)
+#define AM35XX_EMAC_CNTRL_MOD_OFFSET	(0x0)
+#define AM35XX_EMAC_CNTRL_RAM_OFFSET	(0x20000)
+#define AM35XX_EMAC_MDIO_OFFSET		(0x30000)
+#define AM35XX_EMAC_CNTRL_RAM_SIZE	(0x2000)
+#define AM35XX_EMAC_RAM_ADDR		(AM3517_EMAC_BASE + \
+						AM3517_EMAC_CNTRL_RAM_OFFSET)
+#define AM35XX_EMAC_HW_RAM_ADDR		(0x01E20000)
+
+#endif  /*  __ASM_ARCH_AM35XX_H */

