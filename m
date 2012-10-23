From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 5/6] ARM: OMAP: SmartReflex: use pr_warn instead of pr_warning
Date: Tue, 23 Oct 2012 16:44:00 -0500
Message-ID: <1351028641-20832-6-git-send-email-nm@ti.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37327 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab2JWVoH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 17:44:07 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NLi6Pw012585
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NLi6dK028659
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
In-Reply-To: <1351028641-20832-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>

Minor cleanup to use the preferred pr_warn

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 201e219..75a505a 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -18,8 +18,8 @@ static int sr_class3_enable(struct omap_sr *sr)
 	unsigned long volt = voltdm_get_voltage(sr->voltdm);
 
 	if (!volt) {
-		pr_warning("%s: Curr voltage unknown. Cannot enable %s\n",
-				__func__, sr->name);
+		pr_warn("%s: Curr voltage unknown. Cannot enable %s\n",
+			__func__, sr->name);
 		return -ENODATA;
 	}
 	if (!sr->soc_ops.vp_enable) {
-- 
1.7.9.5

