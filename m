From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv5 00/18] I2C updates
Date: Tue, 3 Apr 2012 21:32:19 +0530
Message-ID: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

v5 changes
- Add consistency in the subject naming. 

Tested on omap4sdp and omap3sdp.

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:
  git-OGgr7I4mDcYgsBAKwltoeQ@public.gmane.org:linus-tree/linus-tree.git i2c-v5

Jon Hunter (1):
      I2C: OMAP: Correct I2C revision for OMAP3

Shubhrajyoti D (15):
      I2C: OMAP: make omap_i2c_unidle/idle functions depend on CONFIG_PM_RUNTIME
      I2C: OMAP: Remove reset at init
      I2C: OMAP: I2C register restore only if context is lost
      I2C: OMAP: Fix the interrupt clearing in OMAP4
      I2C: OMAP: Fix the mismatch of pm_runtime enable and disable
      I2C: OMAP: Optimise the remove code
      I2C: OMAP: Fix the error handling
      I2C: OMAP: Don't check if wait_for_completion_timeout() returns less than zero
      I2C: OMAP: use devm_* functions
      I2C: OMAP: Fix the crash in i2c remove
      I2C: OMAP: Handle error check for pm runtime
      I2C: OMAP: Use SET_RUNTIME_PM_OPS
      I2C: OMAP: make the read ready processing a separate function
      I2C: OMAP: Do not set the XUDF if the underflow is not reached
      ARM: OMAP4: hwmod data: I2C: add flag for context restore

Tasslehoff Kjappfot (1):
      I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153

Vikram Pandita (1):
      I2C: OMAP: Recover from Bus Busy condition

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +-
 arch/arm/plat-omap/i2c.c                   |    3 +
 drivers/i2c/busses/i2c-omap.c              |  330 +++++++++++++++-------------
 include/linux/i2c-omap.h                   |    1 +
 4 files changed, 188 insertions(+), 149 deletions(-)
