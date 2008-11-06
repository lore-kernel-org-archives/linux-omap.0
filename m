From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] beagle to build again
Date: Thu, 6 Nov 2008 16:02:35 +0200
Message-ID: <20081106140235.GD7467@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20288 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbYKFODT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 09:03:19 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mA6E3Cf6005197
	for <linux-omap@vger.kernel.org>; Thu, 6 Nov 2008 16:03:17 +0200
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Add missing include and make beagle build again.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 0f1c841..fb64845 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -43,6 +43,7 @@
 #include <mach/nand.h>
 #include <mach/mux.h>
 
+#include "mmc-twl4030.h"
 #include "twl4030-generic-scripts.h"
 
 #define GPMC_CS0_BASE  0x60


-- 
balbi
