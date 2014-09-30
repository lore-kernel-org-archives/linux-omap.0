From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 3/3] arm: dts: omap3-gta04: Extend touchscreen configs
Date: Tue, 30 Sep 2014 22:17:34 +0200
Message-ID: <1412108254-19234-4-git-send-email-marek@goldelico.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412108254-19234-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com
Cc: hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Adding min/max values for various touschscreen properties.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fd34f91..2dafac3b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -284,6 +284,12 @@
 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <600>;
+		ti,min-x = <0x100>;
+		ti,max-x = <0xf00>;
+		ti,min-y = <0xf00>;
+		ti,max-y = <0x100>;
+		ti,min-rt = <0xfff>;
+		ti,max-rt = <0>;
 	};
 };
 
-- 
1.9.3
