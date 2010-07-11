From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 1/2] omap: sram: fix is_sram_locked check
Date: Sun, 11 Jul 2010 01:41:53 -0500
Message-ID: <1278830514-27734-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51317 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab0GKGkd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Jul 2010 02:40:33 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6B6eWXQ009145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 11 Jul 2010 01:40:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

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

Not fixing the omap_type() check for OMAP4 since Santosh suggests there is
a clean 44xx register definition change coming that would fix the issue

 arch/arm/plat-omap/sram.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 226b2e8..2eb5a27 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -93,16 +93,11 @@ extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
  */
 static int is_sram_locked(void)
 {
-	int type = 0;
-
 	if (cpu_is_omap44xx())
 		/* Not yet supported */
 		return 0;
 
-	if (cpu_is_omap242x())
-		type = omap_rev() & OMAP2_DEVICETYPE_MASK;
-
-	if (type == GP_DEVICE) {
+	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
 			__raw_writel(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-vects */
-- 
1.6.6.1

