From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 00/13] I2C cleanups
Date: Mon, 18 Jun 2012 20:00:15 +0530
Message-ID: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


The patch series does the following

- I2C register restore only if context if the context is lost
- Bus busy recovery mechanism.
- the reset is not done in init.
- Adds a patch to use devm_* functions
- Adds a pdata function pointer to do context save restore
- Split the omap_i2c_isr to increase readability
- Make the i2c use SET_RUNTIME_PM_OPS
- Use INIT_COMPLETION instead of init_completion
- Dropping a cleanup and taking few patchs Felipe's series as it may
 not be needed.

This applies on Wolfram's i2c-embedded/for-next branch.
 
Functional testing on omap4sdp and omap3sdp. 

Previous discurssions 
http://www.spinics.net/lists/linux-i2c/msg07748.html

This series mainly is the cleanups rebased on
i2c-embedded/for-next branch.


The following changes since commit 0f009a914b40be8786fa67b1f4345cacc263b48c:

  i2c: tegra: make all resource allocation through devm_* (2012-06-13 16:01:38 +0200)

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git for_next/i2c_omap

Felipe Balbi (4):
      I2C: OMAP: simplify num_bytes handling
      I2C: OMAP: decrease indentation level on data handling
      I2C: OMAP: add blank lines
      I2C: OMAP: simplify omap_i2c_ack_stat()

Jon Hunter (1):
      I2C: OMAP: Correct I2C revision for OMAP3

Shubhrajyoti D (7):
      I2C: OMAP: I2C register restore only if context is lost
      I2C: OMAP: Remove the definition of SYSS_RESETDONE_MASK
      I2C: OMAP: Remove reset at init
      I2C: OMAP: Optimise the remove code
      I2C: OMAP: use devm_* functions
      I2C: OMAP: Use SET_RUNTIME_PM_OPS
      I2C: OMAP: Do not initialise the completion everytime

Vikram Pandita (1):
      I2C: OMAP: Recover from Bus Busy condition

 arch/arm/plat-omap/i2c.c      |    3 +
 drivers/i2c/busses/i2c-omap.c |  261 +++++++++++++++++++++++-----------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 154 insertions(+), 111 deletions(-)
