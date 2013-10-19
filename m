From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v10 04/10] mtd: nand: omap: fix device scan: NAND_CMD_READID, NAND_CMD_RESET, CMD_CMD_PARAM use only x8 bus
Date: Sat, 19 Oct 2013 14:14:08 +0530
Message-ID: <1382172254-12448-5-git-send-email-pekon@ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52864 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab3JSIpb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Oct 2013 04:45:31 -0400
In-Reply-To: <1382172254-12448-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

As per comments below, NAND_CMD_RESET, NAND_CMD_READID, and NAND_CMD_PARAM would
work only in x8 mode.
    commit 64b37b2a63eb2f80b65c7185f0013f8ffc637ae3
    Author:     Matthieu CASTET <matthieu.castet@parrot.com>
    AuthorDate: 2012-11-06
    Note that nand_scan_ident send command (NAND_CMD_RESET, NAND_CMD_READID, NAND_CMD_PARAM), address and read data
    The ONFI specificication is not very clear for x16 device if high byte of address should be driven to 0,
    but according to [1] it should be ok to not drive it during autodetection.

    [1]
    3.3.2. Target Initialization

    [...]
    The Read ID and Read Parameter Page commands only use the lower 8-bits of the data bus.
    The host shall not issue commands that use a word data width on x16 devices until the host
    determines the device supports a 16-bit data bus width in the parameter page.

Thus this patch run nand_scan_ident() with driver configured as x8 device.
Once the NAND device is detected, and its ONFI params are read, the driver
is re-configured based on device-width as passed by DT bindinig 'nand-bus-width'

In-case there is a mis-match between the DT binding 'nand-bus-width' and actual
device-width detected during nand_get_flash_type() then probe returns failure.

All other low-level callback updates happen after the device detection.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5596368..d29edda 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1856,7 +1856,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	mtd->name		= dev_name(&pdev->dev);
 	mtd->owner		= THIS_MODULE;
 	nand_chip		= &info->nand;
-	nand_chip->options	= pdata->devsize;
 	nand_chip->options	|= NAND_SKIP_BBTSCAN;
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	info->of_node		= pdata->of_node;
@@ -1904,6 +1903,39 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->chip_delay = 50;
 	}
 
+	/* scan NAND device connected to chip controller */
+	/* configure driver in x8 mode to read ONFI parameter page, as
+	 * NAND_CMD_READID & NAND_CMD_PARAM may not work in x16 mode */
+	nand_chip->options &= ~NAND_BUSWIDTH_16;
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		/* nand_scan_ident failed */
+		if (pdata->devsize) {
+			/* may be because of mis-match of device-width,
+			 * platform data (DT binding) also says its x16 device
+			 * So re-scan with proper device-width */
+			nand_chip->options |= pdata->devsize;
+			if (nand_scan_ident(mtd, 1, NULL)) {
+				err = -ENXIO;
+				goto out_release_mem_region;
+			}
+		} else {
+			/* some genuine failure, because even platform-data
+			 * (DT binding) says that bus-width is x8 */
+			err = -ENXIO;
+			goto out_release_mem_region;
+		}
+	} else {
+		/* nand_scan_ident passed with x8 mode */
+		if (pdata->devsize) {
+			/* but platform-data (DT binding) say its x16 device */
+			pr_err("%s: incorrect bus-width config\n", DRIVER_NAME);
+			err = -EINVAL;
+			err = -ENXIO;
+			goto out_release_mem_region;
+		}
+	}
+
+	/* re-populate low-level callbacks based on xfer modes */
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
 		nand_chip->read_buf   = omap_read_buf_pref;
@@ -2011,17 +2043,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* DIP switches on some boards change between 8 and 16 bit
-	 * bus widths for flash.  Try the other width if the first try fails.
-	 */
-	if (nand_scan_ident(mtd, 1, NULL)) {
-		nand_chip->options ^= NAND_BUSWIDTH_16;
-		if (nand_scan_ident(mtd, 1, NULL)) {
-			err = -ENXIO;
-			goto out_release_mem_region;
-		}
-	}
-
 	/* rom code layout */
 	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
 
-- 
1.8.1

