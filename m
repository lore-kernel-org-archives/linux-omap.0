From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 2/6] HS/EMU OMAP3 SRAM size fix
Date: Tue, 14 Oct 2008 15:23:27 +0300
Message-ID: <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33545 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbYJNKh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 06:37:56 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EAbqEX006342
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:54 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9EAbjLu000373
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:48 +0300
In-Reply-To: <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/sram.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/sram.c

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
old mode 100644
new mode 100755
index 9cfb77f..f0ac426
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -125,9 +125,15 @@ void __init omap_detect_sram(void)
 	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
 			if (cpu_is_omap34xx()) {
-				omap_sram_base = OMAP3_SRAM_PUB_VA;
-				omap_sram_start = OMAP3_SRAM_PUB_PA;
-				omap_sram_size = 0x8000; /* 32K */
+				if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
+					omap_sram_base = OMAP3_SRAM_PUB_VA;
+					omap_sram_start = OMAP3_SRAM_PUB_PA;
+					omap_sram_size = 0x8000; /* 32K */
+				} else {
+					omap_sram_base = OMAP3_SRAM_PUB_VA;
+					omap_sram_start = OMAP3_SRAM_PUB_PA;
+					omap_sram_size = 0x7000; /* 28K */
+				}
 			} else {
 				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
-- 
1.5.4.3

