From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/3] lp5521
Date: Mon,  6 Oct 2008 12:11:28 +0300
Message-ID: <1223284291-7675-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41974 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbYJFJMT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:12:19 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m969BpTI006847
	for <linux-omap@vger.kernel.org>; Mon, 6 Oct 2008 12:12:17 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

A few cleanups and moving to drivers/leds. This driver
is probably ok for making its way to mainline, by the morning
I'll generate a patch against mainline and send to Richard
(led maintainer) for integration.

*** Note: compile tested only due to the fact n810 doesn't boot.

Felipe Balbi (3):
  i2c: lp5521: remove dead code
  i2c: lp5521: cosmetic fixes
  lp5521: move to drivers/leds

 drivers/i2c/chips/Kconfig                          |    7 -
 drivers/i2c/chips/Makefile                         |    1 -
 drivers/leds/Kconfig                               |    7 +
 drivers/leds/Makefile                              |    1 +
 drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} |  181 ++++++++------------
 5 files changed, 81 insertions(+), 116 deletions(-)
 rename drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} (79%)

