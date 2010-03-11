From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH 1/4] AM35xx EMAC : define submodule offsets.
Date: Thu, 11 Mar 2010 20:43:39 +0530
Message-ID: <1268320422-32656-2-git-send-email-srk@ti.com>
References: <1268320422-32656-1-git-send-email-srk@ti.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1268320422-32656-1-git-send-email-srk@ti.com>
Sender: netdev-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: netdev@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, Sriramakrishnan <srk@ti.com>
List-Id: linux-omap@vger.kernel.org

Define offsets for EMAC sub modules.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/mach-omap2/include/mach/am35xx.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/include/mach/am35xx.h
index a705f94..472867e 100644
--- a/arch/arm/mach-omap2/include/mach/am35xx.h
+++ b/arch/arm/mach-omap2/include/mach/am35xx.h
@@ -23,4 +23,13 @@
 #define AM35XX_IPSS_HECC_BASE		0x5C050000
 #define AM35XX_IPSS_VPFE_BASE		0x5C060000
 
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
-- 
1.6.2.4

