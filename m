From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/07] pm: remove late/early platform driver pm callbacks
Date: Fri, 05 Jun 2009 16:54:36 +0900
Message-ID: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:33932 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbZFEH5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 03:57:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so604462rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 00:57:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: pavel@ucw.cz, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

pm: remove late/early platform driver pm callbacks

[PATCH 01/07] arm: rework omap suspend_late()/resume_early()
[PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
[PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
[PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
[PATCH 05/07] i2c: rework i2c-s3c2410 suspend_late()/resume()
[PATCH 06/07] usb: rework musb suspend()/resume_early()
[PATCH 07/07] pm: remove platform device suspend_late()/resume_early()

These patches simply remove ->suspend_late() and ->resume_early()
from struct platform_driver. Drivers are converted to dev_pm_ops
with CONFIG_SUSPEND in mind. Untested.

All patches except [02/07] are known to compile.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/arm/plat-omap/debug-leds.c  |   11 +++++++----
 arch/arm/plat-omap/gpio.c        |   14 ++++++++++----
 drivers/base/platform.c          |   36 ------------------------------------
 drivers/dma/dw_dmac.c            |   15 ++++++++++-----
 drivers/dma/txx9dmac.c           |   15 ++++++++++-----
 drivers/i2c/busses/i2c-pxa.c     |   25 +++++++++++++++++--------
 drivers/i2c/busses/i2c-s3c2410.c |   28 +++++++++++++++++-----------
 drivers/usb/musb/musb_core.c     |   18 ++++++++++++------
 include/linux/platform_device.h  |    2 --
 9 files changed, 83 insertions(+), 81 deletions(-)
