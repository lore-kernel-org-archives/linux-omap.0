From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 11/11] ARM: OMAP2+: AM43x PRCM init
Date: Thu, 26 Sep 2013 15:03:55 +0530
Message-ID: <0d7fb00e7ea5209362fca057611da741b18bd84d.1380179370.git.afzal@ti.com>
References: <cover.1380179370.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34667 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115Ab3IZJeT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 05:34:19 -0400
In-Reply-To: <cover.1380179370.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Ambresh K <ambresh@ti.com>

From: Ambresh K <ambresh@ti.com>

Initialise AM43x HWMOD, powerdomains and clockdomains.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index ff2113c..c90f647 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -594,7 +594,13 @@ void __init am43xx_init_early(void)
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
+	omap_prm_base_init();
+	omap_cm_base_init();
 	omap3xxx_check_revision();
+	am43xx_powerdomains_init();
+	am43xx_clockdomains_init();
+	am43xx_hwmod_init();
+	omap_hwmod_init_postsetup();
 }
 #endif
 
-- 
1.8.3.4

