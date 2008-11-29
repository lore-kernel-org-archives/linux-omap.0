From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/12] Updates for i2c-omap for 2.6.29 merge window, v4
Date: Fri, 28 Nov 2008 17:28:06 -0800
Message-ID: <20081129012612.13042.12283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53460 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbYK2B2F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:28:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c-linux@vger.kernel.org, ben-linux@fluff.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are the i2c-omap patches again for next merge window.

Regards,

Tony

---

Chandra shekhar (1):
      i2c-omap: Add support for omap34xx

Jarkko Nikula (1):
      i2c-omap: Do not use interruptible wait call in omap_i2c_xfer_msg

Kalle Jokiniemi (1):
      i2c-omap: Enable I2C wakeups for 34xx

Nishanth Menon (1):
      i2c-omap: FIFO handling support and broken hw workaround for i2c-omap

Paul Walmsley (6):
      i2c-omap: reprogram OCP_SYSCONFIG register after reset
      i2c-omap: convert 'rev1' flag to generic 'rev' u8
      i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()
      i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
      i2c-omap: Mark init-only functions as __init
      i2c-omap: Close suspected race between omap_i2c_idle() and omap_i2c_isr()

Syed Mohammed Khasim (1):
      i2c-omap: Add high-speed support to omap-i2c

Tony Lindgren (1):
      i2c-omap: Clean-up i2c-omap


 arch/arm/mach-omap2/clock24xx.h |    4 
 drivers/i2c/busses/i2c-omap.c   |  420 ++++++++++++++++++++++++++++++---------
 2 files changed, 330 insertions(+), 94 deletions(-)

-- 
Signature
