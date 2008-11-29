From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/12] Updates for i2c-omap for 2.6.29 merge window, v5
Date: Fri, 28 Nov 2008 17:33:49 -0800
Message-ID: <20081129013318.13428.88465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

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
