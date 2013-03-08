From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 06/17] ARM: OMAP2+: Convert NAND to use gpmc_cs_program_settings()
Date: Fri, 8 Mar 2013 10:58:27 -0600
Message-ID: <1362761918-8696-7-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60081 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934352Ab3CHQ7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 11:59:21 -0500
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

Convert the OMAP2+ NAND code to use the gpmc_cs_program_settings()
function for configuring the various GPMC options instead of directly
programming the CONFIG1 register.

This moves the configuration of some GPMC options outside the
nand_gpmc_retime() because these options should only need to be set once
regardless of whether the gpmc timing is changing dynamically at runtime.
The programming of where the wait-pin is also moved slightly, but this
will not have any impact to existing devices as no boards are currently
setting the dev_ready variable.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |   33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index e50e438..1c57755 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -74,14 +74,6 @@ static int omap2_nand_gpmc_retime(
 	t.cs_wr_off = gpmc_t->cs_wr_off;
 	t.wr_cycle = gpmc_t->wr_cycle;
 
-	/* Configure GPMC */
-	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 1);
-	else
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 0);
-	gpmc_cs_configure(gpmc_nand_data->cs,
-			GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NAND);
-	gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_WP, 0);
 	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
 	if (err)
 		return err;
@@ -115,6 +107,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		   struct gpmc_timings *gpmc_t)
 {
 	int err	= 0;
+	struct gpmc_settings s;
 	struct device *dev = &gpmc_nand_device.dev;
 
 	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
@@ -141,11 +134,27 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 			dev_err(dev, "Unable to set gpmc timings: %d\n", err);
 			return err;
 		}
-	}
 
-	/* Enable RD PIN Monitoring Reg */
-	if (gpmc_nand_data->dev_ready) {
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_RDY_BSY, 1);
+		s.device_nand = true;
+
+		/* Enable RD PIN Monitoring Reg */
+		if (gpmc_nand_data->dev_ready) {
+			s.wait_on_read = true;
+			s.wait_on_write = true;
+		}
+
+		if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
+			s.device_width = GPMC_DEVWIDTH_16BIT;
+		else
+			s.device_width = GPMC_DEVWIDTH_8BIT;
+
+		err = gpmc_cs_program_settings(gpmc_nand_data->cs, &s);
+		if (IS_ERR_VALUE(err))
+			goto out_free_cs;
+
+		err = gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_WP, 0);
+		if (IS_ERR_VALUE(err))
+			goto out_free_cs;
 	}
 
 	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
-- 
1.7.10.4

