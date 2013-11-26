From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 39/41] ARM: AM43xx: Enable clock init
Date: Tue, 26 Nov 2013 10:06:20 +0200
Message-ID: <1385453182-24421-40-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab3KZIKm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 03:10:42 -0500
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Initializes clock data from device tree.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 628a7f5..2e0f0fe 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -606,6 +606,7 @@ void __init am43xx_init_early(void)
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_soc_init = am43xx_clk_init;
 }
 
 void __init am43xx_init_late(void)
-- 
1.7.9.5

