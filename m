From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 13/18] ARM: OMAP2+: Convert NAND to retrieve GPMC settings from DT
Date: Fri, 15 Mar 2013 10:21:11 -0500
Message-ID: <1363360876-13617-14-git-send-email-jon-hunter@ti.com>
References: <1363360876-13617-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59428 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab3COPWL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 11:22:11 -0400
In-Reply-To: <1363360876-13617-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

When booting with device-tree, retrieve GPMC settings for NAND from
the device-tree blob. This will allow us to remove all static settings
stored in the gpmc-nand.c in the future once the migration to
device-tree is complete.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 12e9753..d9c2719 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -137,12 +137,16 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 			return err;
 		}
 
-		s.device_nand = true;
-
-		/* Enable RD PIN Monitoring Reg */
-		if (gpmc_nand_data->dev_ready) {
-			s.wait_on_read = true;
-			s.wait_on_write = true;
+		if (gpmc_nand_data->of_node) {
+			gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
+		} else {
+			s.device_nand = true;
+
+			/* Enable RD PIN Monitoring Reg */
+			if (gpmc_nand_data->dev_ready) {
+				s.wait_on_read = true;
+				s.wait_on_write = true;
+			}
 		}
 
 		if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
-- 
1.7.10.4

