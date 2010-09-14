From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 0/8] cbus patches
Date: Tue, 14 Sep 2010 11:30:08 +0300
Message-ID: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52435 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab0INIaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 04:30:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Hi all,

if you have n8x0/n770 board getting dust, please
spend some minutes to boot test the following
patches on that. After you do so, please reply
with your Tested-by tag.

I'm also adding to this series Jarkko Nikula's
ioctl fix since l-o doesn't compile without that.

Felipe Balbi (7):
  cbus: remove device_release completion
  cbus: retu: pass irq number via struct resource
  cbus: retu: avoid section mismatch
  cbus: tahvo: usb: convert to platform_driver
  cbus: tahvo: remove device_release
  cbus: tahvo: pass irq via struct resource
  cbus: tahvo: avoid section mismatch

Jarkko Nikula (1):
  cbus: Fix compile by converting ioctl calls to unlocked_ioctl calls

 drivers/cbus/retu-headset.c   |    3 +-
 drivers/cbus/retu-pwrbutton.c |    9 +--
 drivers/cbus/retu-rtc.c       |    7 +-
 drivers/cbus/retu-user.c      |    5 +-
 drivers/cbus/retu-wdt.c       |   13 ++--
 drivers/cbus/retu.c           |  123 ++++++++++++++++++++++-------------------
 drivers/cbus/tahvo-usb.c      |   49 ++++++++--------
 drivers/cbus/tahvo-user.c     |    5 +-
 drivers/cbus/tahvo.c          |  116 +++++++++++++++++++++------------------
 9 files changed, 172 insertions(+), 158 deletions(-)

-- 
1.7.3.rc0.35.g8ac8c

