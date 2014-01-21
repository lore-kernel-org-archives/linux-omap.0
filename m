From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 22/41] ARM: omap2.dtsi: add omapdss information
Date: Tue, 21 Jan 2014 12:56:54 +0200
Message-ID: <1390301833-24944-23-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34920 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbaAULAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 06:00:31 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT data for OMAP2 display subsystem, which contains the following
blocks:

dss - the wrapper/glue for the display modules
dispc - display controller
rfbi - MIPI DBI encoder
venc - analog TV encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index d0c5b37e248c..af3531cc4576 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -271,5 +271,36 @@
 			ti,hwmods = "timer12";
 			ti,timer-pwm;
 		};
+
+		dss: dss@48050000 {
+			compatible = "ti,omap2-dss", "simple-bus";
+			reg = <0x48050000 0x400>;
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@48050400 {
+				compatible = "ti,omap2-dispc";
+				reg = <0x48050400 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			rfbi: encoder@48050800 {
+				compatible = "ti,omap2-rfbi";
+				reg = <0x48050800 0x400>;
+				status = "disabled";
+				ti,hwmods = "dss_rfbi";
+			};
+
+			venc: encoder@48050c00 {
+				compatible = "ti,omap2-venc";
+				reg = <0x48050c00 0x400>;
+				status = "disabled";
+				ti,hwmods = "dss_venc";
+			};
+		};
 	};
 };
-- 
1.8.3.2

