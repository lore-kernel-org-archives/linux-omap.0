From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 00/23]I2C big cleanup
Date: Tue, 11 Sep 2012 15:11:55 +0530
Message-ID: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Changes since v1:
       - removed tabification on patch 6/17
       - removed dev_err() which was introduced on patch 09/17
Changes since v2:
        - do not set full fifo depth in the RDR interrupt.
        - some changelog updates.
        - rebase to the Wolfram's tree.
Changes since v3:
        - Remove a redundant read of status register
        - Read the dev->buf_len variable instead of the register
        as the information of the remaining bytes is there.
Changes since v4:
        - Ack the arbitration lost.
        - Rebase to the i2c-embedded/for-next branch.
Changes since v5:
        - Rebase to latest mainline
        - Added some more cleanup patches so as have a consolidated series.
Changes since v6:
        - Fix comments on setting the pdev to NULL.
        - Trivial changelog update

Previous discussions can be found here 
http://www.spinics.net/lists/linux-i2c/msg09482.html

This is the cleanup only series.
  
Tested on omap4sdp and 3430sdp.

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanup



Felipe Balbi (22):
  i2c: omap: switch to devm_* API
  i2c: omap: simplify num_bytes handling
  i2c: omap: decrease indentation level on data handling
  i2c: omap: add blank lines
  i2c: omap: simplify omap_i2c_ack_stat()
  i2c: omap: split out [XR]DR and [XR]RDY
  i2c: omap: improve i462 errata handling
  i2c: omap: re-factor receive/transmit data loop
  i2c: omap: switch over to do {} while loop
  i2c: omap: ack IRQ in parts
  i2c: omap: switch to platform_get_irq()
  i2c: omap: bus: add a receiver flag
  i2c: omap: simplify errata check
  i2c: omap: always return IRQ_HANDLED
  i2c: omap: simplify IRQ exit path
  i2c: omap: resize fifos before each message
  i2c: omap: get rid of the "complete" label
  i2c: omap: always return IRQ_HANDLED
  i2c: omap: switch to threaded IRQ support
  i2c: omap: remove unnecessary pm_runtime_suspended check
  i2c: omap: switch over to autosuspend API
  i2c: omap: sanitize exit path

Shubhrajyoti D (1):
  i2c: omap: remove redundant status read

 drivers/i2c/busses/i2c-omap.c |  442 +++++++++++++++++++++++++----------------
 1 files changed, 271 insertions(+), 171 deletions(-)

-- 
1.7.5.4
