From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH v2 1/2] ARM: dts: OMAP4+: Add DMM bindings
Date: Wed, 10 Apr 2013 15:50:42 -0500
Message-ID: <1365627043-11846-2-git-send-email-andy.gross@ti.com>
References: <1365627043-11846-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42431 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933904Ab3DJUvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 16:51:05 -0400
In-Reply-To: <1365627043-11846-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Andy Gross <andy.gross@ti.com>

Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 devices.
Add documentation for the DMM bindings.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/dmm.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |    7 +++++++
 3 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Documentation/devicetree/bindings/arm/omap/dmm.txt
new file mode 100644
index 0000000..5fd1134
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
@@ -0,0 +1,16 @@
+OMAP Dynamic Memory Manager (DMM) bindings
+
+Required properties:
+- compatible:	Must be "ti,dmm" for OMAP processors containing DMM block
+- reg:		Contains timer register address range (base address and length)
+- interrupts:	Contains interrupt information (source, etc) for the DMM IRQ
+- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
+		"dmm"
+
+Example:
+
+dmm: dmm@4e000000 {
+	compatible = "ti,dmm";
+	reg = <0x4e000000 0x800>;
+	ti,hwmods = "dmm";
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..53951e9 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -660,5 +660,12 @@
 			ram-bits = <12>;
 			ti,has-mailbox;
 		};
+
+		dmm: dmm@4e000000 {
+			compatible = "ti,dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3dd7ff8..e77af8d 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -667,5 +667,12 @@
 				ctrl-module = <&omap_control_usb>;
 			};
 		};
+
+		dmm: dmm@4e000000 {
+			compatible = "ti,dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
 	};
 };
-- 
1.7.5.4

