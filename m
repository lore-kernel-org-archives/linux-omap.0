From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] arch: arm: mach-omap1: timer32k.c:  Remove unused function
Date: Sun,  7 Dec 2014 13:28:56 +0100
Message-ID: <1417955336-10751-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41107 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbaLGM0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2014 07:26:17 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so4162357wgh.26
        for <linux-omap@vger.kernel.org>; Sun, 07 Dec 2014 04:26:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Remove the function omap_32k_timer_read() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-omap1/timer32k.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 107e7ab..36bf174 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -91,11 +91,6 @@ static inline void omap_32k_timer_write(int val, int reg)
 	omap_writew(val, OMAP1_32K_TIMER_BASE + reg);
 }
 
-static inline unsigned long omap_32k_timer_read(int reg)
-{
-	return omap_readl(OMAP1_32K_TIMER_BASE + reg) & 0xffffff;
-}
-
 static inline void omap_32k_timer_start(unsigned long load_val)
 {
 	if (!load_val)
-- 
1.7.10.4

