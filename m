From: charu@ti.com
Subject: [PATCH V2] FIX OMAP3:McBSP poll read and write for OMAP3
Date: Tue, 20 Oct 2009 12:11:00 +0530
Message-ID: <1256020860-1108-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35061 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbZJTGlB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 02:41:01 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9K6f3Sc000512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 01:41:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>

omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access
McBSP registers as 16-bit registers.

In OMAP3, McBSP registers (DRR_REG and DXR_REG) are limited to
32-bit data accesses (L4 Interconnect). 16-bit and 8-bit is
not allowed and can corrupt register content.

This patch adds omap3_mcbsp_pollwrite and
omap3_mcbsp_pollread functions for OMAP3 cpu, inorder to
perform 32 bit access of above mentioned McBSP registers.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    4 +
 arch/arm/plat-omap/mcbsp.c              |   92 ++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 0c5f937..b0f9260 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -406,6 +406,10 @@ void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg *
 /* Polled read/write functions */
 int omap_mcbsp_pollread(unsigned int id, u16 * buf);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
+
+int omap3_mcbsp_pollread(unsigned int id, u32 *buf);
+int omap3_mcbsp_pollwrite(unsigned int id, u32 buf);
+
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 
 #endif
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index b6b520d..1212d11 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -425,7 +425,7 @@ void omap_mcbsp_stop(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
-/* polled mcbsp i/o operations */
+/* polled mcbsp i/o operations for omap1 and omap2420 */
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
 	struct omap_mcbsp *mcbsp;
@@ -515,6 +515,96 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 }
 EXPORT_SYMBOL(omap_mcbsp_pollread);
 
+/* polled mcbsp i/o operations for omap3 */
+int omap3_mcbsp_pollwrite(unsigned int id, u32 buf)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *base;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	base = mcbsp->io_base;
+
+	OMAP_MCBSP_WRITE(base, DXR, buf);
+	/* if frame sync error - clear the error */
+	if (OMAP_MCBSP_READ(base, SPCR2) & XSYNC_ERR) {
+		/* clear error */
+		OMAP_MCBSP_WRITE(base, SPCR2, OMAP_MCBSP_READ(base, SPCR2)
+					& (~XSYNC_ERR));
+		/* resend */
+		return -EPERM;
+	} else {
+		/* wait for transmit confirmation */
+		int attemps = 0;
+		while (!(OMAP_MCBSP_READ(base, SPCR2) & XRDY)) {
+			if (attemps++ > 1000) {
+				OMAP_MCBSP_WRITE(base, SPCR2,
+					OMAP_MCBSP_READ(base, SPCR2) &
+					(~XRST));
+				udelay(10);
+				OMAP_MCBSP_WRITE(base, SPCR2,
+					OMAP_MCBSP_READ(base, SPCR2) |
+					(XRST));
+				udelay(10);
+				dev_err(mcbsp->dev, "Could not write to"
+					" McBSP%d Register\n", mcbsp->id);
+				return -ENOENT;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap3_mcbsp_pollwrite);
+
+int omap3_mcbsp_pollread(unsigned int id, u32 *buf)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *base;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	base = mcbsp->io_base;
+	/* if frame sync error - clear the error */
+	if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
+		/* clear error */
+		OMAP_MCBSP_WRITE(base, SPCR1, OMAP_MCBSP_READ(base, SPCR1)
+					& (~RSYNC_ERR));
+		/* resend */
+		return -EPERM;
+	} else {
+		/* wait for recieve confirmation */
+		int attemps = 0;
+		while (!(OMAP_MCBSP_READ(base, SPCR1) & RRDY)) {
+			if (attemps++ > 1000) {
+				OMAP_MCBSP_WRITE(base, SPCR1,
+					OMAP_MCBSP_READ(base, SPCR1) &
+					(~RRST));
+				udelay(10);
+				OMAP_MCBSP_WRITE(base, SPCR1,
+					OMAP_MCBSP_READ(base, SPCR1) |
+					(RRST));
+				udelay(10);
+				dev_err(mcbsp->dev, "Could not read from"
+					" McBSP%d Register\n", mcbsp->id);
+				return -ENOENT;
+			}
+		}
+	}
+	*buf = OMAP_MCBSP_READ(base, DRR);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap3_mcbsp_pollread);
+
 /*
  * IRQ based word transmission.
  */
-- 
1.6.0.4

