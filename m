From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Subject: [PATCH 0/2] power button repeat input events
Date: Fri, 11 Mar 2011 18:37:28 +0200
Message-ID: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:25718 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab1CKQhm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 11:37:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi,

this patchset adds optional generation of repeat input events for
twl4030 power button. It adds optional platform data for 
twl4030-pwrbutton and initializes it for RX51/N900 (default 
behavior kept - repeated input events disabled).

We are working on an OMAP3 with TWL5031 MFD. In one of the use 
scenarios userspace wants to receive repeated input events from 
long press of power button. 

--
Denis

Denis Karpov (2):
      input: twl4030-pwrbutton: add support for platform data
      omap: rx51: initialize platform data for twl4030 powerbutton

 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 drivers/input/misc/twl4030-pwrbutton.c       |    8 ++++++++
 drivers/mfd/twl-core.c                       |    4 +++-
 include/linux/i2c/twl.h                      |    5 +++++
 4 files changed, 21 insertions(+), 1 deletions(-)

