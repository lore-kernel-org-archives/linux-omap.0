From: nb6g3dENgvI <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] OMAP4: devices: Do not create dmic device if the dtb has been provided
Date: Wed,  2 May 2012 15:23:18 +0300
Message-ID: <1335961399-18345-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48205 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab2EBMXX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 08:23:23 -0400
Received: by lbbgm6 with SMTP id gm6so378132lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 05:23:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

If dtb is provided the needed device will be created dynamically.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 98cab3a..df2f45a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -702,12 +702,13 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_init_audio();
 	omap_init_mcpdm();
-	omap_init_dmic();
 	omap_init_camera();
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
-	if (!of_have_populated_dt())
+	if (!of_have_populated_dt()) {
+		omap_init_dmic();
 		omap_init_mcspi();
+	}
 	omap_init_pmu();
 	omap_hdq_init();
 	omap_init_sti();
-- 
1.7.8.6

