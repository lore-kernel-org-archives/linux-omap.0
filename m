From: Maximilian Schwerin <mvs@tigris.de>
Subject: [PATCH] omap: opp: test for iva before attempting to set iva opp
Date: Wed, 14 Mar 2012 14:48:32 +0100
Message-ID: <1331732912-16771-1-git-send-email-mvs@tigris.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:55776 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab2CNOLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 10:11:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Maximilian Schwerin <mvs@tigris.de>

From: Steve Sakoman <steve@sakoman.com>

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

