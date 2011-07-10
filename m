From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP: dmtimer: add missing include
Date: Sat, 9 Jul 2011 18:13:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091813180.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55511 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab1GJANp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 20:13:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com


After commit caf64f2fdc48472995d40656eb1a75524c464447 ("omap: Make a subset
of dmtimer functions into inline functions"),
arch/arm/plat-omap/include/plat/dmtimer.h is missing an include of linux/io.h
- add it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index d0f3a2d..eb5d16c 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -34,6 +34,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
-- 
1.7.5.4

