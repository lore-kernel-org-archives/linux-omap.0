From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RESEND] [PATCH 3.0] OMAP: drop __initdata tags from static struct platform_device declarations
Date: Fri, 17 Jun 2011 03:18:31 +0200
Message-ID: <201106170318.32326.jkrzyszt@tis.icnet.pl>
References: <201106170002.46387.jkrzyszt@tis.icnet.pl> <20110616221832.GB9698@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:55536 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab1FQBTk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 21:19:40 -0400
In-Reply-To: <20110616221832.GB9698@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "Varadarajan, Charulatha" <charu@ti.com>

Pointers to statically declared platform device structures which are 
registered with platform_device_register() are then used during run time 
to access these structure members, for example from platform_uevent() 
and much more. Therefore, these structures should never be placed inside 
sections which are dropped after boot. Fix platform devices incorrectly 
tagged with __initdata which happen to exist inside OMAP sub-trees.

This bug has exhibited itself on my ARM/OMAP1 based Amstrad Delta 
videophone after commit 6d3163ce86dd386b4f7bda80241d7fea2bc0bb1d, "mm: 
check if any page in a pageblock is reserved before marking it 
MIGRATE_RESERVE", resulting in reading from several 
/sys/device/platform/*/uevent files always ending up with segmentation 
faults.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Acked-by: Felipe Balbi <balbi@ti.com>
Cc: Varadarajan, Charulatha <charu@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
---
On Fri 17 Jun 2011 at 00:18:32 CET Russell King - ARM Linux wrote:
> It would be a good idea to cc the authors of the patches which
> introduced this stuff, so that they learn that registering platform
> devices marked with __initdata is a bad idea.  We live in hope that
> doing so will prevent it happening in the future.

Resending with Cc: as requested.

Thanks,
Janusz

 arch/arm/mach-omap1/board-ams-delta.c        |    8 ++++----
 arch/arm/mach-omap1/gpio15xx.c               |    4 ++--
 arch/arm/mach-omap1/gpio16xx.c               |   10 +++++-----
 arch/arm/mach-omap1/gpio7xx.c                |   14 +++++++-------
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

--- git/arch/arm/mach-omap1/board-ams-delta.c.orig	2011-06-15 15:31:36.000000000 +0200
+++ git/arch/arm/mach-omap1/board-ams-delta.c	2011-06-16 22:36:49.000000000 +0200
@@ -215,7 +215,7 @@ static struct omap_kp_platform_data ams_
 	.delay		= 9,
 };
 
-static struct platform_device ams_delta_kp_device __initdata = {
+static struct platform_device ams_delta_kp_device = {
 	.name		= "omap-keypad",
 	.id		= -1,
 	.dev		= {
@@ -225,12 +225,12 @@ static struct platform_device ams_delta_
 	.resource	= ams_delta_kp_resources,
 };
 
-static struct platform_device ams_delta_lcd_device __initdata = {
+static struct platform_device ams_delta_lcd_device = {
 	.name	= "lcd_ams_delta",
 	.id	= -1,
 };
 
-static struct platform_device ams_delta_led_device __initdata = {
+static struct platform_device ams_delta_led_device = {
 	.name	= "ams-delta-led",
 	.id	= -1
 };
@@ -267,7 +267,7 @@ static struct soc_camera_link ams_delta_
 	.power		= ams_delta_camera_power,
 };
 
-static struct platform_device ams_delta_camera_device __initdata = {
+static struct platform_device ams_delta_camera_device = {
 	.name   = "soc-camera-pdrv",
 	.id     = 0,
 	.dev    = {
--- git/arch/arm/mach-omap1/gpio7xx.c.orig	2011-06-15 15:31:36.000000000 +0200
+++ git/arch/arm/mach-omap1/gpio7xx.c	2011-06-16 23:18:46.000000000 +0200
@@ -46,7 +46,7 @@ static struct __initdata omap_gpio_platf
 	.bank_stride		= 2,
 };
 
-static struct __initdata platform_device omap7xx_mpu_gpio = {
+static struct platform_device omap7xx_mpu_gpio = {
 	.name           = "omap_gpio",
 	.id             = 0,
 	.dev            = {
@@ -75,7 +75,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 32,
 };
 
-static struct __initdata platform_device omap7xx_gpio1 = {
+static struct platform_device omap7xx_gpio1 = {
 	.name           = "omap_gpio",
 	.id             = 1,
 	.dev            = {
@@ -104,7 +104,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 32,
 };
 
-static struct __initdata platform_device omap7xx_gpio2 = {
+static struct platform_device omap7xx_gpio2 = {
 	.name           = "omap_gpio",
 	.id             = 2,
 	.dev            = {
@@ -133,7 +133,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 32,
 };
 
-static struct __initdata platform_device omap7xx_gpio3 = {
+static struct platform_device omap7xx_gpio3 = {
 	.name           = "omap_gpio",
 	.id             = 3,
 	.dev            = {
@@ -162,7 +162,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 32,
 };
 
-static struct __initdata platform_device omap7xx_gpio4 = {
+static struct platform_device omap7xx_gpio4 = {
 	.name           = "omap_gpio",
 	.id             = 4,
 	.dev            = {
@@ -191,7 +191,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 32,
 };
 
-static struct __initdata platform_device omap7xx_gpio5 = {
+static struct platform_device omap7xx_gpio5 = {
 	.name           = "omap_gpio",
 	.id             = 5,
 	.dev            = {
@@ -220,7 +220,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 32,
 };
 
-static struct __initdata platform_device omap7xx_gpio6 = {
+static struct platform_device omap7xx_gpio6 = {
 	.name           = "omap_gpio",
 	.id             = 6,
 	.dev            = {
--- git/arch/arm/mach-omap1/gpio15xx.c.orig	2011-06-15 15:31:36.000000000 +0200
+++ git/arch/arm/mach-omap1/gpio15xx.c	2011-06-16 23:19:17.000000000 +0200
@@ -41,7 +41,7 @@ static struct __initdata omap_gpio_platf
 	.bank_stride		= 1,
 };
 
-static struct __initdata platform_device omap15xx_mpu_gpio = {
+static struct platform_device omap15xx_mpu_gpio = {
 	.name           = "omap_gpio",
 	.id             = 0,
 	.dev            = {
@@ -70,7 +70,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 16,
 };
 
-static struct __initdata platform_device omap15xx_gpio = {
+static struct platform_device omap15xx_gpio = {
 	.name           = "omap_gpio",
 	.id             = 1,
 	.dev            = {
--- git/arch/arm/mach-omap1/gpio16xx.c.orig	2011-06-15 15:31:36.000000000 +0200
+++ git/arch/arm/mach-omap1/gpio16xx.c	2011-06-16 23:20:30.000000000 +0200
@@ -44,7 +44,7 @@ static struct __initdata omap_gpio_platf
 	.bank_stride		= 1,
 };
 
-static struct __initdata platform_device omap16xx_mpu_gpio = {
+static struct platform_device omap16xx_mpu_gpio = {
 	.name           = "omap_gpio",
 	.id             = 0,
 	.dev            = {
@@ -73,7 +73,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 16,
 };
 
-static struct __initdata platform_device omap16xx_gpio1 = {
+static struct platform_device omap16xx_gpio1 = {
 	.name           = "omap_gpio",
 	.id             = 1,
 	.dev            = {
@@ -102,7 +102,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 16,
 };
 
-static struct __initdata platform_device omap16xx_gpio2 = {
+static struct platform_device omap16xx_gpio2 = {
 	.name           = "omap_gpio",
 	.id             = 2,
 	.dev            = {
@@ -131,7 +131,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 16,
 };
 
-static struct __initdata platform_device omap16xx_gpio3 = {
+static struct platform_device omap16xx_gpio3 = {
 	.name           = "omap_gpio",
 	.id             = 3,
 	.dev            = {
@@ -160,7 +160,7 @@ static struct __initdata omap_gpio_platf
 	.bank_width		= 16,
 };
 
-static struct __initdata platform_device omap16xx_gpio4 = {
+static struct platform_device omap16xx_gpio4 = {
 	.name           = "omap_gpio",
 	.id             = 4,
 	.dev            = {
--- git/arch/arm/mach-omap2/board-rx51-peripherals.c.orig	2011-06-15 15:31:37.000000000 +0200
+++ git/arch/arm/mach-omap2/board-rx51-peripherals.c	2011-06-16 23:21:08.000000000 +0200
@@ -558,7 +558,7 @@ static struct radio_si4713_platform_data
 	.subdev_board_info = &rx51_si4713_board_info,
 };
 
-static struct platform_device rx51_si4713_dev __initdata_or_module = {
+static struct platform_device rx51_si4713_dev = {
 	.name	= "radio-si4713",
 	.id	= -1,
 	.dev	= {
