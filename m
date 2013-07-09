From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 10/12] ARM: DRA7: Enable PM framework initializations
Date: Tue, 9 Jul 2013 13:02:17 +0530
Message-ID: <1373355139-12487-11-git-send-email-rnayak@ti.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51473 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141Ab3GIHd0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:33:26 -0400
In-Reply-To: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Rajendra Nayak <rnayak@ti.com>

From: Ambresh K <ambresh@ti.com>

Initialise powerdomains, clockdomains, and hwmod frameworks.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/io.c      |    5 +++++
 arch/arm/mach-omap2/prm44xx.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 542e6bd..09115e7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -667,6 +667,11 @@ void __init dra7xx_init_early(void)
 	omap_prm_base_init();
 	omap_cm_base_init();
 	dra7xx_check_revision();
+	omap44xx_prm_init();
+	dra7xx_powerdomains_init();
+	dra7xx_clockdomains_init();
+	dra7xx_hwmod_init();
+	omap_hwmod_init_postsetup();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 15271b6..03a6034 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -660,7 +660,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
-	if (!cpu_is_omap44xx() && !soc_is_omap54xx())
+	if (!cpu_is_omap44xx() && !soc_is_omap54xx() && !soc_is_dra7xx())
 		return 0;
 
 	return prm_register(&omap44xx_prm_ll_data);
-- 
1.7.9.5

