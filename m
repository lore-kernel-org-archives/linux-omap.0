From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2] omap4: fix omap_type() function
Date: Sun, 11 Jul 2010 02:00:32 -0500
Message-ID: <1278831632-28658-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35763 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0GKG7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jul 2010 02:59:10 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6B6xAxB001433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 11 Jul 2010 01:59:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Following patch added the omap_type() functionality for omap4
	737daa03: omap4: Fix omap_type() for omap4

However the omap_type() function would not work as:
1) the base address for CONTROL_STATUS register is wrong
So insted of using omap_ctrl_readl that has a different base offset,
use a correct offset using omap_readl

2) "Not yet supported" check for omap4 needs to be removed

Verified on OMAP4 SDP board

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Shilimkar, Santosh <santosh.shilimkar@ti.com>
---

V1: had broken mmc support
V2: No mmc break; use omap_readl to get to the right register

 arch/arm/mach-omap2/id.c  |    2 +-
 arch/arm/plat-omap/sram.c |    4 ----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..6d47f91 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -58,7 +58,7 @@ int omap_type(void)
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP44XX_CONTROL_STATUS);
+		val = omap_readl(OMAP443X_SCM_BASE + OMAP44XX_CONTROL_STATUS);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a72b391..98c86ff 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -93,10 +93,6 @@ extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
  */
 static int is_sram_locked(void)
 {
-	if (cpu_is_omap44xx())
-		/* Not yet supported */
-		return 0;
-
 	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
-- 
1.6.6.1

