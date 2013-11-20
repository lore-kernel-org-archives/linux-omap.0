From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 28/31] arm: omap: irq: remove unnecessary header
Date: Wed, 20 Nov 2013 12:09:15 -0600
Message-ID: <1384970958-4118-29-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab3KTSKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:10:51 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

There's no need for that header to be included.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 397157a..5d4e883 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -24,7 +24,6 @@
 #include <linux/of_irq.h>
 
 #include "soc.h"
-#include "iomap.h"
 #include "common.h"
 #include "../../drivers/irqchip/irqchip.h"
 
-- 
1.8.4.GIT

