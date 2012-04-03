From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 00/18] I2C updates
Date: Tue, 3 Apr 2012 17:08:09 +0530
Message-ID: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54779 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab2DCLjC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Apr 2012 07:39:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The patch series does the following

- Warn fixes if CONFIG_PM_RUNTIME is not selected.
- I2C register restore only if context if the context is lost
- Bus busy recovery mechanism.
- the reset is not done in init.

v2 changes
-Adds a patch to use devm_* functions
-Also checks the return type of the get_sync and in case
 of errors prevents register access.
- In case of i2c remove register access was done without any
 get_sync fix the same.
- Adds a pdata function pointer to do context save restore

v3 changes
- Split the omap_i2c_isr to increase readability
- Adds the restore flag patch for OMAP4 to the series
- Make the i2c use SET_RUNTIME_PM_OPS
v4 changes
- Folds a patch from Tasslehoff to prevent any merge conflicts.
- Prevents the XDUF flag to be set if the underflow condition is not met.

Tested on omap4sdp and omap3sdp.


Following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:
  git@gitorious.org:linus-tree/linus-tree.git i2c-v4

Jon Hunter (1):
      I2C: OMAP: Correct I2C revision for OMAP3

Shubhrajyoti D (15):
      I2C : OMAP : make omap_i2c_unidle/idle functions depend on CONFIG_PM_RUNTIME
      OMAP : I2C : Remove reset at init
      OMAP: I2C: I2C register restore only if context is lost
      OMAP: I2C: Fix the interrupt clearing in OMAP4
      OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
      OMAP: I2C: Optimise the remove code
      OMAP: I2C: Fix the error handling
      I2C: OMAP: Don't check if wait_for_completion_timeout() returns less than zero
      OMAP : I2C : use devm_* functions
      I2C : OMAP : Fix the crash in i2c remove
      OMAP: I2C: Handle error check for pm runtime
      I2C : OMAP : Use SET_RUNTIME_PM_OPS
      OMAP4: hwmod data: I2C: add flag for context restore
      i2c: omap: make the read ready processing a separate function
      i2c: omap: Do not set the XUDF if the underflow is not reached

Tasslehoff Kjappfot (1):
      I2C: OMAP : fix missing handling of errata I2C_OMAP3_1P153

Vikram Pandita (1):
      I2C: OMAP: Recover from Bus Busy condition

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +-
 arch/arm/plat-omap/i2c.c                   |    3 +
 drivers/i2c/busses/i2c-omap.c              |  330 +++++++++++++++-------------
 include/linux/i2c-omap.h                   |    1 +
 4 files changed, 188 insertions(+), 149 deletions(-)

