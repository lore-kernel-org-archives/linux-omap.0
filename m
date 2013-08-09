From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 11/22] ARM: omap4.dtsi: add omapdss information
Date: Fri, 9 Aug 2013 11:38:56 +0300
Message-ID: <1376037547-10859-12-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55641 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030596Ab3HIIju (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:39:50 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..ab19f16 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -663,5 +663,64 @@
 			ram-bits = <12>;
 			ti,has-mailbox;
 		};
+
+		dss@58000000 {
+			compatible = "ti,omap4-dss", "simple-bus";
+			reg = <0x58000000 0x80>;
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@58001000 {
+				compatible = "ti,omap4-dispc";
+				reg = <0x58001000 0x1000>;
+				interrupts = <0 25 0x4>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			dpi: encoder@0 {
+				compatible = "ti,omap4-dpi";
+			};
+
+			rfbi: encoder@58002000  {
+				compatible = "ti,omap4-rfbi";
+				reg = <0x58002000 0x1000>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+			/*
+			 * Accessing venc registers cause a crash on omap4, so
+			 * this is disabled for now.
+			 */
+			/*
+			venc: encoder@58003000 {
+				compatible = "ti,omap4-venc";
+				reg = <0x58003000 0x1000>;
+				ti,hwmods = "dss_venc";
+			};
+			*/
+
+			dsi1: encoder@58004000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58004000 0x200>;
+				interrupts = <0 53 0x4>;
+				ti,hwmods = "dss_dsi1";
+			};
+
+			dsi2: encoder@58005000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58005000 0x200>;
+				interrupts = <0 84 0x4>;
+				ti,hwmods = "dss_dsi2";
+			};
+
+			hdmi: encoder@58006000 {
+				compatible = "ti,omap4-hdmi";
+				reg = <0x58006000 0x1000>;
+				interrupts = <0 101 0x4>;
+				ti,hwmods = "dss_hdmi";
+			};
+		};
 	};
 };
-- 
1.8.1.2

