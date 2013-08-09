From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 10/22] ARM: omap3.dtsi: add omapdss information
Date: Fri, 9 Aug 2013 11:38:55 +0300
Message-ID: <1376037547-10859-11-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48260 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030596Ab3HIIjs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:39:48 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7d95cda..3308b3f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -532,5 +532,48 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 		};
+
+		dss@48050000 {
+			compatible = "ti,omap3-dss", "simple-bus";
+			reg = <0x48050000 0x200>;
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@48050400 {
+				compatible = "ti,omap3-dispc";
+				reg = <0x48050400 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			dpi: encoder@0 {
+				compatible = "ti,omap3-dpi";
+			};
+
+			sdi: encoder@1 {
+				compatible = "ti,omap3-sdi";
+			};
+
+			dsi: encoder@4804fc00 {
+				compatible = "ti,omap3-dsi";
+				reg = <0x4804fc00 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dsi1";
+			};
+
+			rfbi: encoder@48050800 {
+				compatible = "ti,omap3-rfbi";
+				reg = <0x48050800 0x100>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+			venc: encoder@48050c00 {
+				compatible = "ti,omap3-venc";
+				reg = <0x48050c00 0x100>;
+				ti,hwmods = "dss_venc";
+			};
+		};
 	};
 };
-- 
1.8.1.2

