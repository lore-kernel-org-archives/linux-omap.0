From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 00/10] I2C fixes
Date: Thu, 19 Apr 2012 18:58:11 +0530
Message-ID: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series seperates the fixes from other 
changes from [2] 

[2] http://www.spinics.net/lists/linux-omap/msg68056.html

The patch series does the following

- Warn fixes if CONFIG_PM_RUNTIME is not selected.
- In case of i2c remove register access was done without any
 get_sync fix the same.
- Folds a patch from Tasslehoff to prevent any merge conflicts.
- Prevents the XDUF flag to be set if the underflow condition is not met.
- As per discussion in [1] .Adds a patch to rename the 1p153 errata and
 use the unique id instead as the section number in the recent errata
 docs has changed.



[1] http://www.spinics.net/lists/linux-i2c/msg07607.html

Tested on omap4sdp and omap3sdp.

The following changes since commit 592fe8980688e7cba46897685d014c7fb3018a67:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2012-04-17 13:30:34 -0700)

are available in the git repository at:

  git://gitorious.org/linus-tree/linus-tree.git i2c_omap-fixes


Shubhrajyoti D (9):
  I2C: OMAP: make omap_i2c_unidle/idle functions depend on
    CONFIG_PM_RUNTIME
  I2C: OMAP: Fix the mismatch of pm_runtime enable and disable
  I2C: OMAP: Fix the interrupt clearing in OMAP4
  I2C: OMAP: Fix the error handling
  I2C: OMAP: Don't check if wait_for_completion_timeout() returns less
    than zero
  I2C: OMAP: Fix the crash in i2c remove
  I2C: OMAP: Handle error check for pm runtime
  I2C: OMAP: Do not set the XUDF if the underflow is not reached
  I2C: OMAP: Rename the 1p153 to the erratum id i462

Tasslehoff Kjappfot (1):
  I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153

 drivers/i2c/busses/i2c-omap.c |  132 +++++++++++++++++++++--------------------
 1 files changed, 67 insertions(+), 65 deletions(-)

-- 
1.7.5.4
