From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 03/20] OMAP: McBSP: Use appropriate value for startup delay
Date: Tue, 11 Aug 2009 16:05:14 +0300
Message-ID: <1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19798 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbZHKNSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 09:18:38 -0400
In-Reply-To: <1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 84cc323..2383b08 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -359,7 +359,13 @@ void omap_mcbsp_start(unsigned int id)
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
 	OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
 
-	udelay(100);
+	/*
+	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
+	 * REVISIT: 100us may give enough time for two CLKSRG, however
+	 * due to some unknown PM related, clock gating etc. reason it
+	 * is now at 500us.
+	 */
+	udelay(500);
 
 	/* Start frame sync */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
-- 
1.6.2.GIT

