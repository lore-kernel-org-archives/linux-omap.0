From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: twl3040-gpio: fix task softlockup warning
Date: Mon, 18 Aug 2008 18:54:57 +0300
Message-ID: <20080818155457.1371.38168.sendpatchset@localhost.localdomain>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37461 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYHRP4J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:56:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, Tony Lindgren <tony@atomide.com>

This patch fixes the following annoying warning:

INFO: task twl4030 gpio:283 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
twl4030 gpio  D c027e9dc     0   283      2
[<c027e744>] (schedule+0x0/0x314) from [<c00640f0>] (kthread+0x3c/0x80)
[<c00640b4>] (kthread+0x0/0x80) from [<c0052678>] (do_exit+0x0/0x664)
 r5:00000000 r4:00000000

Which is printed every 120 seconds by the softlockup code (see
'check_hung_task()' function, introduced by on Jan 2008 by commit
82a1fcb90287052aabfa235e7ffc693ea003fe69).

The reason is that the "twl4030 gpio" kthread is created but is not started
immediatelly. And in fact it may never start, because TWL3040 interrupts
may never happen and hence, the 'twl4030_gpio_unmask_irqchip()' function
is never run. This makes the softlockup detection code unhappy.

Fix this by running the "twl4030 gpio" kernel thread in at the end of the
'gpio_twl4030_init()' initialization function. Since the 'gpio_pending_unmask'
global variable is 0 at that time, the tread ('twl4030_gpio_unmask_thread()')
will effectively do nothing and go sleep. This makes the softlocup detection
code happy.

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 drivers/i2c/chips/twl4030-gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-gpio.c b/drivers/i2c/chips/twl4030-gpio.c
index 9d17f45..994245c 100644
--- a/drivers/i2c/chips/twl4030-gpio.c
+++ b/drivers/i2c/chips/twl4030-gpio.c
@@ -748,6 +748,7 @@ static int __init gpio_twl4030_init(void)
 			&twl4030_gpio_module_irq_chip);
 		set_irq_chained_handler(TWL4030_MODIRQ_GPIO,
 			do_twl4030_gpio_module_irq);
+		wake_up_process(gpio_unmask_thread);
 	}
 
 	printk(KERN_INFO "TWL4030 GPIO Demux: IRQ Range %d to %d,"
-- 
1.5.4.1

