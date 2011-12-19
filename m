From: Aneesh V <aneesh@ti.com>
Subject: [RFC v2 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram controller
Date: Mon, 19 Dec 2011 19:35:32 +0530
Message-ID: <1324303533-17458-3-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60232 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab1LSOF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 09:05:59 -0500
Received: by mail-yx0-f171.google.com with SMTP id r9so4267896yen.16
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 06:05:57 -0800 (PST)
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

EMIF - External Memory Interface - is an SDRAM controller used in
TI SoCs. EMIF supports, based on the IP revision, one or more of
DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
of the EMIF IP and memory parts attached to it.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
---
 .../bindings/memory-controllers/ti/emif.txt        |   64 ++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
new file mode 100644
index 0000000..e2f687b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -0,0 +1,64 @@
+* EMIF family of TI SDRAM controllers
+
+EMIF - External Memory Interface - is an SDRAM controller used in
+TI SoCs. EMIF supports, based on the IP revision, one or more of
+DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
+of the EMIF IP and memory parts attached to it.
+
+Required properties:
+- compatible	: One or more of "ti,emif-ddr2", "ti,emif-ddr3", and
+  "ti,emif-lpddr2"
+
+  "ti,emif-ddr2" should be listed of the EMIF controller on this SoC
+  supports DDR2 memories
+
+  "ti,emif-ddr3" should be listed of the EMIF controller on this SoC
+  supports DDR3 memories
+
+  "ti,emif-lpddr2" should be listed of the EMIF controller on this SoC
+  supports LPDDR2 memories
+
+- ti,hwmods	: For TI hwmods processing and omap device creation
+  the value shall be "emif<n>" where <n> is the number of the EMIF
+  instance with base 1.
+
+- phy-type	: string indicating the phy type. Should be one of the
+  following:
+
+  "phy-type-omap4"  : PHY used in OMAP4 family of SoCs
+
+  "phy-type-dm81xx" : PHY used in DM81XX family of SoCs
+
+- ddr-handle	: phandle to a "ddr" node representing the memory part
+  attached to this EMIF instance.
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
+- hw-caps-ll-interface	: Have this property if the controller
+  has a low latency interface and corresponding interrupt events
+
+- hw-caps-temp-alert	: Have this property if the controller
+  has capability for generating SDRAM temperature alerts
+
+Example:
+
+emif1: emif@0x4c000000 {
+	compatible	= "ti,emif-lpddr2";
+	ti,hwmods	= "emif2";
+	phy-type	= "phy-type-omap4";
+	ddr-handle	= <&elpida_ECB240ABACN>;
+	cs1-used;
+	hw-caps-read-idle-ctrl;
+	hw-caps-ll-interface;
+	hw-caps-temp-alert;
+};
-- 
1.7.1

