From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 07/11] ASoC: OMAP: mcbsp.h: Clean up bit definitions
Date: Wed, 15 Feb 2012 17:37:56 +0200
Message-ID: <1329320280-1621-8-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55928 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751806Ab2BOPi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:28 -0500
Received: by lagz14 with SMTP id z14so1980898lag.27
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:38:14 -0800 (PST)
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

Use BIT() for bit position, correct field definition by adding mask to
them, and also adding the missing spaces around '<<'

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.h |  194 ++++++++++++++++++++++++------------------------
 1 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 6d57993..ec00c27 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -89,130 +89,130 @@ enum {
 #define OMAP_ST_REG_SSELCR	0x2C
 
 /************************** McBSP SPCR1 bit definitions ***********************/
-#define RRST			0x0001
-#define RRDY			0x0002
-#define RFULL			0x0004
-#define RSYNC_ERR		0x0008
-#define RINTM(value)		((value)<<4)	/* bits 4:5 */
-#define ABIS			0x0040
-#define DXENA			0x0080
-#define CLKSTP(value)		((value)<<11)	/* bits 11:12 */
-#define RJUST(value)		((value)<<13)	/* bits 13:14 */
-#define ALB			0x8000
-#define DLB			0x8000
+#define RRST			BIT(0)
+#define RRDY			BIT(1)
+#define RFULL			BIT(2)
+#define RSYNC_ERR		BIT(3)
+#define RINTM(value)		(((value) & 0x3) << 4)	/* bits 4:5 */
+#define ABIS			BIT(6)
+#define DXENA			BIT(7)
+#define CLKSTP(value)		(((value) & 0x3) << 11)	/* bits 11:12 */
+#define RJUST(value)		(((value) & 0x3) << 13)	/* bits 13:14 */
+#define ALB			BIT(15)
+#define DLB			BIT(15)
 
 /************************** McBSP SPCR2 bit definitions ***********************/
-#define XRST		0x0001
-#define XRDY		0x0002
-#define XEMPTY		0x0004
-#define XSYNC_ERR	0x0008
-#define XINTM(value)	((value)<<4)		/* bits 4:5 */
-#define GRST		0x0040
-#define FRST		0x0080
-#define SOFT		0x0100
-#define FREE		0x0200
+#define XRST			BIT(0)
+#define XRDY			BIT(1)
+#define XEMPTY			BIT(2)
+#define XSYNC_ERR		BIT(3)
+#define XINTM(value)		(((value) & 0x3) << 4)	/* bits 4:5 */
+#define GRST			BIT(6)
+#define FRST			BIT(7)
+#define SOFT			BIT(8)
+#define FREE			BIT(9)
 
 /************************** McBSP PCR bit definitions *************************/
-#define CLKRP		0x0001
-#define CLKXP		0x0002
-#define FSRP		0x0004
-#define FSXP		0x0008
-#define DR_STAT		0x0010
-#define DX_STAT		0x0020
-#define CLKS_STAT	0x0040
-#define SCLKME		0x0080
-#define CLKRM		0x0100
-#define CLKXM		0x0200
-#define FSRM		0x0400
-#define FSXM		0x0800
-#define RIOEN		0x1000
-#define XIOEN		0x2000
-#define IDLE_EN		0x4000
+#define CLKRP			BIT(0)
+#define CLKXP			BIT(1)
+#define FSRP			BIT(2)
+#define FSXP			BIT(3)
+#define DR_STAT			BIT(4)
+#define DX_STAT			BIT(5)
+#define CLKS_STAT		BIT(6)
+#define SCLKME			BIT(7)
+#define CLKRM			BIT(8)
+#define CLKXM			BIT(9)
+#define FSRM			BIT(10)
+#define FSXM			BIT(11)
+#define RIOEN			BIT(12)
+#define XIOEN			BIT(13)
+#define IDLE_EN			BIT(14)
 
 /************************** McBSP RCR1 bit definitions ************************/
-#define RWDLEN1(value)		((value)<<5)	/* Bits 5:7 */
-#define RFRLEN1(value)		((value)<<8)	/* Bits 8:14 */
+#define RWDLEN1(value)		(((value) & 0x7) << 5)	/* Bits 5:7 */
+#define RFRLEN1(value)		(((value) & 0x7f) << 8)	/* Bits 8:14 */
 
 /************************** McBSP XCR1 bit definitions ************************/
-#define XWDLEN1(value)		((value)<<5)	/* Bits 5:7 */
-#define XFRLEN1(value)		((value)<<8)	/* Bits 8:14 */
+#define XWDLEN1(value)		(((value) & 0x7) << 5)	/* Bits 5:7 */
+#define XFRLEN1(value)		(((value) & 0x7f) << 8)	/* Bits 8:14 */
 
 /*************************** McBSP RCR2 bit definitions ***********************/
-#define RDATDLY(value)		(value)		/* Bits 0:1 */
-#define RFIG			0x0004
-#define RCOMPAND(value)		((value)<<3)	/* Bits 3:4 */
-#define RWDLEN2(value)		((value)<<5)	/* Bits 5:7 */
-#define RFRLEN2(value)		((value)<<8)	/* Bits 8:14 */
-#define RPHASE			0x8000
+#define RDATDLY(value)		((value) & 0x3)		/* Bits 0:1 */
+#define RFIG			BIT(2)
+#define RCOMPAND(value)		(((value) & 0x3) << 3)	/* Bits 3:4 */
+#define RWDLEN2(value)		(((value) & 0x7) << 5)	/* Bits 5:7 */
+#define RFRLEN2(value)		(((value) & 0x7f) << 8)	/* Bits 8:14 */
+#define RPHASE			BIT(15)
 
 /*************************** McBSP XCR2 bit definitions ***********************/
-#define XDATDLY(value)		(value)		/* Bits 0:1 */
-#define XFIG			0x0004
-#define XCOMPAND(value)		((value)<<3)	/* Bits 3:4 */
-#define XWDLEN2(value)		((value)<<5)	/* Bits 5:7 */
-#define XFRLEN2(value)		((value)<<8)	/* Bits 8:14 */
-#define XPHASE			0x8000
+#define XDATDLY(value)		((value) & 0x3)		/* Bits 0:1 */
+#define XFIG			BIT(2)
+#define XCOMPAND(value)		(((value) & 0x3) << 3)	/* Bits 3:4 */
+#define XWDLEN2(value)		(((value) & 0x7) << 5)	/* Bits 5:7 */
+#define XFRLEN2(value)		(((value) & 0x7f) << 8)	/* Bits 8:14 */
+#define XPHASE			BIT(15)
 
 /************************* McBSP SRGR1 bit definitions ************************/
-#define CLKGDV(value)		(value)		/* Bits 0:7 */
-#define FWID(value)		((value)<<8)	/* Bits 8:15 */
+#define CLKGDV(value)		((value) & 0x7f)		/* Bits 0:7 */
+#define FWID(value)		(((value) & 0xff) << 8)	/* Bits 8:15 */
 
 /************************* McBSP SRGR2 bit definitions ************************/
-#define FPER(value)		(value)		/* Bits 0:11 */
-#define FSGM			0x1000
-#define CLKSM			0x2000
-#define CLKSP			0x4000
-#define GSYNC			0x8000
+#define FPER(value)		((value) & 0x0fff)	/* Bits 0:11 */
+#define FSGM			BIT(12)
+#define CLKSM			BIT(13)
+#define CLKSP			BIT(14)
+#define GSYNC			BIT(15)
 
 /************************* McBSP MCR1 bit definitions *************************/
-#define RMCM			0x0001
-#define RCBLK(value)		((value)<<2)	/* Bits 2:4 */
-#define RPABLK(value)		((value)<<5)	/* Bits 5:6 */
-#define RPBBLK(value)		((value)<<7)	/* Bits 7:8 */
+#define RMCM			BIT(0)
+#define RCBLK(value)		(((value) & 0x7) << 2)	/* Bits 2:4 */
+#define RPABLK(value)		(((value) & 0x3) << 5)	/* Bits 5:6 */
+#define RPBBLK(value)		(((value) & 0x3) << 7)	/* Bits 7:8 */
 
 /************************* McBSP MCR2 bit definitions *************************/
-#define XMCM(value)		(value)		/* Bits 0:1 */
-#define XCBLK(value)		((value)<<2)	/* Bits 2:4 */
-#define XPABLK(value)		((value)<<5)	/* Bits 5:6 */
-#define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
+#define XMCM(value)		((value) & 0x3)		/* Bits 0:1 */
+#define XCBLK(value)		(((value) & 0x7) << 2)	/* Bits 2:4 */
+#define XPABLK(value)		(((value) & 0x3) << 5)	/* Bits 5:6 */
+#define XPBBLK(value)		(((value) & 0x3) << 7)	/* Bits 7:8 */
 
 /*********************** McBSP XCCR bit definitions *************************/
-#define EXTCLKGATE		0x8000
-#define PPCONNECT		0x4000
-#define DXENDLY(value)		((value)<<12)	/* Bits 12:13 */
-#define XFULL_CYCLE		0x0800
-#define DILB			0x0020
-#define XDMAEN			0x0008
-#define XDISABLE		0x0001
+#define XDISABLE		BIT(0)
+#define XDMAEN			BIT(3)
+#define DILB			BIT(5)
+#define XFULL_CYCLE		BIT(11)
+#define DXENDLY(value)		(((value) & 0x3) << 12)	/* Bits 12:13 */
+#define PPCONNECT		BIT(14)
+#define EXTCLKGATE		BIT(15)
 
 /********************** McBSP RCCR bit definitions *************************/
-#define RFULL_CYCLE		0x0800
-#define RDMAEN			0x0008
-#define RDISABLE		0x0001
+#define RDISABLE		BIT(0)
+#define RDMAEN			BIT(3)
+#define RFULL_CYCLE		BIT(11)
 
 /********************** McBSP SYSCONFIG bit definitions ********************/
-#define CLOCKACTIVITY(value)	((value)<<8)
-#define SIDLEMODE(value)	((value)<<3)
-#define ENAWAKEUP		0x0004
-#define SOFTRST			0x0002
+#define SOFTRST			BIT(1)
+#define ENAWAKEUP		BIT(2)
+#define SIDLEMODE(value)	(((value) & 0x3) << 3)
+#define CLOCKACTIVITY(value)	(((value) & 0x3) << 8)
 
 /********************** McBSP SSELCR bit definitions ***********************/
-#define SIDETONEEN		0x0400
+#define SIDETONEEN		BIT(10)
 
 /********************** McBSP Sidetone SYSCONFIG bit definitions ***********/
-#define ST_AUTOIDLE		0x0001
+#define ST_AUTOIDLE		BIT(0)
 
 /********************** McBSP Sidetone SGAINCR bit definitions *************/
-#define ST_CH1GAIN(value)	((value<<16))	/* Bits 16:31 */
-#define ST_CH0GAIN(value)	(value)		/* Bits 0:15 */
+#define ST_CH0GAIN(value)	((value) & 0xffff)	/* Bits 0:15 */
+#define ST_CH1GAIN(value)	(((value) & 0xffff) << 16) /* Bits 16:31 */
 
 /********************** McBSP Sidetone SFIRCR bit definitions **************/
-#define ST_FIRCOEFF(value)	(value)		/* Bits 0:15 */
+#define ST_FIRCOEFF(value)	((value) & 0xffff)	/* Bits 0:15 */
 
 /********************** McBSP Sidetone SSELCR bit definitions **************/
-#define ST_COEFFWRDONE		0x0004
-#define ST_COEFFWREN		0x0002
-#define ST_SIDETONEEN		0x0001
+#define ST_SIDETONEEN		BIT(0)
+#define ST_COEFFWREN		BIT(1)
+#define ST_COEFFWRDONE		BIT(2)
 
 /********************** McBSP DMA operating modes **************************/
 #define MCBSP_DMA_MODE_ELEMENT		0
@@ -220,15 +220,15 @@ enum {
 #define MCBSP_DMA_MODE_FRAME		2
 
 /********************** McBSP WAKEUPEN bit definitions *********************/
-#define XEMPTYEOFEN		0x4000
-#define XRDYEN			0x0400
-#define XEOFEN			0x0200
-#define XFSXEN			0x0100
-#define XSYNCERREN		0x0080
-#define RRDYEN			0x0008
-#define REOFEN			0x0004
-#define RFSREN			0x0002
-#define RSYNCERREN		0x0001
+#define RSYNCERREN		BIT(0)
+#define RFSREN			BIT(1)
+#define REOFEN			BIT(2)
+#define RRDYEN			BIT(3)
+#define XSYNCERREN		BIT(7)
+#define XFSXEN			BIT(8)
+#define XEOFEN			BIT(9)
+#define XRDYEN			BIT(10)
+#define XEMPTYEOFEN		BIT(14)
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
-- 
1.7.8.4

