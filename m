From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] OMAP: McBSP: Wakeups utilized
Date: Fri, 23 Jan 2009 08:43:43 +0200
Message-ID: <12326930232272-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17275 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZAWGsw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 01:48:52 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0N6mXbL000708
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 08:48:49 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This patch enables the smart idle mode while
McBPS is being utilized. Once it's done,
force idle mode is taken instead. 

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |   16 ++++++++++++++++
 arch/arm/plat-omap/mcbsp.c              |   28 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 113c246..7232950 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -249,8 +249,24 @@
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
index e5842e3..ce9d09f 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -216,6 +216,7 @@ int omap_mcbsp_request(unsigned int id)
 	struct omap_mcbsp *mcbsp;
 	int i;
 	int err;
+	u16 syscon;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -241,6 +242,19 @@ int omap_mcbsp_request(unsigned int id)
 	spin_unlock(&mcbsp->lock);
 
 	/*
+	 * Enable wakup behavior, smart idle and all wakeups
+	 * REVISIT: some wakeups may be unnecessary
+	 */
+	if (cpu_is_omap34xx()) {
+		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
+		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
+	}
+
+	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
 	 */
@@ -278,6 +292,7 @@ EXPORT_SYMBOL(omap_mcbsp_request);
 void omap_mcbsp_free(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
+	u16 syscon, wakeupen;
 	int i;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -286,6 +301,19 @@ void omap_mcbsp_free(unsigned int id)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
+	/*
+	 * Disable wakup behavior, smart idle and all wakeups
+	 */
+	if (cpu_is_omap34xx()) {
+		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+
+		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
+		wakeupen &= ~WAKEUPEN_ALL;
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, wakeupen);
+	}
+
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-- 
1.6.0

