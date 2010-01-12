From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 2/7] DSPBRIDGE: Replace magic numbers in SSI configuration
Date: Mon, 11 Jan 2010 19:00:36 -0600
Message-ID: <1263258041-16836-3-git-send-email-omar.ramirez@ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab0ALAvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:51:15 -0500
In-Reply-To: <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Rename ssi_sysconfig variable and replace the usage of magic
numbers while updating SSI configuration.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/services/clk.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 21a61d8..d6b2259 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -58,6 +58,10 @@ typedef volatile unsigned long  REG_UWORD32;
 #define OMAP_SSI_SIZE			0x1000
 #define OMAP_SSI_SYSCONFIG_OFFSET	0x10
 
+#define SSI_AUTOIDLE			(1 << 0)
+#define SSI_SIDLE_SMARTIDLE		(2 << 3)
+#define SSI_MIDLE_NOIDLE		(1 << 12)
+
 struct SERVICES_Clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
@@ -353,8 +357,8 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
 
 void SSI_Clk_Prepare(bool FLAG)
 {
-	u32 ssi_sysconfig;
 	void __iomem *ssi_base;
+	unsigned int value;
 
 	ssi_base = ioremap(L4_34XX_BASE + OMAP_SSI_OFFSET, OMAP_SSI_SIZE);
 	if (!ssi_base) {
@@ -366,14 +370,14 @@ void SSI_Clk_Prepare(bool FLAG)
 		/* Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
 		 * no idle
 		 */
-		ssi_sysconfig = 0x1011;
+		value = SSI_AUTOIDLE | SSI_SIDLE_SMARTIDLE | SSI_MIDLE_NOIDLE;
 	} else {
 		/* Set Autoidle, SIDLEMode to forced idle, and MIDLEmode to
 		 * forced idle
 		 */
-		ssi_sysconfig = 0x1;
+		value = SSI_AUTOIDLE;
 	}
 
-	__raw_writel(ssi_sysconfig, ssi_base + OMAP_SSI_SYSCONFIG_OFFSET);
+	__raw_writel(value, ssi_base + OMAP_SSI_SYSCONFIG_OFFSET);
 	iounmap(ssi_base);
 }
-- 
1.6.2.4

