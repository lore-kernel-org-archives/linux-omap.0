From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 8/8 v2] omap: introduce omap24xx generic features
Date: Tue,  6 Jul 2010 11:13:21 -0500
Message-ID: <1278432801-28611-1-git-send-email-nm@ti.com>
References: <[PATCH 9/9] omap: id: add feature check for omap1>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36686 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab0GFQN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 12:13:27 -0400
In-Reply-To: <[PATCH 9/9] omap: id: add feature check for omap1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Venkatraman S <svenkatr@ti.com>, Senthil G <svadivu@ti.com>, Nishanth Menon <nm@ti.com>

introduce generic features for omap2. omap2 uses mbx, not sgx, and
it still has a dsp, though not iva2 as omap3 uses..

Signed-off-by: Nishanth Menon <nm@ti.com>
---
V2: comments from http://marc.info/?t=127725956100003&r=1&w=2&n=4
    incorporated - L2 cache is removed from enabled features for omap2.

V1: original patch including L2 cache being set as available feature

 arch/arm/mach-omap2/id.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e3f5994..ab8eb41 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -102,6 +102,15 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
+static void __init omap24xx_check_features(void)
+{
+	/*
+	 * TODO: add a better check feature once we have
+	 * more decent feature check
+	 */
+	omap_features |= OMAP_HAS_IVA;
+}
+
 static void __init omap24xx_check_revision(void)
 {
 	int i, j;
@@ -388,6 +397,7 @@ void __init omap2_check_revision(void)
 	 */
 	if (cpu_is_omap24xx()) {
 		omap24xx_check_revision();
+		omap24xx_check_features();
 	} else if (cpu_is_omap34xx()) {
 		omap3_check_revision();
 		omap3_check_features();
-- 
1.6.3.3

