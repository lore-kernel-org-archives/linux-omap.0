From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] RX51: Add support for SDRAM chip select 1
Date: Mon,  8 Jun 2009 15:03:23 +0300
Message-ID: <1244462603-12793-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27363 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZFHMdW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 08:33:22 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n58CWJ2B026964
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2009 07:33:25 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n58CXFGx008783
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2009 15:33:15 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Applies on top of PM branch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/board-rx51.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 3e4b7f8..7ab8a74 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -61,7 +61,11 @@ static struct omap_bluetooth_config rx51_bt_config = {
 
 static void __init rx51_init_irq(void)
 {
-	omap2_init_common_hw(rx51_get_sdram_timings(), NULL,
+	struct omap_sdrc_params *sdrc_params;
+
+	sdrc_params = rx51_get_sdram_timings();
+
+	omap2_init_common_hw(sdrc_params, sdrc_params,
 			     omap3_mpu_rate_table,
 			     omap3_dsp_rate_table,
 			     omap3_l3_rate_table);
-- 
1.5.4.3

