From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/26] ARM: AM43XX: PRM: use OMAP4 PRM driver
Date: Mon, 1 Sep 2014 21:08:51 +0300
Message-ID: <1409594955-1476-3-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44811 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180AbaIASJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:09:50 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

AM43xx will be re-using OMAP4 PRM driver, thus call its init function.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5d0667c..5c2c71a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -608,6 +608,7 @@ void __init am43xx_init_early(void)
 	omap_cm_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
+	omap44xx_prm_init();
 	am43xx_powerdomains_init();
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
-- 
1.7.9.5

