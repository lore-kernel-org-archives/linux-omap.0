From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 03/17] spi/qspi: parse register by name.
Date: Tue, 26 Nov 2013 13:04:59 +0530
Message-ID: <1385451313-1875-4-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59116 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404Ab3KZHgB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 02:36:01 -0500
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com, broonie@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, Sourav Poddar <sourav.poddar@ti.com>

Modify the qspi driver to parse reg information by name.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 033ef8d..67aa905 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -465,7 +465,11 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->master = master;
 	qspi->dev = &pdev->dev;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
+	if (r == NULL) {
+		dev_err(&pdev->dev, "missing platform resources data\n");
+		return -ENODEV;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-- 
1.7.1

