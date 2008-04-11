From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/2] sparse warnings
Date: Fri, 11 Apr 2008 13:59:15 +0300
Message-ID: <1207911557-9392-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22609 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758957AbYDKLAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 07:00:34 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3BB06hk021799
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 14:00:31 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

The following two patches get rids of most sparse warnings
in musb and twl4030 drivers.

Some of them still there because it didn't make sense fixing.
The most notable case is the preprocessor macros in the pr_info()
at musb_init() and lack of use of twl4030*gpio*() at twl4030-gpio.c.

Felipe Balbi (2):
  USB: MUSB: sparse fixes to musb_hdrc driver
  I2C: TWL4030: sparse fixes for twl4030 driver

 drivers/i2c/chips/twl4030-core.c     |    2 +-
 drivers/i2c/chips/twl4030-gpio.c     |   53 ++++++++++++++++------------------
 drivers/i2c/chips/twl4030-poweroff.c |    2 +-
 drivers/usb/musb/musb_host.c         |    6 ++--
 drivers/usb/musb/musbhsdma.c         |    6 ++--
 5 files changed, 33 insertions(+), 36 deletions(-)

