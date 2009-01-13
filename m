From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 2/3] McBSP: Provide functions for ASoC frame syncronization
Date: Tue, 13 Jan 2009 09:52:14 +0200
Message-ID: <12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
 <12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56666 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbZAMHzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 02:55:07 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D7sot7008369
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 09:55:05 +0200
In-Reply-To: <12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

ASoC has an annoying bug letting either L or R channel to be
played on L channel. In other words, L and R channels can
switch at random. This provides McBSP funtionality that may
be used to fix this feature.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    2 +
 arch/arm/plat-omap/mcbsp.c              |   52 +++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index cc48f2f..07dfcd0 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -385,6 +385,8 @@ int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id);
 void omap_mcbsp_stop(unsigned int id);
+void omap_mcbsp_xmit_enable(unsigned int id, u8 enable);
+void omap_mcbsp_recv_enable(unsigned int id, u8 enable);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word);
 u32 omap_mcbsp_recv_word(unsigned int id);
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f2401a8..5c4162d 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -378,6 +378,58 @@ void omap_mcbsp_stop(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
+void omap_mcbsp_xmit_enable(unsigned int id, u8 enable)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+	u16 w;
+
+	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	w = OMAP_MCBSP_READ(io_base, XCCR);
+
+	if (enable)
+		OMAP_MCBSP_WRITE(io_base, XCCR, w & ~(XDISABLE));
+	else
+		OMAP_MCBSP_WRITE(io_base, XCCR, w | XDISABLE);
+}
+EXPORT_SYMBOL(omap_mcbsp_xmit_enable);
+
+void omap_mcbsp_recv_enable(unsigned int id, u8 enable)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+	u16 w;
+
+	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	w = OMAP_MCBSP_READ(io_base, RCCR);
+
+	if (enable)
+		OMAP_MCBSP_WRITE(io_base, RCCR, w & ~(RDISABLE));
+	else
+		OMAP_MCBSP_WRITE(io_base, RCCR, w | RDISABLE);
+}
+EXPORT_SYMBOL(omap_mcbsp_recv_enable);
+
 /* polled mcbsp i/o operations */
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
-- 
1.5.2

