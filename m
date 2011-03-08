From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] OMAP2+: hwmod: fix incorrect computation of autoidle_mask
Date: Mon, 07 Mar 2011 22:44:28 -0700
Message-ID: <20110308054425.1309.54087.stgit@twilight.localdomain>
References: <20110308054315.1309.10538.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60569 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab1CHFp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 00:45:26 -0500
In-Reply-To: <20110308054315.1309.10538.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Tarun Kanti DebBarma <tarun.kanti@ti.com>

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
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e89a58..9b4f6cd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -373,7 +373,7 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 	}
 
 	autoidle_shift = oh->class->sysc->sysc_fields->autoidle_shift;
-	autoidle_mask = (0x3 << autoidle_shift);
+	autoidle_mask = (0x1 << autoidle_shift);
 
 	*v &= ~autoidle_mask;
 	*v |= autoidle << autoidle_shift;


