From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v5 2/3] ARM: dts: twl4030: Add missing madc reference for bci subnode
Date: Sun, 21 May 2017 12:38:17 +0200
Message-ID: <69d95172f257cee8d6abc1eaab57865e536be73c.1495363097.git.hns@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1495363097.git.hns@goldelico.com>
In-Reply-To: <cover.1495363097.git.hns@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Marek Belisko <marek@goldelico.com>

The twl4030_charger driver expects an iio channel to detect the
presence of an AC charger by looking at VAC (madc channel 11).
This definition is missing in the device tree.

Signed-off-by: Marek Belisko <marek@goldelico.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/twl4030.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 36ae9160b558..16533b62b0a2 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -23,6 +23,8 @@
 		compatible = "ti,twl4030-bci";
 		interrupts = <9>, <2>;
 		bci3v1-supply = <&vusb3v1>;
+		io-channels = <&twl_madc 11>;
+		io-channel-names = "vac";
 	};
 
 	watchdog {
-- 
2.12.2
