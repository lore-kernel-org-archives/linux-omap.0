From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/6] DSPBRIDGE: replace IO_ADDRESS with ioremap
Date: Mon, 11 Jan 2010 14:12:41 -0600
Message-ID: <1263240766-13000-2-git-send-email-omar.ramirez@ti.com>
References: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32994 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab0AKUDV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 15:03:21 -0500
In-Reply-To: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Use ioremap() instead of using IO_ADDRESS macro to make it generic.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/services/clk.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index d1c68fc..116e10e 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -54,10 +54,9 @@
 
 typedef volatile unsigned long  REG_UWORD32;
 
-#define SSI_Base        0x48058000
-
-#define SSI_BASE                     IO_ADDRESS(SSI_Base)
-
+#define OMAP_SSI_OFFSET			0x58000
+#define OMAP_SSI_SIZE			0x1000
+#define OMAP_SSI_SYSCONFIG_OFFSET	0x10
 
 struct SERVICES_Clk_t {
 	struct clk *clk_handle;
@@ -355,7 +354,9 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
 void SSI_Clk_Prepare(bool FLAG)
 {
 	u32 ssi_sysconfig;
-	ssi_sysconfig = __raw_readl((SSI_BASE) + 0x10);
+	void __iomem *ssi_base;
+
+	ssi_base = ioremap(L4_34XX_BASE + OMAP_SSI_OFFSET, OMAP_SSI_SIZE);
 
 	if (FLAG) {
 		/* Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
@@ -368,5 +369,7 @@ void SSI_Clk_Prepare(bool FLAG)
 		 */
 		ssi_sysconfig = 0x1;
 	}
-	__raw_writel((u32)ssi_sysconfig, SSI_BASE + 0x10);
+
+	__raw_writel(ssi_sysconfig, ssi_base + OMAP_SSI_SYSCONFIG_OFFSET);
+	iounmap(ssi_base);
 }
-- 
1.6.2.4

