From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] OMAP2+: OPP: allow OPP enumeration to continue if device is not present
Date: Fri, 16 Mar 2012 11:19:09 -0500
Message-ID: <1331914749-23171-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47833 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965185Ab2CPQTU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 12:19:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Steve Sakoman <steve@sakoman.com>, Maximilian Schwerin <mvs@tigris.de>, Nishanth Menon <nm@ti.com>

On platforms such as OMAP3, certain variants may not have IVA, SGX
or some specific component. We currently have a check to aid fixing
wrong population of OPP entries for issues such as typos. This however
causes a conflict with valid requirement where the SoC variant does
not actually have the module present.

So, reduce the severity of the print to a debug statement and skip
registering that specific OPP, but continue down the list.

Reported-by: Steve Sakoman <steve@sakoman.com>
Reported-by: Maximilian Schwerin <mvs@tigris.de>
Acked-by: Steve Sakoman <steve@sakoman.com>
Tested-by: Maximilian Schwerin <mvs@tigris.de>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Discussion: http://marc.info/?t=133174689300002&r=1&w=2
 arch/arm/mach-omap2/opp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 9262a6b..de6d464 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -64,10 +64,10 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 		}
 		oh = omap_hwmod_lookup(opp_def->hwmod_name);
 		if (!oh || !oh->od) {
-			pr_warn("%s: no hwmod or odev for %s, [%d] "
+			pr_debug("%s: no hwmod or odev for %s, [%d] "
 				"cannot add OPPs.\n", __func__,
 				opp_def->hwmod_name, i);
-			return -EINVAL;
+			continue;
 		}
 		dev = &oh->od->pdev->dev;
 
-- 
1.7.0.4

