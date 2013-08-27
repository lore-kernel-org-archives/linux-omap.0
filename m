From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] spi/qspi: Add compatible string for am43xx
Date: Tue, 27 Aug 2013 19:12:15 +0530
Message-ID: <1377610935-23703-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47558 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab3H0NpK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Aug 2013 09:45:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@sirena.org.uk
Cc: balbi@ti.com, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>

Add a compatible string for am43xx.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 Documentation/devicetree/bindings/spi/ti_qspi.txt |    2 +-
 drivers/spi/spi-ti-qspi.c                         |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 398ef59..b6ccbfc 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -1,7 +1,7 @@
 TI QSPI controller.
 
 Required properties:
-- compatible : should be "ti,dra7xxx-qspi".
+- compatible : should be "ti,dra7xxx-qspi" or "ti,am43xx-qspi".
 - reg: Should contain QSPI registers location and length.
 - #address-cells, #size-cells : Must be present if the device has sub-nodes
 - ti,hwmods: Name of the hwmod associated to the QSPI
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index d6db561..44dafd9 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -442,6 +442,7 @@ static int ti_qspi_runtime_resume(struct device *dev)
 
 static const struct of_device_id ti_qspi_match[] = {
 	{.compatible = "ti,dra7xxx-qspi" },
+	{.compatible = "ti,am43xx-qspi" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ti_qspi_match);
-- 
1.7.1

