From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH] ARM: OMAP2+: gpmc: enable wait-pin monitoring for NAND devices via DT
Date: Sat, 17 May 2014 00:37:56 +0530
Message-ID: <1400267276-16001-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992443AbaEPTIV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 15:08:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Pekon Gupta <pekon@ti.com>

This patch enables 'wait-pin' monitoring in NAND driver if following properties
are present under NAND DT node
	gpmc,wait-pin = <wait-pin number>
	gpmc,wait-on-read;
	gpmc,wait-on-write;
As NAND generic framework uses common path nand_chip->dev_ready() for monitoring
completion of Read and Write status, so wait-pin monitoring is enabled only when
both 'gpmc,wait-on-read' and 'gpmc,wait-on-write' are specified.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 4349e82..7dc742d 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -123,11 +123,13 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		}
 	}
 
-	if (gpmc_nand_data->of_node)
+	if (gpmc_nand_data->of_node) {
 		gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
-	else
+		if (s.wait_on_read && s.wait_on_write)
+			gpmc_nand_data->dev_ready = "true";
+	} else {
 		gpmc_set_legacy(gpmc_nand_data, &s);
-
+	}
 	s.device_nand = true;
 
 	err = gpmc_cs_program_settings(gpmc_nand_data->cs, &s);
-- 
1.8.5.1.163.gd7aced9

