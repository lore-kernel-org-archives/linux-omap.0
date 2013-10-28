From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 2/3] omap2: gpmc: Introduce gpmc_set_legacy()
Date: Sun, 27 Oct 2013 21:51:47 -0300
Message-ID: <1382921508-5104-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59916 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755304Ab3J1AwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Oct 2013 20:52:04 -0400
In-Reply-To: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Pekon Gupta <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, Jon Hunter <jgchunter@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Introduce a helper function to complete the setting of some GPMC
parameters, only used when the gpmc is probed from a board file.
As such, it will go away once the DT conversion is completed.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index d66b856..9dd40e7 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -65,6 +65,17 @@ static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 	return 1;
 }
 
+/* This function will go away once the device-tree convertion is complete */
+static void gpmc_set_legacy(struct omap_nand_platform_data *gpmc_nand_data,
+			    struct gpmc_settings *s)
+{
+	/* Enable RD PIN Monitoring Reg */
+	if (gpmc_nand_data->dev_ready) {
+		s->wait_on_read = true;
+		s->wait_on_write = true;
+	}
+}
+
 int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		   struct gpmc_timings *gpmc_t)
 {
@@ -100,15 +111,10 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		}
 	}
 
-	if (gpmc_nand_data->of_node) {
+	if (gpmc_nand_data->of_node)
 		gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
-	} else {
-		/* Enable RD PIN Monitoring Reg */
-		if (gpmc_nand_data->dev_ready) {
-			s.wait_on_read = true;
-			s.wait_on_write = true;
-		}
-	}
+	else
+		gpmc_set_legacy(gpmc_nand_data, &s);
 
 	s.device_nand = true;
 
-- 
1.8.1.5

