From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 0/5] cbus/retu drivers to mainline
Date: Wed, 29 Aug 2012 00:34:22 +0300
Message-ID: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:34029 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2H1Ve3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Aug 2012 17:34:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri5.pp.htv.fi (Postfix) with ESMTP id EEB355A669D
	for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 00:34:27 +0300 (EEST)
Received: from smtp6.welho.com ([213.243.153.40])
	by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
	with ESMTP id wHUzrBddO796 for <linux-omap@vger.kernel.org>;
	Wed, 29 Aug 2012 00:34:27 +0300 (EEST)
Received: from blackmetal.bb.dnainternet.fi (212-149-209-232.bb.dnainternet.fi [212.149.209.232])
	by smtp6.welho.com (Postfix) with ESMTP id 9426A5BC004
	for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 00:34:27 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I would like to start converting cbus drivers from linux-omap cbus branch
for mainline inclusion. Currently e.g. watchdog support is missing at
least on Nokia N800, so you cannot run the mainline kernel for longer
than ~60 seconds (and there is no way to disable the watchdog).

My proposal is to make cbus an i2c bus driver. For other drivers, it
should be easier to find a proper place in the tree. Here's a first
quickly made attempt to provide watchdog driver functionality for
N800. Please comment.

Aaro Koskinen (5):
  i2c: introduce i2c-cbus driver
  mfd: introduce retu-mfd driver
  watchdog: introduce retu_wdt driver
  arm: omap: n8x0: add i2c-cbus platform data
  arm: omap: n8x0: enable retu

 arch/arm/mach-omap2/board-n8x0.c |   35 ++++
 drivers/i2c/busses/Kconfig       |   10 +
 drivers/i2c/busses/Makefile      |    1 +
 drivers/i2c/busses/i2c-cbus.c    |  342 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig              |    8 +
 drivers/mfd/Makefile             |    1 +
 drivers/mfd/retu-mfd.c           |  114 +++++++++++++
 drivers/watchdog/Kconfig         |   12 ++
 drivers/watchdog/Makefile        |    1 +
 drivers/watchdog/retu_wdt.c      |  191 +++++++++++++++++++++
 include/linux/i2c-cbus.h         |   27 +++
 include/linux/mfd/retu.h         |   20 +++
 12 files changed, 762 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-cbus.c
 create mode 100644 drivers/mfd/retu-mfd.c
 create mode 100644 drivers/watchdog/retu_wdt.c
 create mode 100644 include/linux/i2c-cbus.h
 create mode 100644 include/linux/mfd/retu.h

-- 
1.7.2.5

