From: Thara Gopinath <thara@ti.com>
Subject: [PM-OPP][PATCH] OMAP: Add check for omap_device pointer before adding an opp
Date: Sat, 24 Jul 2010 12:12:33 +0530
Message-ID: <1279953753-1377-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45099 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab0GXGmq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Jul 2010 02:42:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds the check for whether a omap_device and in turn
platform_device and device pointers exist for the device before
adding it's opp table into the global table. This is because all
the later accesses to the opp entries are based on dev pointer and
hence there is no point in adding a opp if the dev pointer does
not exist.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/opp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 0273497..e81bb95 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -333,7 +333,7 @@ int opp_add(const struct omap_opp_def *opp_def)
 		return -EINVAL;
 	}
 	oh = omap_hwmod_lookup(opp_def->hwmod_name);
-	if (!oh) {
+	if (!oh || !oh->od) {
 		pr_warn("%s: no hwmod for %s, cannot add OPPs.\n",
 			__func__, opp_def->hwmod_name);
 		return -EINVAL;
-- 
1.7.0.rc1.33.g07cf0f

