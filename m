From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 13/17] ARM: OMAP2+: Convert NAND to retrieve GPMC settings from DT
Date: Fri, 8 Mar 2013 10:58:34 -0600
Message-ID: <1362761918-8696-14-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60120 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933812Ab3CHQ7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 11:59:37 -0500
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
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
index d673155..260915a 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -135,12 +135,16 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
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

