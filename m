From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/5] dt: emif: device tree bindings for TI's EMIF sdram controller
Date: Mon, 13 Aug 2012 16:30:20 +0530
Message-ID: <1344855623-14879-3-git-send-email-santosh.shilimkar@ti.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56218 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab2HMLAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 07:00:32 -0400
In-Reply-To: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.or, tony@atomide.com, Aneesh V <aneesh@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Aneesh V <aneesh@ti.com>

EMIF - External Memory Interface - is an SDRAM controller used in
TI SoCs. EMIF supports, based on the IP revision, one or more of
DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
of the EMIF IP and memory parts attached to it.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
[santosh.shilimkar@ti.com: Rebased against 3.6-rc]
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../bindings/memory-controllers/ti/emif.txt        |   55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
new file mode 100644
index 0000000..938f8e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -0,0 +1,55 @@
+* EMIF family of TI SDRAM controllers
+
+EMIF - External Memory Interface - is an SDRAM controller used in
+TI SoCs. EMIF supports, based on the IP revision, one or more of
+DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
+of the EMIF IP and memory parts attached to it.
+
+Required properties:
+- compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
+  is the IP revision of the specific EMIF instance.
+
+- phy-type	: <u32> indicating the DDR phy type. Following are the
+  allowed values
+  <1>	: Attila PHY
+  <2>	: Intelli PHY
+
+- device-handle	: phandle to a "lpddr2" node representing the memory part
+
+- ti,hwmods	: For TI hwmods processing and omap device creation
+  the value shall be "emif<n>" where <n> is the number of the EMIF
+  instance with base 1.
+
+Optional properties:
+- cs1-used		: Have this property if CS1 of this EMIF
+  instance has a memory part attached to it. If there is a memory
+  part attached to CS1, it should be the same type as the one on CS0,
+  so there is no need to give the details of this memory part.
+
+- cal-resistor-per-cs	: Have this property if the board has one
+  calibration resistor per chip-select.
+
+- hw-caps-read-idle-ctrl: Have this property if the controller
+  supports read idle window programming
+
+- hw-caps-dll-calib-ctrl: Have this property if the controller
+  supports dll calibration control
+
+- hw-caps-ll-interface	: Have this property if the controller
+  has a low latency interface and corresponding interrupt events
+
+- hw-caps-temp-alert	: Have this property if the controller
+  has capability for generating SDRAM temperature alerts
+
+Example:
+
+emif1: emif@0x4c000000 {
+	compatible	= "ti,emif-4d";
+	ti,hwmods	= "emif2";
+	phy-type	= <1>;
+	device-handle	= <&elpida_ECB240ABACN>;
+	cs1-used;
+	hw-caps-read-idle-ctrl;
+	hw-caps-ll-interface;
+	hw-caps-temp-alert;
+};
-- 
1.7.9.5

