From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 2/7] ARM: dts: omap3-gta04: Add support for magnetometer
Date: Sat,  1 Mar 2014 14:58:49 +0100
Message-ID: <1393682334-26805-3-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, NeilBrown <neilb@suse.de>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neilb@suse.de>

Add magnetometer hmc5843 node.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index d3b253b..d9917b8 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -124,6 +124,12 @@
 			reg = <0x4>;
 		};
 	};
+
+	/* compass aka magnetometer */
+	hmc5843@1e {
+		compatible = "honeywell,hmc5843";
+		reg = <0x1e>;
+	};
 };
 
 &i2c3 {
-- 
1.8.3.2
