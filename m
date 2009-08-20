From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 13/20] OMAP: McBSP: Do not enable wakeups for no-idle mode
Date: Thu, 20 Aug 2009 16:18:19 +0300
Message-ID: <1250774306-7581-13-git-send-email-eduardo.valentin@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35182 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbZHTNdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 09:33:04 -0400
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

When no-idle mode is taken, wakeups need not to be enabled.
Moreover, CLOCKACTIVITY bits are unnecessary with this mode
also.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 85176a5..56a5688 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -319,16 +319,17 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 
 		spin_lock_irq(&mcbsp->lock);
-		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
-			syscon |= SIDLEMODE(0x02);
-		else
+		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
+			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
+					CLOCKACTIVITY(0x02));
+			OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN,
+					XRDYEN | RRDYEN);
+		} else {
 			syscon |= SIDLEMODE(0x01);
+		}
 		spin_unlock_irq(&mcbsp->lock);
 
-		syscon |= (ENAWAKEUP | CLOCKACTIVITY(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
-
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, XRDYEN | RRDYEN);
 	}
 }
 
-- 
1.6.2.GIT

