From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC 06/11] ARM: OMAP: Add reset init to prcm file
Date: Tue, 29 Apr 2014 15:19:45 -0500
Message-ID: <1398802790-29287-7-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44801 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386AbaD2UUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 16:20:31 -0400
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org
Cc: t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de, Dan Murphy <dmurphy@ti.com>

Call the reset init API to initialize the
reset framework and data for the related SoC.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/mach-omap2/prm_common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b4c4ab9..7e95f8e 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
+#include <linux/reset_ti.h>
 
 #include "soc.h"
 #include "prm2xxx_3xxx.h"
@@ -523,10 +524,13 @@ int __init of_prcm_init(void)
 		mem = of_iomap(np, 0);
 		clk_memmaps[memmap_index] = mem;
 		ti_dt_clk_init_provider(np, memmap_index);
+
 		memmap_index++;
 	}
 
 	ti_dt_clockdomains_setup();
 
+	ti_dt_reset_init();
+
 	return 0;
 }
-- 
1.7.9.5

