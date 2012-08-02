From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] Revert "spi: omap2-mcspi: convert to module_platform_driver"
Date: Fri,  3 Aug 2012 02:08:37 +0300
Message-ID: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:51555 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab2HBXSc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 19:18:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Cc: balbi@ti.com, tomi.valkeinen@ti.com

This reverts commit 9fdca9dfe093c76fe1ac1a09888ba9679d46996a.

Changing omap2_mcspi_init() from subsys_initcall to device_initcall broke
the display initialization on N900 when all the drivers are compiled
built-in. Display subsystem drivers need a certain initialization order
and having all of them initialize with device_initcall seems to be too
fragile. Without this revert the display init fails and the boot hangs
with the following messages:

[    1.260955] acx565akm spi1.2: invalid display ID
[    1.265899] panel-acx565akm display0: acx_panel_probe panel detect error
[    1.273071] omapdss CORE error: driver probe failed: -19

[...]

[    1.902862] omapfb omapfb: no driver for display: lcd
[    1.908264] omapfb omapfb: cannot find default display

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/spi/spi-omap2-mcspi.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 0c73dd4..8cec17c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1289,5 +1289,18 @@ static struct platform_driver omap2_mcspi_driver = {
 	.remove =	__devexit_p(omap2_mcspi_remove),
 };
 
-module_platform_driver(omap2_mcspi_driver);
+
+static int __init omap2_mcspi_init(void)
+{
+	return platform_driver_register(&omap2_mcspi_driver);
+}
+subsys_initcall(omap2_mcspi_init);
+
+static void __exit omap2_mcspi_exit(void)
+{
+	platform_driver_unregister(&omap2_mcspi_driver);
+
+}
+module_exit(omap2_mcspi_exit);
+
 MODULE_LICENSE("GPL");
-- 
1.7.2.5

