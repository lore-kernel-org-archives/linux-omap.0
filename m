From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP3: hwmod: check for clkdomain pointer before accesing it to change the sleep dependencies.
Date: Sun,  6 Dec 2009 16:48:43 +0530
Message-ID: <1260098323-26183-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39526 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933664AbZLFLSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Dec 2009 06:18:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>

Some clock nodes like wdt1_fck, sr1_fck, sr2_fck etc do not have a
clock domain associated . For such nodes accessing the clock domain pointers 
in _add_initiator_dep and _del_initiator_dep, will lead to null pointer
defreferencing crash. Adding support in these functions to check for
existence of clkdm pointer before trying to acess it. Even if tomorrow
we correct all the clock nodes to have an associated clock domain, checking
for the existence of the pointer is a good programming practice.

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
This patch depends on http://patchwork.kernel.org/patch/63383/

 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 18e6478..3edc387 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -314,8 +314,10 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 	if (!oh->_clk)
 		return -EINVAL;
 
-	return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
+	if (oh->_clk->clkdm)
+		return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
 				  init_oh->_clk->clkdm->pwrdm.ptr);
+	return 0;
 }
 
 /**
@@ -335,8 +337,10 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 	if (!oh->_clk)
 		return -EINVAL;
 
-	return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
+	if (oh->_clk->clkdm)
+		return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
 				  init_oh->_clk->clkdm->pwrdm.ptr);
+	return 0;
 }
 
 /**
-- 
1.5.4.7

