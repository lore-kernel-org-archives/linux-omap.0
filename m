From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 13/14] ARM: OMAP2+: Convert NAND to retrieve GPMC settings from DT
Date: Tue, 26 Feb 2013 11:30:40 -0600
Message-ID: <1361899842-30303-14-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36755 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab3BZRbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Feb 2013 12:31:21 -0500
In-Reply-To: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Jon Hunter <jon-hunter@ti.com>

When booting with device-tree, retrieve GPMC settings for NAND from
the device-tree blob. This will allow us to remove all static settings
stored in the gpmc-nand.c in the future once the migration to
device-tree is complete.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index a4c8537..e3d4b72 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -137,8 +137,11 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 			return err;
 		}
 
-		/* Enable RD PIN Monitoring Reg */
-		if (gpmc_nand_data->dev_ready) {
+		if (gpmc_nand_data->of_node) {
+			gpmc_read_settings_dt(gpmc_nand_data->of_node,
+					      &nand_settings);
+		} else if (gpmc_nand_data->dev_ready) {
+			/* Enable RD PIN Monitoring Reg */
 			nand_settings.wait_on_read = true;
 			nand_settings.wait_on_write = true;
 		}
-- 
1.7.10.4

