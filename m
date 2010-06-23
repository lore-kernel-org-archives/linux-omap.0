From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 8/9] omap: introduce omap24xx generic features
Date: Tue, 22 Jun 2010 21:16:14 -0500
Message-ID: <1277259375-18521-9-git-send-email-nm@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45674 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab0FWCQW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 22:16:22 -0400
In-Reply-To: <1277259375-18521-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

introduce generic features for omap2. omap2 uses mbx, not sgx, and
it still has a dsp, though not iva2 as omap3 uses..

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/id.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e3f5994..fe634dd 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -102,6 +102,16 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
+static void __init omap24xx_check_features(void)
+{
+	/*
+	 * TODO: add a better check feature once we have
+	 * more decent feature check
+	 */
+	omap_features |= OMAP_HAS_L2CACHE |
+		OMAP_HAS_IVA;
+}
+
 static void __init omap24xx_check_revision(void)
 {
 	int i, j;
@@ -388,6 +398,7 @@ void __init omap2_check_revision(void)
 	 */
 	if (cpu_is_omap24xx()) {
 		omap24xx_check_revision();
+		omap24xx_check_features();
 	} else if (cpu_is_omap34xx()) {
 		omap3_check_revision();
 		omap3_check_features();
-- 
1.6.3.3

