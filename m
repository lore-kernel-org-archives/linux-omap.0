From: Aneesh V <aneesh@ti.com>
Subject: [RFC v3 PATCH 2/3] dt: device tree bindings for TI's EMIF sdram controller
Date: Thu, 19 Jan 2012 20:02:00 +0530
Message-ID: <1326983521-373-3-git-send-email-aneesh@ti.com>
References: <1326983521-373-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38102 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752721Ab2ASOc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 09:32:28 -0500
Received: by mail-yw0-f50.google.com with SMTP id o22so67448yho.23
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 06:32:27 -0800 (PST)
In-Reply-To: <1326983521-373-1-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aneesh V <aneesh@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Olof Johansson <olof@lixom.net>

EMIF - External Memory Interface - is an SDRAM controller used in
TI SoCs. EMIF supports, based on the IP revision, one or more of
DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
of the EMIF IP and memory parts attached to it.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Aneesh V <aneesh@ti.com>
---
Changes in RFC v3:
* Fixed review comments from RFC v2
---
 .../bindings/memory-controllers/ti/emif.txt        |   49 ++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
new file mode 100644
index 0000000..2925add
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -0,0 +1,49 @@
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
1.7.1

