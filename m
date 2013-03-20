From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH 1/2] ARM: dts: OMAP4+: Add DMM bindings
Date: Tue, 19 Mar 2013 23:43:43 -0500
Message-ID: <1363754624-5209-2-git-send-email-andy.gross@ti.com>
References: <1363754624-5209-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47594 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab3CTEoP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 00:44:15 -0400
In-Reply-To: <1363754624-5209-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <bicousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, devicetree-discuss@lists.ozlabs.org, Nishanth Menon <nm@ti.com>, Andy Gross <andy.gross@ti.com>

Add DMM bindings for OMAP4 and OMAP5 devices.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    7 +++++++
 arch/arm/boot/dts/omap5.dtsi |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index ddfc54a..749fe83 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -624,5 +624,12 @@
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
index b760c11..c2d2ecc 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -650,5 +650,12 @@
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

