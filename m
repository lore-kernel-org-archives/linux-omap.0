From: mesak82@gmail.com
Subject: [PATCH][OMAPZOOM] OMAP3: Fix handling of McBSP registers XCCR and RCCR for OMAP2430/34xx
Date: Thu, 20 Nov 2008 22:31:23 -0600
Message-ID: <1227241883-26009-1-git-send-email-mesak82@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45947 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbYKUEbd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 23:31:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vikram.pandita@ti.com, Misael Lopez Cruz <mesak82@gmail.com>

From: Misael Lopez Cruz <mesak82@gmail.com>

This patch fixes handling of XCCR and RCCR registers of McBSP for OMAP2430
and 34xx platforms. It also fixes OMAP McBSP DAI driver which was setting
those registers to 0, as they were not initialized.

Signed-off-by: Misael Lopez Cruz <mesak82@gmail.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    7 +++++++
 arch/arm/plat-omap/mcbsp.c              |    1 +
 sound/soc/omap/omap-mcbsp.c             |    4 ++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 3e38575..faa9164 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -245,11 +245,16 @@
 #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
 
 /*********************** McBSP XCCR bit definitions *************************/
+#define EXTCLKGATE		0x8000
+#define PPCONNECT		0x4000
+#define DXENDLY(value)		((value)<<12)	/* Bits 12:13 */
+#define XFULL_CYCLE		0x0800
 #define DILB			0x0020
 #define XDMAEN			0x0008
 #define XDISABLE		0x0001
 
 /********************** McBSP RCCR bit definitions *************************/
+#define RFULL_CYCLE		0x0800
 #define RDMAEN			0x0008
 #define RDISABLE		0x0001
 
@@ -403,8 +408,10 @@ struct omap_mcbsp_reg_cfg {
 	u16 rcerh;
 	u16 xcerg;
 	u16 xcerh;
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 	u16 xccr;
 	u16 rccr;
+#endif
 };
 
 typedef enum {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 906e8e3..2b29033 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -174,6 +174,7 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
 	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
 	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
+	/* Write to xccr and rccr only for omap2430/34xx */
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		if (mcbsp->pdata->ops->config)
 			mcbsp->pdata->ops->config(id, config);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3a4cc4b..51a9313 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -285,6 +285,10 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	regs->spcr1	|= RINTM(3);
 	regs->rcr2	|= RFIG;
 	regs->xcr2	|= XFIG;
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		regs->xccr = DXENDLY(1) | XDMAEN;
+		regs->rccr = RFULL_CYCLE | RDMAEN;
+	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-- 
1.5.6.3

