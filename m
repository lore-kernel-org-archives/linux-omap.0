From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] twl4030-madc driver
Date: Wed, 16 Feb 2011 18:25:57 +0530
Message-ID: <1297860957-9982-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab1BPM5A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 07:57:00 -0500
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
  mfd: twl4030: Driver for twl4030 madc module
  hwmon: twl4030: Hwmon Driver for TWL4030 MADC

 Documentation/hwmon/twl4030-madc-hwmon |   45 ++
 drivers/hwmon/Kconfig                  |   10 +
 drivers/hwmon/Makefile                 |    1 +
 drivers/hwmon/twl4030-madc-hwmon.c     |  155 +++++++
 drivers/mfd/Kconfig                    |   10 +
 drivers/mfd/Makefile                   |    1 +
 drivers/mfd/twl4030-madc.c             |  723 ++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h       |  132 ++++++
 8 files changed, 1077 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/twl4030-madc-hwmon
 create mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
 create mode 100644 drivers/mfd/twl4030-madc.c
 create mode 100644 include/linux/i2c/twl4030-madc.h

