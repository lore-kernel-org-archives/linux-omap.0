From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 08/14] omap: sram: fix is_sram_locked check
Date: Fri, 17 Sep 2010 15:17:52 +0530
Message-ID: <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37172 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab0IQJsM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 05:48:12 -0400
In-Reply-To: <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

For OMAP24xx/34xx/44xx: omap_type() returns the correct type:
 OMAP2_DEVICE_TYPE_TEST
 OMAP2_DEVICE_TYPE_EMU
 OMAP2_DEVICE_TYPE_SEC
 OMAP2_DEVICE_TYPE_GP
 OMAP2_DEVICE_TYPE_BAD

In current implementation there are two problems:
Problem 1:
For 34xx, the current if check will never return true.

Problem 2:
For 24xx the correct type check should be with omap_type() function
Verified by checking the TRM 24xx for CONTROL_STATUS register bits

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 10b3b4c..1faaa6e 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -93,16 +93,7 @@ extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
  */
 static int is_sram_locked(void)
 {
-	int type = 0;
-
-	if (cpu_is_omap44xx())
-		/* Not yet supported */
-		return 0;
-
-	if (cpu_is_omap242x())
-		type = omap_rev() & OMAP2_DEVICETYPE_MASK;
-
-	if (type == GP_DEVICE) {
+	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
 			__raw_writel(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */
-- 
1.6.0.4

