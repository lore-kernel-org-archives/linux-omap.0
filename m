From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] omap: update Pandora defconfig
Date: Tue, 10 Nov 2009 19:01:46 -0800
Message-ID: <20091111030146.31793.50839.stgit@localhost>
References: <20091111025907.31793.84134.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56108 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbZKKDBm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 22:01:42 -0500
In-Reply-To: <20091111025907.31793.84134.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

This patch updates defconfig to enable options needed to properly
boot OMAP3 pandora board. It also enables MMC, OTG, GPIO LEDs,
TWL4030 GPIO and sound drivers.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_pandora_defconfig |   49 +++++++++++++++++++++++++++---
 1 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index b54ad2e..150deaf 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -611,7 +611,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-# CONFIG_KEYBOARD_GPIO is not set
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_INPUT_MOUSE=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_MOUSE_SERIAL is not set
@@ -634,7 +634,8 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
 # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
-# CONFIG_INPUT_MISC is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_TWL4030_PWRBUTTON=y
 
 #
 # Hardware I/O ports
@@ -834,7 +835,29 @@ CONFIG_DAB=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_SOUND is not set
+CONFIG_SOUND=y
+CONFIG_SOUND_OSS_CORE=y
+CONFIG_SOUND_OSS_CORE_PRECLAIM=y
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_PCM_OSS_PLUGINS=y
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+CONFIG_SND_VERBOSE_PRINTK=y
+CONFIG_SND_DRIVERS=y
+CONFIG_SND_USB=y
+CONFIG_SND_SOC=y
+CONFIG_SND_OMAP_SOC=y
+CONFIG_SND_OMAP_SOC_MCBSP=y
+CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=y
+CONFIG_SND_SOC_I2C_AND_SPI=y
+CONFIG_SND_SOC_TWL4030=y
+
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
@@ -1020,7 +1043,13 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 # CONFIG_MMC_SPI is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_GPIO_PLATFORM=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -1084,9 +1113,12 @@ CONFIG_RTC_DRV_TWL4030=y
 # on-CPU RTC drivers
 #
 # CONFIG_DMADEVICES is not set
-# CONFIG_REGULATOR is not set
 # CONFIG_UIO is not set
 
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_TWL4030=y
+
 #
 # File systems
 #
@@ -1407,3 +1439,10 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+
+# added by hand for now
+CONFIG_KEYBOARD_TWL4030=y
+CONFIG_USB_OTG_UTILS=y
+CONFIG_TWL4030_USB=y
+CONFIG_MMC_OMAP_HS=y
+

