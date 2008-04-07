From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] I2C: TWL4030: Kconfig and Makefile changes
Date: Mon, 7 Apr 2008 17:17:46 +0300
Message-ID: <20080407141746.GF7338@gandalf.research.nokia.com>
References: <1207569316-7053-1-git-send-email-felipe.balbi@nokia.com> <1207569316-7053-2-git-send-email-felipe.balbi@nokia.com> <1207569316-7053-3-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30910 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYDGOTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 10:19:08 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m37EJ3Za019564
	for <linux-omap@vger.kernel.org>; Mon, 7 Apr 2008 17:19:05 +0300
Content-Disposition: inline
In-Reply-To: <1207569316-7053-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Mon, Apr 07, 2008 at 02:55:16PM +0300, Felipe Balbi wrote:
> From: Mikko Ylinen <mikko.k.ylinen@nokia.com>

There was a missing space which was causing some troubles.
Updated below:

>From 163455c541b37fb38a0ea112796591c95c4ef3aa Mon Sep 17 00:00:00 2001
From: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Date: Wed, 2 Apr 2008 20:55:31 +0300
Subject: [PATCH 2/2] I2C: TWL4030: Kconfig and Makefile changes

Put madc driver into kbuild.

Signed-off-by: Mikko Ylinen <mikko.k.ylinen@nokia.com>

Updated help text on Kconfig for TWL4030 MADC driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig  |   21 +++++++++++++++++++++
 drivers/i2c/chips/Makefile |    1 +
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index bfab098..86869e2 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -128,6 +128,27 @@ config TWL4030_GPIO
 	bool "TWL4030 GPIO Driver"
 	depends on TWL4030_CORE
 
+config TWL4030_MADC
+	tristate "TWL4030 MADC Driver"
+	depends on TWL4030_CORE
+	help
+	  The TWL4030 Monitoring ADC driver enables the host
+	  processor to monitor analog signals using analog-to-digital
+	  conversions on the input source. TWL4030 MADC provides the
+	  following features:
+	   - Single 10-bit ADC with successive approximation register (SAR) conversion;
+	   - Analog multiplexer for 16 inputs;
+	   - Seven (of the 16) inputs are freely available;
+	   - Battery voltage monitoring;
+	   - Concurrent conversion request management;
+	   - Interrupt signal to Primary Interrupt Handler;
+	   - Averaging feature;
+	   - Selective enable/disable of the averaging feature.
+
+	  Say 'y' here to statically link this module into the kernel or 'm'
+	  to build it as a dinamically loadable module. The module will be
+	  called twl4030-madc.ko
+
 config TWL4030_USB
 	bool "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 255fbb1..6431675 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o
 obj-$(CONFIG_TWL4030_GPIO)	+= twl4030-gpio.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
+obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
-- 
1.5.5.rc3



-- 
	- Balbi
