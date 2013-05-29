From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
Subject: [PATCH 0/1] i2c: omap: correct usage of the interrupt enable register
Date: Wed, 29 May 2013 10:35:43 +0300
Message-ID: <1369812944-685-1-git-send-email-oleksandr.dmytryshyn@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Interrupts from i2c controller are enabled while i2c bus is in the
suspend mode (I2C_IE register doesn't equals to 0).

Starting from the OMAP chips with version2 registers scheme there
are 2 registers (I2C_IRQENABLE_SET and I2C_IRQENABLE_CLR) to manage
interrupts instead of the older OMAP chips old scheme which have
only one register (I2C_IE). Now for enabling interrupts we must
use I2C_IRQENABLE_SET register and for disabling interrupts we must
use I2C_IRQENABLE_CLR register.

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
