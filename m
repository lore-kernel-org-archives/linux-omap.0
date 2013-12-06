From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 08/10] Documentation: bindings: ti-qspi: update binding information.
Date: Fri, 6 Dec 2013 19:54:49 +0530
Message-ID: <1386339891-32717-9-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60051 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab3LFO0D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 09:26:03 -0500
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

These update binding information for ti qspi controller.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2:
 Add 'reg-names' variables used in dts files.

 Documentation/devicetree/bindings/spi/ti_qspi.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 1f9641a..601a360 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -3,6 +3,11 @@ TI QSPI controller.
 Required properties:
 - compatible : should be "ti,dra7xxx-qspi" or "ti,am4372-qspi".
 - reg: Should contain QSPI registers location and length.
+- reg-names: Should contain the resource reg names.
+	- qspi_base: Qspi configuration register Address space
+	- qspi_mmap: Memory mapped Address space
+	- (optional) qspi_ctrlmod: Control module Address space
+- interrupts: should contain the qspi interrupt number.
 - #address-cells, #size-cells : Must be present if the device has sub-nodes
 - ti,hwmods: Name of the hwmod associated to the QSPI
 
@@ -14,7 +19,8 @@ Example:
 
 qspi: qspi@4b300000 {
 	compatible = "ti,dra7xxx-qspi";
-	reg = <0x4b300000 0x100>;
+	reg = <0x47900000 0x100>, <0x30000000 0x3ffffff>;
+	reg-names = "qspi_base", "qspi_mmap";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	spi-max-frequency = <25000000>;
-- 
1.7.1

