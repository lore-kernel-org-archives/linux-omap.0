From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH RFC 6/7] ARM: dts: OMAP: Add an GPMC node for OMAP3
Date: Sat,  9 Feb 2013 21:44:30 +0100
Message-ID: <1360442671-15216-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40100 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab3BIUpE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 15:45:04 -0500
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

This patch adds a General-Purpose Memory Controller (GPMC)
device node to be used for OMAP3 based SoC boards.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 6c63118..38b52b3 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -403,5 +403,16 @@
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
+
+		gpmc: gpmc@6e000000 {
+		        compatible = "ti,omap3430-gpmc";
+			ti,hwmods = "gpmc";
+			reg = <0x6e000000 0x1000000>;
+			interrupts = <20>; /* M_IRQ_20 interrupt */
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <4>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
 	};
 };
-- 
1.7.7.6

