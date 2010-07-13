From: Thara Gopinath <thara@ti.com>
Subject: [PM-OPP][PATCH 1/4] OMAP: Fix the compilation warning in the opp layer
Date: Tue, 13 Jul 2010 11:17:03 +0530
Message-ID: <1279000026-24042-2-git-send-email-thara@ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55454 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab0GMFrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jul 2010 01:47:24 -0400
In-Reply-To: <1279000026-24042-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, b-cousson@ti.com, sawant@ti.com, vishwanath.bs@ti.com, premi@ti.com, Thara Gopinath <thara@ti.com>

Fix the following warning from the opp layer during
compilation.
arch/arm/plat-omap/opp.c: In function 'opp_enable':
arch/arm/plat-omap/opp.c:405: warning: unused variable 'dev_opp'

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/opp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 0273497..a06b88d 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -402,8 +402,6 @@ int opp_add(const struct omap_opp_def *opp_def)
  */
 int opp_enable(struct omap_opp *opp)
 {
-	struct device_opp *dev_opp;
-
 	if (unlikely(!opp || IS_ERR(opp))) {
 		pr_err("%s: Invalid parameters being passed\n", __func__);
 		return -EINVAL;
-- 
1.7.0.rc1.33.g07cf0f

