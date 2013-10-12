From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 11/11] ARM: OMAP2+: AM43x PRCM init
Date: Sat, 12 Oct 2013 15:46:37 +0530
Message-ID: <8c6433de33e6804078bf243f822a93a501e8c447.1381569236.git.afzal@ti.com>
References: <cover.1381569236.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51199 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753Ab3JLKRB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Oct 2013 06:17:01 -0400
In-Reply-To: <cover.1381569236.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Ambresh K <ambresh@ti.com>

From: Ambresh K <ambresh@ti.com>

Initialise AM43x HWMOD, powerdomains and clockdomains.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
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

