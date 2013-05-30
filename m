From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/1] i2c: omap: correct usage of the interrupt enable register
Date: Thu, 30 May 2013 18:56:18 +0300
Message-ID: <1369929379-19165-1-git-send-email-oleksandr.dmytryshyn@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I've just added a detailed description of the problem that is being solved
to the cover letter and commit message in the patch.

If the i2c controller during suspend will generate an interrupt, it
can lead to unpredictable behaviour in the kernel.

Based on the logic of the kernel code interrupts from i2c should be
prohibited during suspend. Kernel writes 0 to the I2C_IE register in
the omap_i2c_runtime_suspend() function. In the other side kernel
writes saved interrupt flags to the I2C_IE register in
omap_i2c_runtime_resume() function. I.e. interrupts should be disabled
during suspend.

This works for chips with version1 registers scheme. Interrupts are
disabled during suspend. For chips with version2 scheme registers
writting 0 to the I2C_IE register does nothing (because now the
I2C_IRQENABLE_SET register is located at this address). This register
is used to enable interrupts. For disabling interrupts
I2C_IRQENABLE_CLR register should be used.

Because the registers I2C_IRQENABLE_SET and I2C_IE have the same
addresses, the interrupt enabling procedure is unchanged.

I've checked that interrupts in the i2c controller are still enabled
after writting 0 to the I2C_IE register. But with my patch interrupts
are disabled in the omap_i2c_runtime_suspend() function. 

Next patch fixes it.

Patch is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
tag: v3.10-rc2

Verified on OMAP4430.

Oleksandr Dmytryshyn (1):
  i2c: omap: correct usage of the interrupt enable register

 drivers/i2c/busses/i2c-omap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
1.8.2.rc2
