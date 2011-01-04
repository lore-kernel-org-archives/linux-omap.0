From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2] OMAP2+: fix incorrect computation of autoidle_mask
Date: Tue,  4 Jan 2011 16:33:33 +0530
Message-ID: <1294139013-18737-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab1ADLCw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 06:02:52 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p04B2muX013663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 4 Jan 2011 05:02:51 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Autoidle is a single bit, TIOCP_CFG[0], setting on OMAP1/2/3/4 platforms.
In _set_module_autoidle() I am seeing 0x3 value where the mask is computed.
This should be 0x1.

v2:
(1) Modified the subject.
(2) Modified the description with further specific information.

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Tested Info:
Boot tested on OMAP 1/2/3/4.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
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

