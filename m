From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/10] git-pull-request for i2c-omap fixes and updates, v3
Date: Thu, 30 Oct 2008 19:29:39 -0700
Message-ID: <1225420189-630-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64597 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYJaC3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:29:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Ben,

Here's this series posted one more time. I've edited to the second
patch to do a read back of the register instead of wmb(), and also
added one more patch to ensure write posting.

Regards,

Tony

The following changes since commit 0173a3265b228da319ceb9c1ec6a5682fd1b2d92:
  Linus Torvalds (1):
        Linux 2.6.28-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git i2c-for-ben

Chandra shekhar (1):
      i2c-omap: Add support for omap34xx

Jarkko Nikula (1):
      i2c-omap: Do not use interruptible wait call in omap_i2c_xfer_msg

Nishanth Menon (1):
      i2c-omap: FIFO handling support and broken hw workaround for i2c-omap

Paul Walmsley (4):
      i2c-omap: Close suspected race between omap_i2c_idle() and omap_i2c_isr()
      i2c-omap: Mark init-only functions as __init
      i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
      i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()

Syed Mohammed Khasim (1):
      i2c-omap: Add high-speed support to omap-i2c

Tony Lindgren (2):
      i2c-omap: Clean-up i2c-omap
      I2C: Ensure write posting for critical i2c-omap writes

 arch/arm/mach-omap2/clock24xx.h |    4 +-
 drivers/i2c/busses/i2c-omap.c   |  343 ++++++++++++++++++++++++++++++---------
 2 files changed, 264 insertions(+), 83 deletions(-)
