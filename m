From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 2/9] ARM: dts: omap3-gta04: Add bma180 accelerometer.
Date: Sat, 25 Jan 2014 22:28:56 +0100
Message-ID: <1390685343-11663-3-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, neilb@suse.de, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neilb@suse.de>

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 9d37184..e315675 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -94,6 +94,14 @@
 		reg = <0x77>;
 	};
 
+	/* accelerometer */
+	bma180@41 {
+		compatible = "bosch,bma180";
+		reg = <0x41>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	/* leds */
 	tca6507@45 {
 		compatible = "ti,tca6507";
-- 
1.8.3.2
