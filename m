From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2 v3] twl4030-madc driver
Date: Mon, 28 Feb 2011 11:35:27 +0530
Message-ID: <1298873127-5582-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43555 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab1B1GGJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:06:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com
Cc: mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, j-keerthy@ti.com, linux-omap@vger.kernel.org

MADC(Monitoring ADC) driver enables monitoring analog signals using
analog-to-digital conversion (ADC) on the input source.
The previous discussion concluded in keeping the generic ADC
functionality and the hwmon separate. The discussion can be found here:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html

Keerthy (2):
  hwmon: twl4030: Hwmon Driver for TWL4030 MADC
  mfd: twl4030: Driver for twl4030 madc module

 Documentation/hwmon/twl4030-madc-hwmon |   45 ++
 drivers/hwmon/Kconfig                  |   10 +
 drivers/hwmon/Makefile                 |    1 +
 drivers/hwmon/twl4030-madc-hwmon.c     |  153 ++++++
 drivers/mfd/Kconfig                    |   10 +
 drivers/mfd/Makefile                   |    1 +
 drivers/mfd/twl4030-madc.c             |  813 ++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h       |  142 ++++++
 8 files changed, 1175 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/twl4030-madc-hwmon
 create mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
 create mode 100644 drivers/mfd/twl4030-madc.c
 create mode 100644 include/linux/i2c/twl4030-madc.h

