From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 03/16] ARM: omap: fix broken twl-core dependencies and ifdefs
Date: Wed, 08 Feb 2012 16:36:48 +0000
Message-ID: <E1RvAVk-0006Gt-O1@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39317 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab2BHQgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:36:52 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>

In commit aeb5032b3f, a dependency on IRQ_DOMAIN was added, which causes
regressions on previously working setups: a previously working non-DT
kernel configuration now loses its PMIC support.  The lack of PMIC
support in turn causes the loss of other functionality the kernel had.

This dependency was added because the driver now registers its
interrupts with the IRQ domain code, presumably to prevent a build error.

The result is that OMAP3 oopses in the vp.c code (fixed by a previous
commit) due to the lack of PMIC support.

However, even with IRQ_DOMAIN enabled, the driver oopses:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP
Modules linked in:
CPU: 1    Not tainted  (3.3.0-rc2+ #271)
PC is at irq_domain_add+0x1c/0x134
LR is at twl_probe+0xd0/0x370
pc : [<c007bad0>]    lr : [<c029baac>]    psr: 00000113
sp : df843c48  ip : df843c68  fp : df843c64
r10: c02b93e4  r9 : 00000000  r8 : c029b9dc
r7 : df9d8a00  r6 : c03bef90  r5 : 00000000  r4 : c03f5240
r3 : 00000000  r2 : c03f5240  r1 : 00000015  r0 : c03f5240
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8000404a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xdf8422f0)
Stack: (0xdf843c48 to 0xdf844000)
3c40:                   00000014 00000170 00000014 c03bef90 df843c9c df843c68
3c60: c029baac c007bac0 00000000 df9d8a20 00000001 c03cd238 c02b93e4 df9d8a20
3c80: df9d8a04 df9d8a00 c029b9dc df8cae08 df843cc4 df843ca0 c01eee70 c029b9e8
...
Backtrace:
[<c007bab4>] (irq_domain_add+0x0/0x134) from [<c029baac>] (twl_probe+0xd0/0x370)
 r6:c03bef90 r5:00000014 r4:00000170
[<c029b9dc>] (twl_probe+0x0/0x370) from [<c01eee70>] (i2c_device_probe+0xb0/0xe4)
[<c01eedc0>] (i2c_device_probe+0x0/0xe4) from [<c01d1f34>] (really_probe+0xa0/0x178)
 r8:df8f0070 r7:c03cd238 r6:df9d8a20 r5:df9d8a20 r4:df9d8a20
[<c01d1e94>] (really_probe+0x0/0x178) from [<c01d205c>] (driver_probe_device+0x50/0x68)
 r7:df843d18 r6:df9d8a20 r5:c03cd238 r4:df9d8a20
[<c01d200c>] (driver_probe_device+0x0/0x68) from [<c01d2148>] (__device_attach+0x44/0x48)
 r5:df9d8a20 r4:c03cd238
[<c01d2104>] (__device_attach+0x0/0x48) from [<c01d0840>] (bus_for_each_drv+0x58/0x98)
 r5:c01d2104 r4:00000000
[<c01d07e8>] (bus_for_each_drv+0x0/0x98) from [<c01d21f8>] (device_attach+0x80/0xac)
 r7:df9d8a28 r6:df9d8a54 r5:c03cd978 r4:df9d8a20
[<c01d2178>] (device_attach+0x0/0xac) from [<c01d1430>] (bus_probe_device+0x34/0xa4)
 r6:df9d8a20 r5:c03cd978 r4:df9d8a20
[<c01d13fc>] (bus_probe_device+0x0/0xa4) from [<c01cffb0>] (device_add+0x2a0/0x420)
 r6:00000000 r5:df9d8a20 r4:df9d8a20
[<c01cfd10>] (device_add+0x0/0x420) from [<c01d0150>] (device_register+0x20/0x24)
 r8:df9d8a00 r7:df9d8a04 r6:df8f0048 r5:df9d8a00 r4:df9d8a20
[<c01d0130>] (device_register+0x0/0x24) from [<c01ef8d4>] (i2c_new_device+0x118/0x180)
 r4:df9d8a20
[<c01ef7bc>] (i2c_new_device+0x0/0x180) from [<c01efc88>] (i2c_register_adapter+0x140/0x204)
 r8:c03cd970 r7:00000000 r6:df8f0070 r5:df8a6300 r4:df8f0048
