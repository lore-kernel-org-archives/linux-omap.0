From: Pavel Machek <pavel@ucw.cz>
Subject: [patch] fix omap compile with randconfig
Date: Mon, 13 Jan 2014 02:00:25 +0100
Message-ID: <20140113010025.GA14431@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58903 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaAMBA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Jan 2014 20:00:27 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


This fixes:

arch/arm/mach-omap2/built-in.o: In function `omap_reserve':
/data/l/linux-n900/arch/arm/mach-omap2/common.c:36: undefined
  reference to `omap_fb_reserve_memblock'

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 9beecde..857907f 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -33,5 +33,7 @@ void __init omap_reserve(void)
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
+#ifdef CONFIG_OMAP2_VRFB
 	omap_fb_reserve_memblock();
+#endif
 }


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
