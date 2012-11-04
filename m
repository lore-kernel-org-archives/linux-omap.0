From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv2 0/7] i2c: omap: updates
Date: Sun, 4 Nov 2012 16:14:26 +0530
Message-ID: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59669 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab2KDKpH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Nov 2012 05:45:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>


Does the followiing
- Make the revision a 32- bit consisting of rev_lo amd rev_hi each
of 16 bits.

- Also use the revision register for the erratum i207.
- Refactor the i2c_omap_init code.


Also more cleanup is possible will check on that subsequently.


Tested on OMAP4430sdp  ,4460 ,omap3630 ,3430 and omap2430.

For omap2 testing the below patch was used
[PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3 set

Also for using the pm testing below patches are used.

arm: sched: stop sched_clock() during suspend
ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod

Also available through
git://gitorious.org/linus-tree/linus-tree.git i2c_omap/for_3.8


Shubhrajyoti D (7):
  i2c: omap: Fix the revision register read
  i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
  i2c: omap: remove the dtrev
  ARM: i2c: omap: Remove the i207 errata flag
  i2c: omap: re-factor omap_i2c_init function
  i2c: omap: make reset a seperate function
  i2c: omap: Restore i2c context always

 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +-
 drivers/i2c/busses/i2c-omap.c              |  166 +++++++++++++++++-----------
 include/linux/i2c-omap.h                   |    1 -
 4 files changed, 104 insertions(+), 75 deletions(-)

-- 
1.7.5.4

