From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv5 00/18] I2C big cleanup
Date: Thu, 19 Jul 2012 20:07:50 +0530
Message-ID: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41954 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab2GSOn4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 10:43:56 -0400
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

Tested on omap4sdp and 3430sdp.
Functional testing.
Also did suspend resume test.

This applies on Wolfram's i2c-embedded/for-next branch

Previous disscurssion
http://www.spinics.net/lists/linux-omap/msg73235.html

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git for_next/i2c/big_cleanup


Felipe Balbi (17):
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

Shubhrajyoti D (1):
  i2c: omap: remove redundant status read

 drivers/i2c/busses/i2c-omap.c |  392 ++++++++++++++++++++++++-----------------
 1 files changed, 228 insertions(+), 164 deletions(-)

-- 
1.7.5.4

