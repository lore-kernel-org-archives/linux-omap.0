From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 1/2] ARM: dts: am4372: Add "ti,am437x-ocp2scp" as compatible string for OCP2SCP
Date: Tue, 17 Mar 2015 16:54:50 +0530
Message-ID: <1426591491-3685-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44057 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbCQLZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 07:25:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, kishon@ti.com, nm@ti.com, praneeth@ti.com

Added a new compatible string "ti,am437x-ocp2scp" for OCP2SCP module.
This is needed since except for the OCP2SCP used in AM437x, SYNC2 value
in OCP2SCP TIMING should be changed whereas the default value is sufficient
in AM437x.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/bus/omap-ocp2scp.txt       |    3 ++-
 arch/arm/boot/dts/am4372.dtsi                      |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
index 63dd805..18729f6 100644
--- a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
+++ b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
@@ -1,7 +1,8 @@
 * OMAP OCP2SCP - ocp interface to scp interface
 
 properties:
-- compatible : Should be "ti,omap-ocp2scp"
+- compatible : Should be "ti,am437x-ocp2scp" for AM437x processor
+	       Should be "ti,omap-ocp2scp" for all others
 - reg : Address and length of the register set for the device
 - #address-cells, #size-cells : Must be present if the device has sub-nodes
 - ranges : the child address space are mapped 1:1 onto the parent address space
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 1943fc3..286e317 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -787,7 +787,7 @@
 		};
 
 		ocp2scp0: ocp2scp@483a8000 {
-			compatible = "ti,omap-ocp2scp";
+			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -806,7 +806,7 @@
 		};
 
 		ocp2scp1: ocp2scp@483e8000 {
-			compatible = "ti,omap-ocp2scp";
+			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
1.7.9.5

