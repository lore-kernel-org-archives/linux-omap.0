From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 3/4] ARM: dts: omap3-tobi: Correct polarity for GPIO LED
Date: Tue, 11 Jun 2013 16:49:48 +0200
Message-ID: <1370962189-9689-4-git-send-email-florian.vaussard@epfl.ch>
References: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:50942 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751720Ab3FKOuE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 10:50:04 -0400
In-Reply-To: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

The LED is active low, not active high.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-tobi.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index dea726f..1458591 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -20,7 +20,7 @@
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "overo:red:gpio21";
-			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
1.7.5.4

