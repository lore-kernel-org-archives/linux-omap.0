From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 03/20] OMAP: McBSP: Use appropriate value for startup delay
Date: Thu, 20 Aug 2009 16:18:09 +0300
Message-ID: <1250774306-7581-3-git-send-email-eduardo.valentin@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35170 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZHTNdA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 09:33:00 -0400
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Increasing startup delay value as worst case:
 CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec

Although, 100us may give enough time for two CLKSRG,
due to some unknown PM related, clock gating etc. reason,
this patch increases it to 500us.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0aa2524..e9dd703 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -365,7 +365,13 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
 	OMAP_MCBSP_WRITE(io_base, SPCR1, w | (rx & 1));
 
-	udelay(100);
+	/*
+	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
+	 * REVISIT: 100us may give enough time for two CLKSRG, however
+	 * due to some unknown PM related, clock gating etc. reason it
+	 * is now at 500us.
+	 */
+	udelay(500);
 
 	if (idle) {
 		/* Start frame sync */
-- 
1.6.2.GIT

