From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 04/20] OMAP: McBSP: Add transmit/receive threshold handler
Date: Mon, 17 Aug 2009 14:51:03 +0300
Message-ID: <1250509879-6703-5-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17832 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757905AbZHQMFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:23 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds a way to handle transmit/receive threshold.
It export to mcbsp users a callback registration procedure.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index ceaf9ee..2544aa5 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -389,6 +389,15 @@ int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
+#ifdef CONFIG_ARCH_OMAP34XX
+void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
+void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
+#else
+static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
+{ }
+static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
+{ }
+#endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id, int tx, int rx);
-- 
1.6.2.GIT

