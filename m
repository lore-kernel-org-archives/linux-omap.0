From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] AM35xx: Add AM35xx specific control module registers
Date: Mon, 11 Jan 2010 17:46:23 -0700
Message-ID: <20100112004621.24684.38120.stgit@localhost.localdomain>
References: <20100112004326.24684.91321.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55131 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab0ALAra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:47:30 -0500
In-Reply-To: <20100112004326.24684.91321.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ranjith Lohithakshan <ranjithl@ti.com>

From: Ranjith Lohithakshan <ranjithl@ti.com>

AM3517/05 has a few additional control module registers defined mainly
to control the new IP's. This patch adds support for those new registers.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/control.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index a745d62..61e7b8a 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -160,6 +160,14 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
+/* AM35XX only CONTROL_GENERAL register offsets */
+#define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
+#define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
+#define AM35XX_CONTROL_DEVCONF3         (OMAP2_CONTROL_GENERAL + 0x0314)
+#define AM35XX_CONTROL_CBA_PRIORITY     (OMAP2_CONTROL_GENERAL + 0x0320)
+#define AM35XX_CONTROL_LVL_INTR_CLEAR   (OMAP2_CONTROL_GENERAL + 0x0324)
+#define AM35XX_CONTROL_IP_SW_RESET      (OMAP2_CONTROL_GENERAL + 0x0328)
+#define AM35XX_CONTROL_IPSS_CLK_CTRL    (OMAP2_CONTROL_GENERAL + 0x032C)
 
 /* 34xx PADCONF register offsets */
 #define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
@@ -257,6 +265,15 @@
 #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
 #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
 
+/* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
+#define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
+#define AM35XX_CPGMAC_VBUSP_CLK_SHIFT   1
+#define AM35XX_VPFE_VBUSP_CLK_SHIFT     2
+#define AM35XX_HECC_VBUSP_CLK_SHIFT     3
+#define AM35XX_USBOTG_FCLK_SHIFT        8
+#define AM35XX_CPGMAC_FCLK_SHIFT        9
+#define AM35XX_VPFE_FCLK_SHIFT          10
+
 /*
  * CONTROL OMAP STATUS register to identify OMAP3 features
  */


