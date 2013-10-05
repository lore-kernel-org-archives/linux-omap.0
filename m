From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 3/3] ARM: dts: omap3-igep0020: use standard constant for IRQ flags
Date: Sat,  5 Oct 2013 02:04:39 +0200
Message-ID: <1380931479-16142-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39052 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab3JEAFb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Oct 2013 20:05:31 -0400
In-Reply-To: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Commit 840ef8b7 ("ARM: dt: add header to define IRQ flags") added
constants for IRQ edge/level triggered types so use it instead of
a magic number to enhance the DT readability.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 180b186..64884fa 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -175,7 +175,7 @@
 		gpmc,cycle2cycle-diffcsen;
 
 		interrupt-parent = <&gpio6>;
-		interrupts = <16 8>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
 		vmmc-supply = <&vddvario>;
 		vmmc_aux-supply = <&vdd33a>;
 		reg-io-width = <4>;
-- 
1.8.4.rc3

