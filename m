From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 06/20] OMAP: McBSP: Use appropriate value for startup delay
Date: Thu, 30 Jul 2009 15:49:29 +0300
Message-ID: <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25910 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZG3NBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:03 -0400
In-Reply-To: <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6b39656..373926d 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -394,7 +394,8 @@ void omap_mcbsp_start(unsigned int id)
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
 	OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
 
-	udelay(100);
+	/*  Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec */
+	udelay(500);
 
 	/* Start frame sync */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
-- 
1.6.2.GIT

