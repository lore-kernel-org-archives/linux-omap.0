From: Maximilian Schwerin <mvs@tigris.de>
Subject: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to add IVA OPP
Date: Wed, 14 Mar 2012 18:38:15 +0100
Message-ID: <1331746695-24372-1-git-send-email-mvs@tigris.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:43198 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab2CNRjF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 13:39:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Steve Sakoman <steve@sakoman.com>, Maximilian Schwerin <mvs@tigris.de>

From: Steve Sakoman <steve@sakoman.com>

Don't try to add IVA OPPs for OMAP3 versions not containing an IVA
subsystem, as this would make omap_init_opp_table fail.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
---
 arch/arm/mach-omap2/opp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 9262a6b..414f2ec 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 				__func__, i);
 			return -EINVAL;
 		}
+
+		if ((strcmp(opp_def->hwmod_name,"iva") == 0) && !omap3_has_iva())
+			continue;
+
 		oh = omap_hwmod_lookup(opp_def->hwmod_name);
 		if (!oh || !oh->od) {
 			pr_warn("%s: no hwmod or odev for %s, [%d] "
-- 
1.7.0.4

