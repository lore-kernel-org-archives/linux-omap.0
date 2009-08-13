From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 12/20] OMAP: McBSP: Configure NO IDLE mode for DMA mode different of threshold
Date: Thu, 13 Aug 2009 17:35:25 +0300
Message-ID: <1250174133-451-13-git-send-email-eduardo.valentin@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-4-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-5-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-6-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-7-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-8-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-9-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-10-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-11-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38970 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZHMOsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 10:48:47 -0400
In-Reply-To: <1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Use dma mode property to configure NO IDLE or SMART IDLE of McBSPs.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 1db2ebc..8a78b61 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -317,7 +317,15 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
-		syscon |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY(0x02));
+
+		spin_lock_irq(&mcbsp->lock);
+		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+			syscon |= SIDLEMODE(0x02);
+		else
+			syscon |= SIDLEMODE(0x01);
+		spin_unlock_irq(&mcbsp->lock);
+
+		syscon |= (ENAWAKEUP | CLOCKACTIVITY(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, XRDYEN | RRDYEN);
-- 
1.6.2.GIT

