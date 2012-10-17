From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Nokia N9/N900/N950 -- mention product names
Date: Wed, 17 Oct 2012 20:33:08 +0200
Message-ID: <20121017183307.GA12560@elf.ucw.cz>
References: <1330967337-9634-1-git-send-email-aaro.koskinen@nokia.com>
 <20120501104801.GA23559@elf.ucw.cz>
 <20120504181105.GL5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35810 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757609Ab2JQSdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 14:33:10 -0400
Content-Disposition: inline
In-Reply-To: <20120504181105.GL5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, arnd@arndb.de
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi!

This adds product names (that most users know) to Kconfig and board
comments.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 346fd26..da08226 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -263,14 +263,14 @@ config MACH_NOKIA_N8X0
 	select MACH_NOKIA_N810_WIMAX
 
 config MACH_NOKIA_RM680
-	bool "Nokia RM-680/696 board"
+	bool "Nokia N9/N950 (RM-680/696) phones"
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
 	select MACH_NOKIA_RM696
 
 config MACH_NOKIA_RX51
-	bool "Nokia RX-51 board"
+	bool "Nokia N900 phone (RX-51)"
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 0ad1bb3b..26965f3 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -1,5 +1,5 @@
 /*
- * Board support file for Nokia RM-680/696.
+ * Board support file for Nokia N9/N950 (aka RM-680/696).
  *
  * Copyright (C) 2010 Nokia
  *
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 345dd93..b60ca9d 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-omap2/board-rx51.c
+ * Board support file for Nokia N900 (aka RX-51).
  *
  * Copyright (C) 2007, 2008 Nokia
  *

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
