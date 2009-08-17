From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 01/20] OMAP: McBSP: Provide functions for ASoC frame syncronization
Date: Mon, 17 Aug 2009 14:51:00 +0300
Message-ID: <1250509879-6703-2-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23232 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904AbZHQMFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:22 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

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
index 57249bb..b85e6e6 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -389,6 +389,8 @@ int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id, int tx, int rx);
 void omap_mcbsp_stop(unsigned int id, int tx, int rx);
+void omap_mcbsp_xmit_enable(unsigned int id, u8 enable);
+void omap_mcbsp_recv_enable(unsigned int id, u8 enable);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word);
 u32 omap_mcbsp_recv_word(unsigned int id);
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index a3d2313..0aa2524 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -412,6 +412,58 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
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
1.6.2.GIT

