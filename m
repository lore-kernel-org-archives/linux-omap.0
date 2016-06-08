From: Stephan Linz <linz@li-pro.net>
Subject: [PATCH v3 4/7] arm: use the new LED disk activity trigger
Date: Thu,  9 Jun 2016 00:29:39 +0200
Message-ID: <20160608223000.433-4-linz@li-pro.net>
References: <20160608223000.433-1-linz@li-pro.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608223000.433-1-linz@li-pro.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

- dts: rename 'ide-disk' to 'disk-activity'
- platform: rename 'ide-disk' to 'disk-activity'
- defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'

Signed-off-by: Stephan Linz <linz@li-pro.net>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts  | 2 +-
 arch/arm/boot/dts/kirkwood-ns2lite.dts   | 2 +-
 arch/arm/boot/dts/kirkwood-topkick.dts   | 2 +-
 arch/arm/configs/collie_defconfig        | 2 +-
 arch/arm/configs/ixp4xx_defconfig        | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c | 2 +-
 arch/arm/mach-omap1/board-osk.c          | 2 +-
 arch/arm/mach-pxa/spitz.c                | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 81d6c30..c4d04c5 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -86,7 +86,7 @@
 		led@3 {
 			label = "beagle-x15:usr3";
 			gpios = <&gpio7 15 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "ide-disk";
+			linux,default-trigger = "disk-activity";
 			default-state = "off";
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-ns2lite.dts b/arch/arm/boot/dts/kirkwood-ns2lite.dts
index 1f2ca60..2c661ad 100644
--- a/arch/arm/boot/dts/kirkwood-ns2lite.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2lite.dts
@@ -26,7 +26,7 @@
 		blue-sata {
 			label = "ns2:blue:sata";
 			gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "ide-disk";
+			linux,default-trigger = "disk-activity";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index f5c8c0d..1e9a721 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -129,7 +129,7 @@
 		disk {
 			label = "topkick:yellow:disk";
 			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "ide-disk";
+			linux,default-trigger = "disk-activity";
 		};
 		system2 {
 			label = "topkick:red:system";
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 6c56ad0..52dbad5 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -76,7 +76,7 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_LOCOMO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 24636cf..cf4918a 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -180,7 +180,7 @@ CONFIG_LEDS_FSG=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_ISL1208=y
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 68cc099..ab47b8e 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -288,7 +288,7 @@ static struct gpio_led evm_leds[] = {
 	{ .name = "DS2", .active_low = 1,
 		.default_trigger = "mmc0", },
 	{ .name = "DS1", .active_low = 1,
-		.default_trigger = "ide-disk", },
+		.default_trigger = "disk-activity", },
 };
 
 static const struct gpio_led_platform_data evm_led_data = {
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 209aecb..4dfb995 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -172,7 +172,7 @@ static struct gpio_led tps_leds[] = {
 	 * Also, D9 requires non-battery power.
 	 */
 	{ .gpio = OSK_TPS_GPIO_LED_D9, .name = "d9",
-			.default_trigger = "ide-disk", },
+			.default_trigger = "disk-activity", },
 	{ .gpio = OSK_TPS_GPIO_LED_D2, .name = "d2", },
 	{ .gpio = OSK_TPS_GPIO_LED_D3, .name = "d3", .active_low = 1,
 			.default_trigger = "heartbeat", },
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index bd7cd8b..1080580 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -464,7 +464,7 @@ static struct gpio_led spitz_gpio_leds[] = {
 	},
 	{
 		.name			= "spitz:green:hddactivity",
-		.default_trigger	= "ide-disk",
+		.default_trigger	= "disk-activity",
 		.gpio			= SPITZ_GPIO_LED_GREEN,
 	},
 };
-- 
2.8.4
