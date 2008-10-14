From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 0/7] updates to few nokia drivers
Date: Wed, 15 Oct 2008 00:39:50 +0300
Message-ID: <1224020397-2842-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47917 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYJNVkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:40:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Preparing few drivers for integration upstream.

At least lp5521 should be in good shape for going
upstream. lm8323 and tsc2005 might need some more
work.

Felipe Balbi (7):
  input: lm8323: get rid of global pdata pointer
  input: tsc2005: move to gpiolib
  i2c: lp5521: remove dead code
  i2c: lp5521: cosmetic fixes
  i2c: lp5521: simplify mode setting
  i2c: lp5521: move to LED framework
  leds: lp5521: move to drivers/leds

 drivers/i2c/chips/Kconfig                          |    7 -
 drivers/i2c/chips/Makefile                         |    1 -
 drivers/input/keyboard/lm8323.c                    |    4 +-
 drivers/input/touchscreen/tsc2005.c                |   15 +-
 drivers/leds/Kconfig                               |   10 +
 drivers/leds/Makefile                              |    1 +
 drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} |  379 +++++++++++++-------
 7 files changed, 271 insertions(+), 146 deletions(-)
 rename drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} (62%)

