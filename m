From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rft/rfc/patch-2.6.32-omap1+ 0/6] more cbus fixes
Date: Wed, 16 Dec 2009 01:44:07 +0200
Message-ID: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19859 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZLOXpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 18:45:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Hi all,

We really need someoe with n770 and n8x0 available to test these
patches.

I'm dropping the cbus-specific gpio handling functions over
gpiolib, this has to be tested on n770 which is the only
affected board with this patch.

Also the cbus_host global variable isn't exported anymore,
we keep it global but static on cbus.c, the callers
of cbus_transfer() won't have to care about passing a pointer
to cbus_host and we refer to it directly.

Please comment, there's still a lot of work needed on cbus,
in order to get it in shape for mainline.

Both tahvo and retu need to support genirq. That'll take
some time for me to fix, if there's someone out there
with more experience on genirq who wants to help, patches
are very much welcome.

cbus is currently the missing link for getting linux-omap-2.6.git
in sync with mainline, below is the diffstat showing that:

 drivers/Makefile                     |    2 +-
 drivers/cbus/Kconfig                 |   89 ----
 drivers/cbus/Makefile                |   14 -
 drivers/cbus/cbus.c                  |  308 --------------
 drivers/cbus/cbus.h                  |   36 --
 drivers/cbus/retu-headset.c          |  355 ----------------
 drivers/cbus/retu-pwrbutton.c        |  118 -----
 drivers/cbus/retu-rtc.c              |  477 ---------------------
 drivers/cbus/retu-user.c             |  424 ------------------
 drivers/cbus/retu-wdt.c              |  387 -----------------
 drivers/cbus/retu.c                  |  468 --------------------
 drivers/cbus/retu.h                  |   77 ----
 drivers/cbus/tahvo-usb.c             |  777 ----------------------------------
 drivers/cbus/tahvo-user.c            |  406 ------------------
 drivers/cbus/tahvo.c                 |  443 -------------------
 drivers/cbus/tahvo.h                 |   61 ---
 drivers/cbus/user_retu_tahvo.h       |   75 ----
 drivers/usb/host/ehci-omap.c         |    2 +-
 drivers/usb/otg/isp1301_omap.c       |    4 +-
 drivers/video/omap/lcd_ldp.c         |    4 +-
 drivers/video/omap/lcd_omap2evm.c    |   10 +-
 drivers/video/omap/lcd_omap3beagle.c |    2 +-
 drivers/video/omap/lcd_omap3evm.c    |   10 +-
 drivers/video/omap/lcd_overo.c       |    2 +-
 24 files changed, 18 insertions(+), 4533 deletions(-)

again, if you have an n770 and/or n8x0 dusting around, give
these patches a spin and help cleaning up cbus for us to send
it to mainline.

Felipe Balbi (6):
  cbus: convert u32 base to void __iomem *base
  cbus: NULL global variable on exit
  cbus: checkpatch.pl fix on cbus.c
  cbus: don't export the global cbus_host variable
  cbus: rely on gpiolib
  cbus: no ternary on return

 drivers/cbus/cbus.c  |  133 +++++++++++---------------------------------------
 drivers/cbus/cbus.h  |   14 +++--
 drivers/cbus/retu.c  |    4 +-
 drivers/cbus/tahvo.c |    4 +-
 4 files changed, 40 insertions(+), 115 deletions(-)

