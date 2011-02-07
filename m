From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: smartreflex: fix another memory leak
Date: Mon,  7 Feb 2011 14:57:51 +0200
Message-ID: <1297083471-6341-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:54013 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954Ab1BGMzA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Feb 2011 07:55:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

Temporary strings with volt_* file names should be released after the
debugfs entries are created.

The patch eliminates kmemleak reports with the following stack trace
(multiple objects depending on HW):

unreferenced object 0xcedbc5a0 (size 64):
  comm "swapper", pid 1, jiffies 4294929375 (age 423.734s)
  hex dump (first 32 bytes):
    76 6f 6c 74 5f 39 37 35 30 30 30 00 00 00 00 00  volt_975000.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<c012fee0>] create_object+0x104/0x208
    [<c012dbc8>] kmem_cache_alloc_trace+0xf0/0x17c
    [<c0013f64>] omap_sr_probe+0x314/0x420
    [<c02a1724>] platform_drv_probe+0x18/0x1c
    [<c02a088c>] driver_probe_device+0xc8/0x188
    [<c02a09b4>] __driver_attach+0x68/0x8c
    [<c02a00ac>] bus_for_each_dev+0x44/0x74
    [<c029f9e0>] bus_add_driver+0xa0/0x228
    [<c02a0cac>] driver_register+0xa8/0x130
    [<c02a1b2c>] platform_driver_probe+0x18/0x8c
    [<c0013c1c>] sr_init+0x40/0x74
    [<c005a554>] do_one_initcall+0xc8/0x1a0
    [<c00084f4>] kernel_init+0x150/0x218
    [<c0065d64>] kernel_thread_exit+0x0/0x8
    [<ffffffff>] 0xffffffff

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 77ecebf..61aebed 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -942,6 +942,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		strcat(name, volt_name);
 		(void) debugfs_create_x32(name, S_IRUGO | S_IWUGO, nvalue_dir,
 				&(sr_info->nvalue_table[i].nvalue));
+		kfree(name);
 	}
 
 	return ret;
-- 
1.5.6.5

