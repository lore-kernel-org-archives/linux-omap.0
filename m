From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] twl4030-madc driver
Date: Thu, 16 Sep 2010 11:04:24 +0530
Message-ID: <1284615264-31789-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41420 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab0IPFel (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 01:34:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khali@linux-fr.org
Cc: j-keerthy@ti.com, balajitk@ti.com

MADC(Monitoring ADC) driver enables monitoring analog signals using 
analog-to-digital conversion (ADC) on the input source. The MADC driver
is being added under the Hwmon class of drivers. 
To get the context, the last set of comments can be found here:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19981.html

Several people have contributed to this driver on the linux-omap list.

Keerthy (2):
  hwmon: twl4030: Driver for twl4030 madc module
  Makefile and Kconfig changes for twl4030-madc driver

 arch/arm/mach-omap2/Kconfig      |    4 +
 drivers/hwmon/Kconfig            |    4 +
 drivers/hwmon/Makefile           |    1 +
 drivers/hwmon/twl4030-madc.c     |  584 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h |  118 ++++++++
 5 files changed, 711 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/twl4030-madc.c
 create mode 100644 include/linux/i2c/twl4030-madc.h

