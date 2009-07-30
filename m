From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 02/20] OMAP: McBSP: Wakeups utilized
Date: Thu, 30 Jul 2009 15:49:25 +0300
Message-ID: <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25899 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbZG3NBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:00 -0400
In-Reply-To: <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This patch enables the smart idle mode while
McBPS is being utilized. Once it's done,
force idle mode is taken instead. Apart of it,
it also configures what signals will wake mcbsp up.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |   17 +++++++++++++++
 arch/arm/plat-omap/mcbsp.c              |   35 +++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 77191c5..758ad5c 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -134,6 +134,7 @@
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
 #define OMAP_MCBSP_REG_SYSCON	0x8C
+#define OMAP_MCBSP_REG_WAKEUPEN	0xA8
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
 
@@ -249,8 +250,24 @@
 #define RDISABLE		0x0001
 
 /********************** McBSP SYSCONFIG bit definitions ********************/
+#define SIDLEMODE(value)	((value)<<3)
+#define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
 
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
index 84cc323..b64896b 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -257,6 +257,23 @@ int omap_mcbsp_request(unsigned int id)
 	clk_enable(mcbsp->iclk);
 	clk_enable(mcbsp->fclk);
 
+#ifdef CONFIG_ARCH_OMAP34XX
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
+#endif
+
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
@@ -295,6 +312,7 @@ EXPORT_SYMBOL(omap_mcbsp_request);
 void omap_mcbsp_free(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
+	u16 wakeupen;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -305,6 +323,23 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
+#ifdef CONFIG_ARCH_OMAP34XX
+	/*
+	 * Disable wakup behavior, smart idle and all wakeups
+	 */
+	if (cpu_is_omap34xx()) {
+		u16 syscon;
+
+		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+
+		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
+		wakeupen &= ~WAKEUPEN_ALL;
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, wakeupen);
+	}
+#endif
+
 	clk_disable(mcbsp->fclk);
 	clk_disable(mcbsp->iclk);
 
-- 
1.6.2.GIT

