From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 3/3] ARM: dts: omap3-igep0020: use standard constant for IRQ flags
Date: Mon,  7 Oct 2013 11:55:40 +0200
Message-ID: <1381139740-13495-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1381139740-13495-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40493 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035Ab3JGJ4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 05:56:46 -0400
In-Reply-To: <1381139740-13495-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Commit 840ef8b7 ("ARM: dt: add header to define IRQ flags") added
constants for IRQ edge/level triggered types so use it instead of
a magic number to enhance the DT readability.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1:
 - None

 arch/arm/boot/dts/omap3-igep0020.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 35346f2..750ce84 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -199,7 +199,7 @@
 		gpmc,cycle2cycle-diffcsen;
 
 		interrupt-parent = <&gpio6>;
-		interrupts = <16 8>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
 		vmmc-supply = <&vddvario>;
 		vmmc_aux-supply = <&vdd33a>;
 		reg-io-width = <4>;
-- 
1.8.4.rc3

