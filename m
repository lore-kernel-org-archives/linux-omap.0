From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 2/2] spi: Force CS to be in inactive state after off-mode
 transition
Date: Wed, 10 Nov 2010 11:32:59 +0100
Message-ID: <4CDA74DB.1060102@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44546 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0KJKnJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 05:43:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-omap <linux-omap@vger.kernel.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>

When SPI wake up from OFF mode, CS is in the wrong state: force it to 
the inactive state.

During the system life, I monitored the CS behavior using a 
oscilloscope. I also activated debug in omap2_mcspi, so I saw when 
driver disable the clocks and restore context when device is not used.
Each time the CS was in the correct state.
It was only when system was put suspend to ram with off-mode activated 
that on resume the CS was in wrong state( ie activated).

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
  drivers/spi/omap2_mcspi.c |   10 ++++++++++
  1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 2a651e6..938f14c 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1139,6 +1139,15 @@ static u8 __initdata spi4_txdma_id[] = {
  };
  #endif
  +/* When SPI wake up, CS is in wrong state: force it to unactive state*/
+static void omap2_mcspi_resume(struct spi_device *spi)
+{
+	omap2_mcspi_enable_clocks( spi_master_get_devdata(spi->master));
+	/* We need to togle CS state for OMAP take this chang in account*/
+	omap2_mcspi_force_cs(spi, 1);
+	omap2_mcspi_force_cs(spi, 0);
+	omap2_mcspi_disable_clocks( spi_master_get_devdata(spi->master));
+}
  static int __init omap2_mcspi_probe(struct platform_device *pdev)
  {
  	struct spi_master	*master;
@@ -1194,6 +1203,7 @@ static int __init omap2_mcspi_probe(struct 
platform_device *pdev)
  	master->transfer = omap2_mcspi_transfer;
  	master->cleanup = omap2_mcspi_cleanup;
  	master->num_chipselect = num_chipselect;
+	master->resume = omap2_mcspi_resume;
   	dev_set_drvdata(&pdev->dev, master);
  -- 1.7.0.4

