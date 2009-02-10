From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/8] updates to two nokia drivers
Date: Tue, 10 Feb 2009 14:15:57 +0200
Message-ID: <1234268165-23573-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57870 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZBJMaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 07:30:23 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1ACTZcb018282
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 06:30:21 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Hi Tony, all,

I'd like to get these integrated so afterwards I can
send the drivers to mainline.

At least lp5521 is in pretty good shape for mainline,
I'd say, but maybe lm8323 will get some comments.

Anyways, these were tested on n810.

Felipe Balbi (8):
  i2c: lp5521: remove dead code
  i2c: lp5521: cosmetic fixes
  i2c: lp5521: simplify mode setting
  i2c: lp5521: move to LED framework
  leds: lp5521: move to drivers/leds
  input: lm8323: get rid of global pdata pointer
  input: lm8323: get rid of useless debug macro
  input: lm8323: general clean up

 arch/arm/mach-omap2/board-n800.c                   |   14 +-
 drivers/i2c/chips/Kconfig                          |    7 -
 drivers/i2c/chips/Makefile                         |    1 -
 drivers/input/keyboard/lm8323.c                    |  113 +++----
 drivers/leds/Kconfig                               |   10 +
 drivers/leds/Makefile                              |    1 +
 drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} |  379 +++++++++++++-------
 7 files changed, 321 insertions(+), 204 deletions(-)
 rename drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} (62%)

