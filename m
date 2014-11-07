From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: OMAP2+: gpmc: Get rid of "ti,elm-id not found" warning
Date: Fri, 7 Nov 2014 14:26:59 +0200
Message-ID: <1415363219-25644-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47094 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbaKGM1L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Nov 2014 07:27:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: ezequiel@vanguardiasur.com.ar, linux-omap@vger.kernel.org, pekon@pek-sem.com, Roger Quadros <rogerq@ti.com>

OMAP3 and lower SoCs don't have the ELM module so this warning
is annoying. Get rid of it.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 104bc2c..2334235 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1394,8 +1394,6 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 	if (gpmc_nand_data->elm_of_node == NULL)
 		gpmc_nand_data->elm_of_node =
 					of_parse_phandle(child, "elm_id", 0);
-	if (gpmc_nand_data->elm_of_node == NULL)
-		pr_warn("%s: ti,elm-id property not found\n", __func__);
 
 	/* select ecc-scheme for NAND */
 	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
-- 
1.8.3.2

