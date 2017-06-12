From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/4] ARM: dts: tps65217: Add power button interrupt to the common tps65217.dtsi file
Date: Mon, 12 Jun 2017 23:24:10 +0200
Message-ID: <20170612212412.22719-2-enric.balletbo@collabora.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612212412.22719-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, grygorii.strashko@ti.com, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

The interrupt for power button is static data that comes from the
datasheet, there is no reason to need to define this value on every
board so seams reasonable put this information into the common tps65217
file.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 -
 arch/arm/boot/dts/am335x-chiliboard.dts   | 1 -
 arch/arm/boot/dts/tps65217.dtsi           | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bfa4258..89daaeb 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -323,7 +323,6 @@
 	};
 
 	pwrbutton {
-		interrupts = <2>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index 5c25f3a..59431b2 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -195,7 +195,6 @@
 	};
 
 	pwrbutton {
-		interrupts = <2>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 1973159..399baaa 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -25,6 +25,7 @@
 
 	pwrbutton {
 		compatible = "ti,tps65217-pwrbutton";
+		interrupts = <2>;
 		status = "disabled";
 	};
 
-- 
2.9.3
