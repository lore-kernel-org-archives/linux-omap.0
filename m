From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 22/36] ARM: OMAP: DRA7: Enable clock init
Date: Wed, 9 Oct 2013 18:30:53 +0300
Message-ID: <1381332668-962-23-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449Ab3JIPeO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:34:14 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Initializes clock data from device tree.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3263022..ef04dd5 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -671,6 +671,7 @@ void __init dra7xx_init_early(void)
 	dra7xx_clockdomains_init();
 	dra7xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_init = dra7xx_dt_clk_init;
 }
 #endif
 
-- 
1.7.9.5

