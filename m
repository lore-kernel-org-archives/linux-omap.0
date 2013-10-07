From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 1/3] ARM: dts: omap3-igep: Add USB OTG support
Date: Mon,  7 Oct 2013 11:55:38 +0200
Message-ID: <1381139740-13495-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1381139740-13495-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40486 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab3JGJ4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 05:56:43 -0400
In-Reply-To: <1381139740-13495-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Commit ad871c10b ("ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards")
added USB OTG support for most OMAP boards but some OMAP3 boards
such as IGEP boards were not updated. This patch adds an USB OTG
device node to these board.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---

Changes since v1:
 - Add USB OTG support for both IGEPv2 and IGEP COM and not only to IGEPv2

 arch/arm/boot/dts/omap3-igep.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 0f92224..4e2eda2 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -143,3 +143,10 @@
 &twl_gpio {
 	ti,use-leds;
 };
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	mode = <3>;
+	power = <50>;
+};
-- 
1.8.4.rc3

