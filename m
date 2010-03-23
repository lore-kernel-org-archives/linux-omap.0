From: Mika Westerberg <ext-mika.1.westerberg-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: omap: fix OOPS in omap_i2c_unidle() during probe
Date: Tue, 23 Mar 2010 12:12:56 +0200
Message-ID: <1269339176-17479-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit d84d3ea317ce0db89ce0903b4037f800c5d4c477 added register shift to allow
also 16-bit register access. However, omap_i2c_unidle() is called before these
are set which causes the following OOPS:

    Unhandled fault: alignment exception (0x801) at 0xfa070009
    Internal error: : 801 [#1]
    last sysfs file:
    Modules linked in:
    CPU: 0    Not tainted  (2.6.34-rc2-00052-gae6be51 #3)
    PC is at omap_i2c_unidle+0x44/0x138
    LR is at trace_hardirqs_on_caller+0x158/0x18c
    pc : [<c01cd2c4>]    lr : [<c00743f8>]    psr: 20000013
    sp : cfc2bf10  ip : 00000009  fp : 00000000
    r10: 00000000  r9 : 00000000  r8 : c0378560
    r7 : c0378b88  r6 : c0378558  r5 : cfcadc00  r4 : cfcadc00
    r3 : 00000009  r2 : fa070000  r1 : 00000000  r0 : 00000000
    Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
    Control: 10c5387f  Table: 80004019  DAC: 00000017
    Process swapper (pid: 1, stack limit = 0xcfc2a2e8)
    Stack: (0xcfc2bf10 to 0xcfc2c000)
    bf00:                                     c0372cf8 c027225c 00000000 c0a69678
    bf20: cfc3e508 c0500898 c0378560 c0378560 c0500898 cfcac8c0 c04fc280 c017d4f4
    bf40: c0378560 c017c63c c0378560 c0378594 c0500898 cfcac8c0 c04fc280 c017c754
    bf60: 00000000 c017c6f4 c0500898 c017beac cfc16a5c cfc3fd94 c0023448 c0500898
    bf80: c0500898 c017b7d4 c032dc7f 00000093 cfc28d40 c0023448 00000000 c0500898
    bfa0: 00000000 00000000 00000000 c017ca48 c0023448 00000000 c001d274 00000000
    bfc0: 00000000 c002b344 00000031 00000000 00000000 00000192 00000000 c0023448
    bfe0: 00000000 00000000 00000000 c0008578 00000000 c002c304 ffdfffff ffffffff
    [<c01cd2c4>] (omap_i2c_unidle+0x44/0x138) from [<c027225c>] (omap_i2c_probe+0x1a4/0x398)
    [<c027225c>] (omap_i2c_probe+0x1a4/0x398) from [<c017d4f4>] (platform_drv_probe+0x18/0x1c)
    [<c017d4f4>] (platform_drv_probe+0x18/0x1c) from [<c017c63c>] (driver_probe_device+0xc0/0x178)
    [<c017c63c>] (driver_probe_device+0xc0/0x178) from [<c017c754>] (__driver_attach+0x60/0x84)
    [<c017c754>] (__driver_attach+0x60/0x84) from [<c017beac>] (bus_for_each_dev+0x44/0x74)
    [<c017beac>] (bus_for_each_dev+0x44/0x74) from [<c017b7d4>] (bus_add_driver+0x9c/0x218)
    [<c017b7d4>] (bus_add_driver+0x9c/0x218) from [<c017ca48>] (driver_register+0xa8/0x130)
    [<c017ca48>] (driver_register+0xa8/0x130) from [<c002b344>] (do_one_initcall+0x5c/0x1b8)
    [<c002b344>] (do_one_initcall+0x5c/0x1b8) from [<c0008578>] (kernel_init+0x90/0x144)
    [<c0008578>] (kernel_init+0x90/0x144) from [<c002c304>] (kernel_thread_exit+0x0/0x8)
    Code: e5942004 e3a0c009 e1a0331c e3a01000 (e18210b3)
    ---[ end trace 1b75b31a2719ed1c ]---

This patch moves register shift setting before any register accesses are done.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c7c2375..0d5a54a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -902,6 +902,11 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
+	if (cpu_is_omap7xx())
+		dev->reg_shift = 1;
+	else
+		dev->reg_shift = 2;
+
 	if ((r = omap_i2c_get_clocks(dev)) != 0)
 		goto err_iounmap;
 
@@ -925,11 +930,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->b_hw = 1; /* Enable hardware fixes */
 	}
 
-	if (cpu_is_omap7xx())
-		dev->reg_shift = 1;
-	else
-		dev->reg_shift = 2;
-
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-- 
1.5.6.5
