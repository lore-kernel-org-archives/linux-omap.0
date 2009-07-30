From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 12/20] OMAP: McBSP: Configure NO IDLE mode for DMA mode different of threshold
Date: Thu, 30 Jul 2009 15:49:35 +0300
Message-ID: <1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25907 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbZG3NBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:03 -0400
In-Reply-To: <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Use dma mode property to configure NO IDLE or SMART IDLE of McBSPs.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6c535b3..11cfcfe 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -376,7 +376,15 @@ int omap_mcbsp_request(unsigned int id)
 
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
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
-- 
1.6.2.GIT

