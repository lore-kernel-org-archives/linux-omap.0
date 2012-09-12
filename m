From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 00/23]I2C big cleanup
Date: Wed, 12 Sep 2012 16:27:54 +0530
Message-ID: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49333 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757535Ab2ILK7V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 06:59:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

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
Changes since v7:
	- Remove a patch as the code is getting changed anyways
	- Changelogs update.

Previous discussions can be found here 
http://www.spinics.net/lists/linux-i2c/msg09764.html

This is the cleanup only series.
  
Tested on omap4sdp and 3430sdp.

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups


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

