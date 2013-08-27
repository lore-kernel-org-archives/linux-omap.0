From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2] spi/qspi: Add compatible string for am4372.
Date: Tue, 27 Aug 2013 19:42:24 +0530
Message-ID: <1377612744-24779-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56546 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab3H0OPG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Aug 2013 10:15:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@sirena.org.uk
Cc: balbi@ti.com, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>

Add a compatible string for am4372.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2:
Instead of am43xx, use exact part number.
 Documentation/devicetree/bindings/spi/ti_qspi.txt |    2 +-
 drivers/spi/spi-ti-qspi.c                         |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 398ef59..1f9641a 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -1,7 +1,7 @@
 TI QSPI controller.
 
 Required properties:
-- compatible : should be "ti,dra7xxx-qspi".
+- compatible : should be "ti,dra7xxx-qspi" or "ti,am4372-qspi".
 - reg: Should contain QSPI registers location and length.
 - #address-cells, #size-cells : Must be present if the device has sub-nodes
 - ti,hwmods: Name of the hwmod associated to the QSPI
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index d6db561..93245aa 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -442,6 +442,7 @@ static int ti_qspi_runtime_resume(struct device *dev)
 
 static const struct of_device_id ti_qspi_match[] = {
 	{.compatible = "ti,dra7xxx-qspi" },
+	{.compatible = "ti,am4372-qspi" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ti_qspi_match);
-- 
1.7.1

