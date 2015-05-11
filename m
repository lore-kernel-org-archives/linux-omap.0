From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] gpio: pcf875x: Revert "gpio: pcf857x: Propagate wake-up setting to parent irq controller"
Date: Mon, 11 May 2015 17:13:21 +0300
Message-ID: <1431353601-21295-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, geert@linux-m68k.org
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')
introduces the following recursive locking warning while suspending dra7-evm.

The issue addressed by that commit has been already resolved by
commit 10a50f1ab5f0 ('genirq: Set IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip')
and so let's revert commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')

At least the recursive locking message no longer appears after the revert.

[   30.591905] PM: Syncing filesystems ... done.
[   30.623060] Freezing user space processes ... (elapsed 0.003 seconds) done.
[   30.634470] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[   30.658288] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   30.663678]
[   30.663681] =============================================
[   30.663683] [ INFO: possible recursive locking detected ]
[   30.663688] 4.1.0-rc3 #1115 Not tainted
[   30.663693] ---------------------------------------------
[   30.663697] suspend.sh/2319 is trying to acquire lock:
[   30.663719]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
[   30.663722]
[   30.663722] but task is already holding lock:
[   30.663734]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
[   30.663736]
[   30.663736] other info that might help us debug this:
[   30.663739]  Possible unsafe locking scenario:
[   30.663739]
[   30.663740]        CPU0
[   30.663743]        ----
[   30.663747]   lock(class);
[   30.663752]   lock(class);
[   30.663755]
[   30.663755]  *** DEADLOCK ***
[   30.663755]
[   30.663757]  May be due to missing lock nesting notation
[   30.663757]
[   30.663761] 6 locks held by suspend.sh/2319:
[   30.663778]  #0:  (sb_writers#7){.+.+.+}, at: [<c015fb1c>] vfs_write+0x130/0x14c
[   30.663793]  #1:  (&of->mutex){+.+.+.}, at: [<c01cdbb0>] kernfs_fop_write+0x4c/0x198
[   30.663807]  #2:  (s_active#37){.+.+.+}, at: [<c01cdbb8>] kernfs_fop_write+0x54/0x198
[   30.663820]  #3:  (pm_mutex){+.+.+.}, at: [<c0092ef8>] pm_suspend+0x240/0x4b8
[   30.663834]  #4:  (&dev->mutex){......}, at: [<c03dc918>] __device_suspend+0xd0/0x378
[   30.663847]  #5:  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
[   30.663849]
[   30.663849] stack backtrace:
[   30.663856] CPU: 0 PID: 2319 Comm: suspend.sh Not tainted 4.1.0-rc3 #1115
[   30.663859] Hardware name: Generic DRA74X (Flattened Device Tree)
[   30.663873] [<c00163bc>] (unwind_backtrace) from [<c0012930>] (show_stack+0x10/0x14)
[   30.663884] [<c0012930>] (show_stack) from [<c05f9ee8>] (dump_stack+0x80/0x9c)
[   30.663896] [<c05f9ee8>] (dump_stack) from [<c008bba4>] (__lock_acquire+0x13f0/0x1c14)
[   30.663905] [<c008bba4>] (__lock_acquire) from [<c008c940>] (lock_acquire+0x9c/0x114)
[   30.663914] [<c008c940>] (lock_acquire) from [<c0600214>] (_raw_spin_lock_irqsave+0x38/0x4c)
[   30.663922] [<c0600214>] (_raw_spin_lock_irqsave) from [<c0096ebc>] (__irq_get_desc_lock+0x48/0x88)
[   30.663932] [<c0096ebc>] (__irq_get_desc_lock) from [<c00977cc>] (irq_set_irq_wake+0x20/0xf0)
[   30.663946] [<c00977cc>] (irq_set_irq_wake) from [<bf0000c8>] (pcf857x_irq_set_wake+0x14/0x1c [gpio_pcf857x])
[   30.663962] [<bf0000c8>] (pcf857x_irq_set_wake [gpio_pcf857x]) from [<c009764c>] (set_irq_wake_real+0x30/0x44)
[   30.663970] [<c009764c>] (set_irq_wake_real) from [<c0097838>] (irq_set_irq_wake+0x8c/0xf0)
[   30.663979] [<c0097838>] (irq_set_irq_wake) from [<bf059074>] (usb_extcon_suspend+0x2c/0x48 [extcon_usb_gpio])
[   30.663992] [<bf059074>] (usb_extcon_suspend [extcon_usb_gpio]) from [<c03d38e8>] (platform_pm_suspend+0x2c/0x54)
[   30.664003] [<c03d38e8>] (platform_pm_suspend) from [<c03dbe10>] (dpm_run_callback+0x4c/0x110)
[   30.664012] [<c03dbe10>] (dpm_run_callback) from [<c03dc974>] (__device_suspend+0x12c/0x378)
[   30.664019] [<c03dc974>] (__device_suspend) from [<c03de4ac>] (dpm_suspend+0x128/0x2d8)
[   30.664025] [<c03de4ac>] (dpm_suspend) from [<c00926a0>] (suspend_devices_and_enter+0x84/0x69c)
[   30.664032] [<c00926a0>] (suspend_devices_and_enter) from [<c00930f4>] (pm_suspend+0x43c/0x4b8)
[   30.664039] [<c00930f4>] (pm_suspend) from [<c0091654>] (state_store+0x68/0xb8)
[   30.664049] [<c0091654>] (state_store) from [<c03421b8>] (kobj_attr_store+0x14/0x20)
[   30.664058] [<c03421b8>] (kobj_attr_store) from [<c01ce84c>] (sysfs_kf_write+0x4c/0x50)
[   30.664065] [<c01ce84c>] (sysfs_kf_write) from [<c01cdc20>] (kernfs_fop_write+0xbc/0x198)
[   30.664074] [<c01cdc20>] (kernfs_fop_write) from [<c015eab0>] (__vfs_write+0x2c/0xd8)
[   30.664082] [<c015eab0>] (__vfs_write) from [<c015fa7c>] (vfs_write+0x90/0x14c)
[   30.664088] [<c015fa7c>] (vfs_write) from [<c015fd04>] (SyS_write+0x40/0x8c)
[   30.664097] [<c015fd04>] (SyS_write) from [<c000f540>] (ret_fast_syscall+0x0/0x4c)
[   31.038856] sd 0:0:0:0: [sda] Stopping disk
[   31.644707] PM: suspend of devices complete after 996.653 msecs
[   31.654312] PM: late suspend of devices complete after 3.329 msecs
[   31.663835] PM: noirq suspend of devices complete after 3.029 msecs
[   31.670422] Disabling non-boot CPUs ...
[   31.675294] CPU1: shutdown

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/gpio/gpio-pcf857x.c | 37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 945f0cd..126c937 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -204,36 +204,6 @@ static irqreturn_t pcf857x_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/*
- * NOP functions
- */
-static void noop(struct irq_data *data) { }
-
-static unsigned int noop_ret(struct irq_data *data)
-{
-	return 0;
-}
-
-static int pcf857x_irq_set_wake(struct irq_data *data, unsigned int on)
-{
-	struct pcf857x *gpio = irq_data_get_irq_chip_data(data);
-
-	irq_set_irq_wake(gpio->client->irq, on);
-	return 0;
-}
-
-static struct irq_chip pcf857x_irq_chip = {
-	.name		= "pcf857x",
-	.irq_startup	= noop_ret,
-	.irq_shutdown	= noop,
-	.irq_enable	= noop,
-	.irq_disable	= noop,
-	.irq_ack	= noop,
-	.irq_mask	= noop,
-	.irq_unmask	= noop,
-	.irq_set_wake	= pcf857x_irq_set_wake,
-};
-
 /*-------------------------------------------------------------------------*/
 
 static int pcf857x_probe(struct i2c_client *client,
@@ -347,9 +317,8 @@ static int pcf857x_probe(struct i2c_client *client,
 
 	/* Enable irqchip if we have an interrupt */
 	if (client->irq) {
-		status = gpiochip_irqchip_add(&gpio->chip, &pcf857x_irq_chip,
-					      0, handle_level_irq,
-					      IRQ_TYPE_NONE);
+		status = gpiochip_irqchip_add(&gpio->chip, &dummy_irq_chip, 0,
+					      handle_level_irq, IRQ_TYPE_NONE);
 		if (status) {
 			dev_err(&client->dev, "cannot add irqchip\n");
 			goto fail_irq;
@@ -362,7 +331,7 @@ static int pcf857x_probe(struct i2c_client *client,
 		if (status)
 			goto fail_irq;
 
-		gpiochip_set_chained_irqchip(&gpio->chip, &pcf857x_irq_chip,
+		gpiochip_set_chained_irqchip(&gpio->chip, &dummy_irq_chip,
 					     client->irq, NULL);
 	}
 
-- 
2.1.4

