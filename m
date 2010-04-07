From: felipe.balbi@nokia.com
Subject: [RFC PATCH 00/37] cbus patches
Date: Wed,  7 Apr 2010 19:03:51 +0300
Message-ID: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58477 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932700Ab0DGQFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:17 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58ei004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:14 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Hi all,

I still have to test these patches, but I fell like it's
time to get some comments.

There's still a big TODO for the whole cbus drivers:

. cleanup all tahvo drivers
. instantiate platform_device on board-files
. pass platform_data to retu/tahvo and their children from board-files
. move retu-headset to jack abstraction layer (??)
. move retu-user.c to platform_driver
. move tahvo and retu to generic-irq
. move tahvo and retu to mfd
. move tahvo and retu to threaded irq (??)
. move all children drivers to proper locations
. move cbus.c to a common location (drivers/misc ??)
. allow any arch to use cbus.c by passing correct gpio numbers
. get it all into mainline.

anyways, these patches were lightly boot tested on n810 and
compile tested with n770_defconfig.

patches also available on cbus branch of git://gitorious.org/usb/usb.git

Felipe Balbi (37):
  cbus: convert u32 base to void __iomem *base
  cbus: NULL global variable on exit
  cbus: checkpatch.pl fix on cbus.c
  cbus: don't export the global cbus_host variable
  cbus: rely on gpiolib
  cbus: no ternary on return
  cbus: add read/write flag to cbus_transfer
  cbus: don't type case when issuing read/write
  cbus: fix a resource leakage
  cbus: move cbus_host definition to C source
  cbus: handle possible errors on cbus_send/receive_bit
  cbus: introduce cbus_send/receive_data wrappers
  cbus: add kerneldoc
  cbus: retu-wdt: fix compile breakage
  cbus: retu: fix compile breakage on retu-headset
  cbus: retu: split one MODULE_AUTHOR into several
  cbus: retu: don't assing ret inside the if ()
  cbus: retu: convert printk to dev_*
  cbus: retu: convert to a platform_driver
  cbus: tahvo: split MODULE_AUTHOR into several entries
  cbus: tahvo: move EXPORT_SYMBOL macros closer to functions
  cbus: tahvo: don't assign ret inside if ()
  cbus: tahvo: convert printk into dev_*
  cbus: tahvo: convert to platform_driver
  cbus: retu: allocate platform_device for Retu's children
  cbus: retu-pwrbutton: convert to platform_driver
  cbus: retu-headset: simplify module_init
  cbus: retu-rtc: remove platform_device code
  cbus: retu-rtc: convert to platform_driver
  cbus: retu-rtc: split MODULE_AUTHOR into several entries
  cbus: retu-rtc: get rid of globals
  cbus: retu-rtc: move retu_rtc_barrier up on source code
  cbus: retu-rtc: make checkpatch.pl happy
  cbus: retu-rtc: switch to rtc class device
  cbus: retu-wdt: remove the platform_device
  cbus: retu-wtd: convert to platform_driver
  cbus: retu-wdt: misc cleanup on retu-wdt driver

 drivers/cbus/Kconfig          |    2 +-
 drivers/cbus/cbus.c           |  272 +++++++++++---------
 drivers/cbus/cbus.h           |   11 +-
 drivers/cbus/retu-headset.c   |   10 +-
 drivers/cbus/retu-pwrbutton.c |  126 +++++++---
 drivers/cbus/retu-rtc.c       |  546 +++++++++++++++++------------------------
 drivers/cbus/retu-wdt.c       |  126 ++++------
 drivers/cbus/retu.c           |  145 +++++++++---
 drivers/cbus/retu.h           |    6 +-
 drivers/cbus/tahvo.c          |   76 +++---
 drivers/cbus/tahvo.h          |    6 +-
 11 files changed, 676 insertions(+), 650 deletions(-)

