From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 09/12] ARM: OMAP: USB: remove unnecessary sideways include
Date: Tue, 10 Apr 2012 18:35:55 -0600
Message-ID: <20120411003552.27059.63661.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43934 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759885Ab2DKAiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:22 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove the include of mach-omap2/common.h from plat-omap/usb.c.  It
appears to be unneeded.  Removing it also resolves the sparse warning:

arch/arm/plat-omap/../mach-omap2/common.h:183:12: warning: symbol 'omap_intc_of_init' was not declared. Should it be static?

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/usb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index d2bbfd1..ab62388 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -31,8 +31,6 @@
 
 #include <mach/hardware.h>
 
-#include "../mach-omap2/common.h"
-
 #ifdef	CONFIG_ARCH_OMAP_OTG
 
 void __init


