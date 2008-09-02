From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/2] twl4030-usb patches
Date: Tue,  2 Sep 2008 15:31:50 +0300
Message-ID: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47253 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYIBMcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 08:32:33 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m82CWFCI003021
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 15:32:30 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

The following patches convert twl4030-usb to a platform_device
in order to set the usb mode via platform_data and get
rid of the Kconfig entry for that.

Later, we add a sysfs entry for reporting the vbus events
coming from triton, this let's us tell the userspace we
have a usb connection (vbus is on) and trigger an application
or something else.

Felipe Balbi (2):
  i2c: twl4030-usb: move to platform_device
  i2c: twl4030-usb: add 'vbus' sysfs file

 arch/arm/mach-omap2/usb-musb.c  |   19 ++
 drivers/i2c/chips/Kconfig       |   16 -
 drivers/i2c/chips/twl4030-usb.c |  593 +++++++++++++--------------------------
 include/linux/i2c/twl4030-usb.h |  256 +++++++++++++++++
 4 files changed, 467 insertions(+), 417 deletions(-)
 create mode 100644 include/linux/i2c/twl4030-usb.h

