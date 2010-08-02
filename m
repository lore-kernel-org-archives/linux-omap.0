From: Thara Gopinath <thara@ti.com>
Subject: [PM-OPP][PATCHV2] OMAP: Add check for omap_device pointer before adding an opp
Date: Mon,  2 Aug 2010 13:51:21 +0530
Message-ID: <1280737281-22967-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58703 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab0HBIVd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 04:21:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds the check for whether a omap_device and in turn
platform_device and device pointers exist for the device before
adding it's opp table into the global table. This is because all
the later access to the opp entries are based on dev pointer and
hence there is no point in adding a opp if the dev pointer does
not exist.

Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/opp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 0273497..f3855ba 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -333,8 +333,8 @@ int opp_add(const struct omap_opp_def *opp_def)
 		return -EINVAL;
 	}
 	oh = omap_hwmod_lookup(opp_def->hwmod_name);
-	if (!oh) {
-		pr_warn("%s: no hwmod for %s, cannot add OPPs.\n",
+	if (!oh || !oh->od) {
+		pr_warn("%s: no hwmod or odev for %s, cannot add OPPs.\n",
 			__func__, opp_def->hwmod_name);
 		return -EINVAL;
 	}
-- 
1.7.0.rc1.33.g07cf0f

