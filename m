From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM set
Date: Thu, 29 Oct 2009 23:39:44 +0100
Message-ID: <200910292339.48610.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:37349 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737AbZJ2Wla (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 18:41:30 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, Paul Walmsley <paul@pwsan.com>

With CONFIG_PM=y, the omapfb/lcd device on Amstrad Delta, after initially
starting correctly, breaks with the following error messages:

omapfb omapfb: resetting (status 0xffffff96,reset count 1)
...
omapfb omapfb: resetting (status 0xffffff96,reset count 100)
omapfb omapfb: too many reset attempts, giving up.

Looking closer at this I have found that it had been broken almost 2 years ago
with commit 2418996e3b100114edb2ae110d5d4acb928909d2, PM fixes for OMAP1.

The definite reason for broken omapfb/lcd_ams_delta in PM mode appeared to be
ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle. The patch below fixes it.

Created and tested against linux-2.6.32-rc5

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Hi,

I already reported this issue a few months ago, when
drivers/video/omap/lcd_ams_delta.c was proposed to get into mainline - see
http://www.spinics.net/lists/linux-omap/msg14546.html. Now I've found some
time to look at it again.

Since PM area is quite new to me, I am not sure if there may be a better
solution. AFAICS, the standard way to prevent an ARM_CLKCT1 bit being switched
to idle is to enable a clock that uses it (tipb_ck, dma_ck, or tc_ck or one of
its children in this case, right?).

I assume there is no bug in omapfb nor lcdc, as that would be already
detected. Maybe it would be better to fix drivers/video/omap/lcd_ams_delta.c
(or arch/arm/mach-omap1/board-ams-delta), but I don't know what clock should I
enable, if any.

--- linux-2.6.32-rc5/arch/arm/mach-omap1/pm.c.orig	2009-10-16 02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/arch/arm/mach-omap1/pm.c	2009-10-29 22:07:58.000000000 +0100
@@ -45,6 +45,7 @@
 
 #include <asm/irq.h>
 #include <asm/atomic.h>
+#include <asm/mach-types.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
@@ -139,7 +140,7 @@ void omap1_pm_idle(void)
 	use_idlect1 = omap_dm_timer_modify_idlect_mask(use_idlect1);
 #endif
 
-	if (omap_dma_running())
+	if ((omap_dma_running()) || (machine_is_ams_delta()))
 		use_idlect1 &= ~(1 << 6);
 
 	/* We should be able to remove the do_sleep variable and multiple
