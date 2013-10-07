From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 1/3] ARM: dts: omap3-igep: Add USB OTG support
Date: Mon,  7 Oct 2013 17:12:23 +0200
Message-ID: <1381158745-9557-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1381158745-9557-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40670 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab3JGPN0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 11:13:26 -0400
In-Reply-To: <1381158745-9557-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Commit ad871c10b ("ARM: dts: OMAP: Add usb_otg and glue data to O
added USB OTG support for most OMAP boards but some OMAP3 boards
such as IGEP boards were not updated. This patch adds an USB OTG
device node to these board.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---

Changes since v2:
 - Add phys and phy-names properties as required by the new
   generic PHY framework; suggested by Roger Quadros

Changes since v1:
 - Add USB OTG support for both IGEPv2 and IGEP COM and not only to IGEPv2 

 arch/arm/boot/dts/omap3-igep.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 0f92224..ba1e58b 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -143,3 +143,12 @@
 &twl_gpio {
 	ti,use-leds;
 };
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
+	mode = <3>;
+	power = <50>;
+};
-- 
1.8.4.rc3

