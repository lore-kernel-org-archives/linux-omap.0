From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 12/12] ARM: OMAP4: hwmod: update context lost counter logic for hwmods without context reg
Date: Thu, 19 Jul 2012 16:26:32 +0300
Message-ID: <1342704392-23657-13-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56333 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab2GSN10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:27:26 -0400
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org

With this patch, the hwmods that don't have context register, will now
increment their context lost counter always unless they belong to an
always on powerdomain which never loses context. The always on pwrdm
type is checked by looking at the the powerdomain registered for the
hwmod, and seeing if it only has ON within its valid powerstates.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3ebf93e..daf5322 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1802,9 +1802,28 @@ static void _reconfigure_io_chain(void)
 static void _omap4_update_context_lost(struct omap_hwmod *oh)
 {
 	u32 r;
+	struct powerdomain *pwrdm;
+
+	/* Special handling if we have not defined context register */
+	if (oh->prcm.omap4.context_offs == USHRT_MAX) {
+		/* Get powerdomain pointer for this hwmod */
+		if (oh->clkdm)
+			pwrdm = oh->clkdm->pwrdm.ptr;
+		else
+			pwrdm = NULL;
 
-	if (oh->prcm.omap4.context_offs == USHRT_MAX)
+		/*
+		 * If our powerdomain is of 'always on' type (i.e.
+		 * available powerstates == PWRSTS_ON), don't increment
+		 * context lost and return
+		 */
+		if (pwrdm && pwrdm->pwrsts == PWRSTS_ON)
+			return;
+
+		/* Otherwise, increase context lost counter and return */
+		oh->prcm.omap4.context_lost_counter++;
 		return;
+	}
 
 	r = omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
 					oh->clkdm->pwrdm.ptr->prcm_offs,
-- 
1.7.4.1

