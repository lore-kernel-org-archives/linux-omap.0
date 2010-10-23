From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv3 3/3] omap3: IGEP v2: Improve igep2_flash_init() function.
Date: Sat, 23 Oct 2010 18:49:00 +0200
Message-ID: <1287852540-4951-4-git-send-email-eballetbo@gmail.com>
References: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55329 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482Ab0JWQtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 12:49:15 -0400
Received: by wwe15 with SMTP id 15so2035080wwe.1
        for <linux-omap@vger.kernel.org>; Sat, 23 Oct 2010 09:49:14 -0700 (PDT)
In-Reply-To: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

The changes are:
  - Use 'for' loop instead 'while' loop.
  - No need to initialize ret to 0, we're assigning it right after.
  - No need to check for onenandcs < GPMC_CS_NUM here, it will always be true.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 42dcbf4..fe76b59 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -152,35 +152,34 @@ static struct platform_device igep2_onenand_device = {
 
 static void __init igep2_flash_init(void)
 {
-	u8		cs = 0;
-	u8		onenandcs = GPMC_CS_NUM + 1;
+	u8 cs = 0;
+	u8 onenandcs = GPMC_CS_NUM + 1;
 
-	while (cs < GPMC_CS_NUM) {
-		u32 ret = 0;
+	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
+		u32 ret;
 		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
 
 		/* Check if NAND/oneNAND is configured */
 		if ((ret & 0xC00) == 0x800)
 			/* NAND found */
-			pr_err("IGEP v2: Unsupported NAND found\n");
+			pr_err("IGEP2: Unsupported NAND found\n");
 		else {
 			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
 			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
 				/* ONENAND found */
 				onenandcs = cs;
 		}
-		cs++;
 	}
+
 	if (onenandcs > GPMC_CS_NUM) {
-		pr_err("IGEP v2: Unable to find configuration in GPMC\n");
+		pr_err("IGEP2: Unable to find configuration in GPMC\n");
 		return;
 	}
 
-	if (onenandcs < GPMC_CS_NUM) {
-		igep2_onenand_data.cs = onenandcs;
-		if (platform_device_register(&igep2_onenand_device) < 0)
-			pr_err("IGEP v2: Unable to register OneNAND device\n");
-	}
+	igep2_onenand_data.cs = onenandcs;
+
+	if (platform_device_register(&igep2_onenand_device) < 0)
+		pr_err("IGEP2: Unable to register OneNAND device\n");
 }
 
 #else
-- 
1.7.1

