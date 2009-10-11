From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ARM: OMAP: McBSP: Fix incorrect receiver stop in omap_mcbsp_stop
Date: Sun, 11 Oct 2009 18:22:26 +0300
Message-ID: <1255274546-29747-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:46250 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbZJKPW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Oct 2009 11:22:28 -0400
Received: by ewy4 with SMTP id 4so1861903ewy.37
        for <linux-omap@vger.kernel.org>; Sun, 11 Oct 2009 08:21:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>

This small typo written by author causes that McBSP receiver is disabled on
OMAP2430 and OMAP3430 even if only transmitter is stopped. This was noted
with ALSA SoC where simultaneous recording halted if playback was stopped
first.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 88ac976..e664b91 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -595,7 +595,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 	rx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		w = OMAP_MCBSP_READ(io_base, RCCR);
-		w |= (tx ? RDISABLE : 0);
+		w |= (rx ? RDISABLE : 0);
 		OMAP_MCBSP_WRITE(io_base, RCCR, w);
 	}
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
-- 
1.6.3.3

