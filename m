From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 09/20] OMAP: McBSP: Wakeups utilized
Date: Thu, 20 Aug 2009 16:18:15 +0300
Message-ID: <1250774306-7581-9-git-send-email-eduardo.valentin@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65221 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbZHTNdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 09:33:10 -0400
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This patch enables the smart idle mode while
McBPS is being utilized. Once it's done,
force idle mode is taken instead. Apart of it,
it also configures what signals will wake mcbsp up.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |   17 +++++++++++
 arch/arm/plat-omap/mcbsp.c              |   46 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index bd5b759..333061d 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -138,6 +138,7 @@
 #define OMAP_MCBSP_REG_THRSH1	0x94
 #define OMAP_MCBSP_REG_IRQST	0xA0
 #define OMAP_MCBSP_REG_IRQEN	0xA4
+#define OMAP_MCBSP_REG_WAKEUPEN	0xA8
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
 
@@ -253,6 +254,8 @@
 #define RDISABLE		0x0001
 
 /********************** McBSP SYSCONFIG bit definitions ********************/
+#define SIDLEMODE(value)	((value)<<3)
+#define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
 
 /********************** McBSP DMA operating modes **************************/
@@ -260,6 +263,20 @@
 #define MCBSP_DMA_MODE_THRESHOLD	1
 #define MCBSP_DMA_MODE_FRAME		2
 
+/********************** McBSP WAKEUPEN bit definitions *********************/
+#define XEMPTYEOFEN		0x4000
+#define XRDYEN			0x0400
+#define XEOFEN			0x0200
+#define XFSXEN			0x0100
+#define XSYNCERREN		0x0080
+#define RRDYEN			0x0008
+#define REOFEN			0x0004
+#define RFSREN			0x0002
+#define RSYNCERREN		0x0001
+#define WAKEUPEN_ALL		(XEMPTYEOFEN | XRDYEN | XEOFEN | XFSXEN | \
+				 XSYNCERREN | RRDYEN | REOFEN | RFSREN | \
+				 RSYNCERREN)
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u16 spcr2;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 9e69994..136f8c5 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -305,6 +305,46 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 	return dma_op_mode;
 }
 EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
+
+static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
+{
+	/*
+	 * Enable wakup behavior, smart idle and all wakeups
+	 * REVISIT: some wakeups may be unnecessary
+	 */
+	if (cpu_is_omap34xx()) {
+		u16 syscon;
+
+		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
+		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
+	}
+}
+
+static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
+{
+	/*
+	 * Disable wakup behavior, smart idle and all wakeups
+	 */
+	if (cpu_is_omap34xx()) {
+		u16 syscon;
+		u16 wakeupen;
+
+		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+
+		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
+		wakeupen &= ~WAKEUPEN_ALL;
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, wakeupen);
+	}
+}
+#else
+static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp) {}
+static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp) {}
 #endif
 
 /*
@@ -366,6 +406,9 @@ int omap_mcbsp_request(unsigned int id)
 	clk_enable(mcbsp->iclk);
 	clk_enable(mcbsp->fclk);
 
+	/* Do procedure specific to omap34xx arch, if applicable */
+	omap34xx_mcbsp_request(mcbsp);
+
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
@@ -414,6 +457,9 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
+	/* Do procedure specific to omap34xx arch, if applicable */
+	omap34xx_mcbsp_free(mcbsp);
+
 	clk_disable(mcbsp->fclk);
 	clk_disable(mcbsp->iclk);
 
-- 
1.6.2.GIT

