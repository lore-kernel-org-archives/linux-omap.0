From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] ARM: OMAP1: fix sparse warning added by commit
 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3
Date: Fri, 26 Oct 2012 14:08:28 -0600
Message-ID: <20121026200827.16521.15224.stgit@dusk.lan>
References: <20121026200413.16521.88985.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40898 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966362Ab2JZUJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:09:02 -0400
In-Reply-To: <20121026200413.16521.88985.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Commit 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3 ("ARM: OMAP: Make
plat/fpga.h local to arch/arm/plat-omap") results in a new warning from
sparse:

arch/arm/mach-omap1/fpga.c:147:6: warning: symbol 'omap1510_fpga_init_irq' was not declared. Should it be static?

Fix by adding a missing include.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/fpga.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 4ec220d..d940fac 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -32,6 +32,7 @@
 #include <mach/hardware.h>
 
 #include "iomap.h"
+#include "common.h"
 
 static void fpga_mask_irq(struct irq_data *d)
 {


