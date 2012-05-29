From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv10 00/11] I2C fixes
Date: Tue, 29 May 2012 16:26:12 +0530
Message-ID: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51686 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813Ab2E2K5Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 06:57:25 -0400
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

v10:
Add a patch from Neil to the series.
Fix kevin comments
update the patches with comments.

[1] http://www.spinics.net/lists/linux-i2c/msg07607.html

Tested on omap4sdp and omap3sdp.
- Did functional tests read write on both the platforms.
- Off mode and retention on OMAP3
- On OMAP4 just did echo mem > /sys/power/state and wakeup.
Did see.
[ 1360.595855] Successfully put all powerdomains to target state
However didnt see the ret count for other than mpu_pwrdm increase.
I think power support for omap4 is minimal. 

The following changes since commit b48b2c3e50433ff6f7e46186daa7f986bd960215:

  openrisc: use generic strnlen_user() function (2012-05-27 21:00:32 -0700)

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git i2c_omap-fixes

Neil Brown (1):
      OMAP/I2C - Fix timeout problem during suspend.

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

 drivers/i2c/busses/i2c-omap.c |  129 ++++++++++++++++++++---------------------
 1 files changed, 63 insertions(+), 66 deletions(-)

-- 
1.7.5.4

