From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/8] updtes to few nokia drivers
Date: Tue, 14 Oct 2008 16:01:32 +0300
Message-ID: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48374 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbYJNNCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 09:02:19 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9ED1vtD015096
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 16:02:16 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

The following patches updates a few nokia drivers. These
4 drivers are ready to go upstream and a patch will be
made as soon as they get applied to linux-omap.

Felipe Balbi (8):
  i2c: lp5521: remove dead code
  i2c: lp5521: cosmetic fixes
  lp5521: move to drivers/leds
  leds: lp5521: simplify mode setting
  leds: lp5521: register separate leds
  tsl2563: move tsl2563 to drivers/hwmon
  input: lm8323: get rid of global pdata pointer
  input: tsc2005: move to gpiolib

 drivers/hwmon/Kconfig                              |   10 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/{i2c/chips => hwmon}/tsl2563.c             |    2 +-
 drivers/i2c/chips/Kconfig                          |   17 -
 drivers/i2c/chips/Makefile                         |    2 -
 drivers/input/keyboard/lm8323.c                    |    4 +-
 drivers/input/touchscreen/tsc2005.c                |   15 +-
 drivers/leds/Kconfig                               |    7 +
 drivers/leds/Makefile                              |    1 +
 drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} |  379 +++++++++++++-------
 10 files changed, 280 insertions(+), 158 deletions(-)
 rename drivers/{i2c/chips => hwmon}/tsl2563.c (99%)
 rename drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} (62%)