[<c01efb48>] (i2c_register_adapter+0x0/0x204) from [<c01efe9c>] (i2c_add_numbered_adapter+0xb4/0xcc)
 r8:df8a4c54 r7:df8cae00 r6:df843e2c r5:df8f0048 r4:00000000
[<c01efde8>] (i2c_add_numbered_adapter+0x0/0xcc) from [<c029ce1c>] (omap_i2c_probe+0x2f8/0x3b4)
 r6:00000000 r5:df8f0000 r4:df8f0070
[<c029cb24>] (omap_i2c_probe+0x0/0x3b4) from [<c01d3484>] (platform_drv_probe+0x20/0x24)
[<c01d3464>] (platform_drv_probe+0x0/0x24) from [<c01d1f34>] (really_probe+0xa0/0x178)
[<c01d1e94>] (really_probe+0x0/0x178) from [<c01d205c>] (driver_probe_device+0x50/0x68)
 r7:df843ef0 r6:c03cdb2c r5:c03cdb2c r4:df8cae08
[<c01d200c>] (driver_probe_device+0x0/0x68) from [<c01d20e0>] (__driver_attach+0x6c/0x90)
 r5:df8cae3c r4:df8cae08
[<c01d2074>] (__driver_attach+0x0/0x90) from [<c01d08d8>] (bus_for_each_dev+0x58/0x98)
 r6:c03cdb2c r5:c01d2074 r4:00000000
[<c01d0880>] (bus_for_each_dev+0x0/0x98) from [<c01d1d80>] (driver_attach+0x20/0x28)
 r7:df880b80 r6:c03cdb2c r5:c03cdb2c r4:c0394f28
[<c01d1d60>] (driver_attach+0x0/0x28) from [<c01d115c>] (bus_add_driver+0xb4/0x230)
[<c01d10a8>] (bus_add_driver+0x0/0x230) from [<c01d278c>] (driver_register+0xc8/0x154)
[<c01d26c4>] (driver_register+0x0/0x154) from [<c01d37e4>] (platform_driver_register+0x4c/0x60)
 r8:00000000 r7:00000013 r6:c00384c8 r5:c0395180 r4:c0394f28
[<c01d3798>] (platform_driver_register+0x0/0x60) from [<c038626c>] (omap_i2c_init_driver+0x14/0x1c)
[<c0386258>] (omap_i2c_init_driver+0x0/0x1c) from [<c00087b8>] (do_one_initcall+0x9c/0x164)
[<c000871c>] (do_one_initcall+0x0/0x164) from [<c036c2f4>] (kernel_init+0x90/0x138)
[<c036c264>] (kernel_init+0x0/0x138) from [<c00384c8>] (do_exit+0x0/0x2ec)
 r5:c036c264 r4:00000000
<0>Code: e24dd004 e5903014 e1a04000 e5905010 (e5933000)
<4>---[ end trace 1b75b31a2719ed1c ]---

This happens because we try to register an IRQ domain with a NULL ops
structure, and the first thing irq_domain_add() does is try to
dereference this ops structure.

So, fix the problem by getting rid of the incorrect OF_IRQ ifdef and
wrapping the IRQ domain bits of the driver with an IRQ_DOMAIN ifdef
instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/Kconfig    |    2 +-
 drivers/mfd/twl-core.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index cd13e9f..f147395 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -200,7 +200,7 @@ config MENELAUS
 
 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
-	depends on I2C=y && GENERIC_HARDIRQS && IRQ_DOMAIN
+	depends on I2C=y && GENERIC_HARDIRQS
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
 	  This core driver provides register access and IRQ handling
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index e04e04d..8ce3959 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -263,7 +263,9 @@ struct twl_client {
 
 static struct twl_client twl_modules[TWL_NUM_SLAVES];
 
+#ifdef CONFIG_IRQ_DOMAIN
 static struct irq_domain domain;
+#endif
 
 /* mapping the module id to slave id and base address */
 struct twl_mapping {
@@ -1226,13 +1228,13 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	pdata->irq_base = status;
 	pdata->irq_end = pdata->irq_base + nr_irqs;
 
+#ifdef CONFIG_IRQ_DOMAIN
 	domain.irq_base = pdata->irq_base;
 	domain.nr_irq = nr_irqs;
-#ifdef CONFIG_OF_IRQ
 	domain.of_node = of_node_get(node);
 	domain.ops = &irq_domain_simple_ops;
-#endif
 	irq_domain_add(&domain);
+#endif
 
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
-- 
1.7.4.4

