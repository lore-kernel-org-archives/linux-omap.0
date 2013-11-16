From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 09/11] ARM: dts: AM33XX IGEP0033: add USB support.
Date: Sat, 16 Nov 2013 14:23:42 +0100
Message-ID: <1384608224-9452-10-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60383 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab3KPNZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:25:04 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add node to support the USB Host and the USB OTG on the IGEP AQUILA
Processor Board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/am335x-igep0033.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 6196244..7063311 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -199,6 +199,35 @@
 	pinctrl-0 = <&uart0_pins>;
 };
 
+&usb {
+	status = "okay";
+
+	control@44e10000 {
+		status = "okay";
+	};
+
+	usb-phy@47401300 {
+		status = "okay";
+	};
+
+	usb-phy@47401b00 {
+		status = "okay";
+	};
+
+	usb@47401000 {
+		status = "okay";
+	};
+
+	usb@47401800 {
+		status = "okay";
+		dr_mode = "host";
+	};
+
+	dma-controller@07402000  {
+		status = "okay";
+	};
+};
+
 #include "tps65910.dtsi"
 
 &tps {
-- 
1.8.4.2

