From: y@india.ti.com
Subject: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
Date: Mon,  5 Oct 2009 16:52:41 +0530
Message-ID: <33146.1767004386$1254742218@news.gmane.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42107 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbZJELXW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Oct 2009 07:23:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n95BMgJi003807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 5 Oct 2009 06:22:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

From: Shweta Gulati <shweta.gulati@ti.com>

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a9eda25..38f4781 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -140,6 +140,12 @@ static void omap3_core_save_context(void)
 	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
 	control_padconf_off |= START_PADCONF_SAVE;
 	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
+	/* Due to Silicon Bug on context restore it is found
+	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
+	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
+	 * for 300us for scm to finish saving task
+	 */
+	udelay(300);
 	/* wait for the save to complete */
 	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
 			& PADCONF_SAVE_DONE)
-- 
1.5.4.7

