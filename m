From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP: resolve sparse warning concerning
 debug_card_init()
Date: Tue, 9 Oct 2012 20:29:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210092028080.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58543 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab2JIU3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 16:29:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, grinberg@compulab.co.il


Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
debug_card_init() function") results in the following new sparse
warning:

arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?

Fix by implementing Tony's suggestion to add a "sideways include" to the
new location of the debug-devices.h file in arch/arm/mach-omap2/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/debug-devices.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index c7a4c09..5a4678e 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -16,6 +16,7 @@
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
+#include "../mach-omap2/debug-devices.h"
 
 /* Many OMAP development platforms reuse the same "debug board"; these
  * platforms include H2, H3, H4, and Perseus2.
-- 
1.7.10.4

