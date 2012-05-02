From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv9 00/10] I2C fixes
Date: Wed, 2 May 2012 20:02:05 +0530
Message-ID: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35506 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263Ab2EBOdV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 10:33:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>


The patch series does the following

- Warn fixes if CONFIG_PM_RUNTIME is not selected.
- In case of i2c remove register access was done without any
 get_sync fix the same.
- Folds a patch from Tasslehoff to prevent any merge conflicts.
- Prevents the XDUF flag to be set if the underflow condition is not met.
- As per discussion in [1] .Adds a patch to rename the 1p153 errata and
 use the unique id instead as the section number in the recent errata
 docs has changed.

v9:
Fix the comments from Wolfram Sang

[1] http://www.spinics.net/lists/linux-i2c/msg07607.html

Tested on omap4sdp and omap3sdp.

The following changes since commit b821861b905a79f71746945237968c3382d99adc:

  Merge tag 'ktest-for-v3.4-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest (2012-05-01 19:43:34 -0700)

are available in the git repository at:

  git://gitorious.org/linus-tree/linus-tree.git i2c_omap-fixes

Shubhrajyoti D (9):
      I2C: OMAP: make omap_i2c_unidle/idle functions depend on CONFIG_PM_RUNTIME
      I2C: OMAP: Fix the mismatch of pm_runtime enable and disable
      I2C: OMAP: Fix the interrupt clearing in OMAP4
      I2C: OMAP: Prevent the register access after pm_runtime_put in probe
      I2C: OMAP: Don't check if wait_for_completion_timeout() returns less than zero
      I2C: OMAP: Fix the crash in i2c remove
      I2C: OMAP: Handle error check for pm runtime
      I2C: OMAP: Do not set the XUDF(Transmit underflow) if the underflow is not reached
      I2C: OMAP: Rename the 1p153 to the erratum id i462

Tasslehoff Kjappfot (1):
      I2C: OMAP: prevent the overwrite of the errata flags

 drivers/i2c/busses/i2c-omap.c |  127 ++++++++++++++++++++---------------------
 1 files changed, 62 insertions(+), 65 deletions(-)

-- 
1.7.5.4

