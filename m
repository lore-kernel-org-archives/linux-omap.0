From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] Revert "OMAP3: SRAM size fix for HS/EMU devices"
Date: Wed, 17 Jun 2009 17:00:05 -0700
Message-ID: <1245283206-6568-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:43116 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZFRAAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 20:00:06 -0400
Received: by pzk30 with SMTP id 30so163194pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 17:00:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This reverts commit bea1418bd09e30961e36f96f97979a3603f1da9b.
---
 arch/arm/plat-omap/sram.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)
 mode change 100755 => 100644 arch/arm/plat-omap/sram.c

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
old mode 100755
new mode 100644
index f40bd2d..65006df
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -131,15 +131,9 @@ void __init omap_detect_sram(void)
 	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
 			if (cpu_is_omap34xx()) {
-				if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
-					omap_sram_base = OMAP3_SRAM_PUB_VA;
-					omap_sram_start = OMAP3_SRAM_PUB_PA;
-					omap_sram_size = 0x8000; /* 32K */
-				} else {
-					omap_sram_base = OMAP3_SRAM_PUB_VA;
-					omap_sram_start = OMAP3_SRAM_PUB_PA;
-					omap_sram_size = 0x7000; /* 28K */
-				}
+				omap_sram_base = OMAP3_SRAM_PUB_VA;
+				omap_sram_start = OMAP3_SRAM_PUB_PA;
+				omap_sram_size = 0x8000; /* 32K */
 			} else {
 				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
-- 
1.6.3.2

