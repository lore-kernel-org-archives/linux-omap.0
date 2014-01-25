From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 7/9] ARM: dts: omap3-gta04: Add touchscreen properties.
Date: Sat, 25 Jan 2014 22:29:01 +0100
Message-ID: <1390685343-11663-8-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, neilb@suse.de, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index f72e408..151ed3b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -150,6 +150,16 @@
 			reg = <0x4>;
 		};
 	};
+
+	/* touchscreen */
+	tsc2007@48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
+		ti,x-plate-ohms = <600>;
+	};
 };
 
 &i2c3 {
-- 
1.8.3.2
