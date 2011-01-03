From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH] OMAP2+: hwmod: incorrect computation of autoidle_mask
Date: Tue,  4 Jan 2011 03:29:51 +0530
Message-ID: <1294091991-2078-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37277 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab1ACJ6D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 04:58:03 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p039vxe4000494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 3 Jan 2011 03:58:02 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Autoidle is just a single bit setting across OMAP platforms.
In _set_module_autoidle() I am seeing 0x3 where the mask is
computed. I believe this should be 0x1.

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Tested Info:
Boot tested on OMAP 2/3/4.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a30658..da49b56 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -373,7 +373,7 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 	}
 
 	autoidle_shift = oh->class->sysc->sysc_fields->autoidle_shift;
-	autoidle_mask = (0x3 << autoidle_shift);
+	autoidle_mask = (0x1 << autoidle_shift);
 
 	*v &= ~autoidle_mask;
 	*v |= autoidle << autoidle_shift;
-- 
1.6.0.4

