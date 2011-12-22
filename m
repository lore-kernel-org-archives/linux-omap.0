From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] OMAP3: hwmod_data: add HWMOD_INIT_NO_RESET flag for dss_dispc
Date: Thu, 22 Dec 2011 02:00:53 +0100
Message-ID: <1324515653-17287-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50067 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab1LVBBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 20:01:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ilya Yanok <yanok@emcraft.com>, Archit Taneja <archit@ti.com>, Paul Walmsley <paul@pwsan.com>

Resetting DISPC when a DISPC output is enabled causes the DSS to go into
an inconsistent state.

commit b923d40dd4211c4ef7d4efa2bd81b7ca1d8744c1
Author: Archit Taneja <archit@ti.com>
Date:   Thu Oct 6 18:04:08 2011 -0600

    ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is
enabled in bootloader

tries to deal with this problem by checking if display is enabled and
disabling it before doing reset.

But in my setup dss_dispc is resetted from omap_hwmod_setup_all function
_before_ calling omap_dss_reset. So when dispc_disable_outputs is
executed dispc is already reset and nothing happens.

This patch and HWMOD_INIT_NO_RESET flags to dss_dispc hwmod thus leaving
DISPC untouched so that omap_dss_reset can take care of it.

This solves the l3_app_irq BUG problem on my AM3517 based board.

CC: Archit Taneja <archit@ti.com>
CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5324e8d..226b365 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1515,7 +1515,7 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 	},
 	.slaves		= omap3xxx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dispc_slaves),
-	.flags		= HWMOD_NO_IDLEST,
+	.flags		= HWMOD_NO_IDLEST | HWMOD_INIT_NO_RESET,
 	.dev_attr	= &omap2_3_dss_dispc_dev_attr
 };
 
-- 
1.7.6.4

