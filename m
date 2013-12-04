From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Wed, 4 Dec 2013 14:28:40 +0200
Message-ID: <1386160133-24026-14-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33415 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932232Ab3LDMaS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Dec 2013 07:30:18 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f3a0c26ed0c2..6fc163201cbd 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -588,5 +588,48 @@
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
1.8.3.2

