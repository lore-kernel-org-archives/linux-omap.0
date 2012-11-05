From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv3 0/7] i2c: omap: updates
Date: Mon, 5 Nov 2012 17:53:35 +0530
Message-ID: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60765 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab2KEMYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 07:24:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, balbi@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>


Does the followiing
- Make the revision a 32- bit consisting of rev_lo amd rev_hi each
of 16 bits.

- Also use the revision register for the erratum i207.
- Refactor the i2c_omap_init code.

Adds a patch to remove the hardcoding sysc register. Instead
read register ,reset and then writeback the read value.

Also more cleanup is possible will check on that subsequently.

Previous discussions can be found
http://www.spinics.net/lists/linux-omap/msg81265.html


Tested on OMAP4430sdp  ,4460 ,omap3630 ,3430 and omap2430.

For omap2 testing the below patch was used
[PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3 set

Also for using the pm testing below patches are used.

arm: sched: stop sched_clock() during suspend
ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git i2c_omap/for_3.8

Shubhrajyoti D (8):
      i2c: omap: Fix the revision register read
      i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
      i2c: omap: remove the dtrev
      ARM: i2c: omap: Remove the i207 errata flag
      i2c: omap: re-factor omap_i2c_init function
      i2c: omap: make reset a seperate function
      i2c: omap: Restore i2c context always
      i2c: omap: cleanup the sysc write

 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +-
 drivers/i2c/busses/i2c-omap.c              |  202 ++++++++++++++++------------
 include/linux/i2c-omap.h                   |    1 -
 4 files changed, 118 insertions(+), 97 deletions(-)

-- 
1.7.5.4

