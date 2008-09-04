From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Errors on boot with 2.6.27-rc5 on omap3
Date: Wed, 3 Sep 2008 20:41:45 -0700
Message-ID: <5e088bd90809032041u69a60e71h4c22cfa3ce06ec86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:22016 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbYIDDlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 23:41:47 -0400
Received: by py-out-1112.google.com with SMTP id p76so1709539pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 03 Sep 2008 20:41:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Anyone else seeing this (error output below)?

I get similar results for both Beagle and Overo, so the error occurs
for both nand and onenand.  The boot eventually completes, of course
without nand/onenand support.

Steve

OneNAND driver initializing
omap2-onenand omap2-onenand: initializing on CS0, phys base
0x20000000, virtual base c8880000
Muxed OneNAND 128MB 1.8V 16-bit (0x30)
OneNAND version = 0x0221
Scanning device for bad blocks
Creating 5 MTD partitions on "omap2-onenand":
0x00000000-0x00080000 : "xloader"
0x00080000-0x00260000 : "uboot"
kobject (c795b20c): tried to init an initialized object, something is
seriously wrong.
[<c00309e8>] (dump_stack+0x0/0x14) from [<c0170c40>] (kobject_init+0x40/0x78)
[<c0170c00>] (kobject_init+0x0/0x78) from [<c017116c>]
(kobject_init_and_add+0x20/0x44)
 r5:c795b20c r4:c7b9c4b8
[<c0171150>] (kobject_init_and_add+0x4/0x44) from [<c0167e10>]
(blk_register_filter+0x48/0x60)
 r5:c7926400 r4:c795ada0
[<c0167dc8>] (blk_register_filter+0x0/0x60) from [<c0166d3c>]
(add_disk+0x60/0xb8)
 r4:c7b9c400
[<c0166cdc>] (add_disk+0x0/0xb8) from [<c01f9bf4>]
(add_mtd_blktrans_dev+0x24c/0x284)
 r5:c7926400 r4:00000001
[<c01f99a8>] (add_mtd_blktrans_dev+0x0/0x284) from [<c01fa1c4>]
(mtdblock_add_mtd+0x58/0x60)
 r8:00080000 r7:c0432a44 r6:001e0000 r5:c0448588 r4:c7bea300
[<c01fa16c>] (mtdblock_add_mtd+0x0/0x60) from [<c01f97a4>]
(blktrans_notify_add+0x30/0x60)
 r5:c7bea300 r4:c0448588
[<c01f9774>] (blktrans_notify_add+0x0/0x60) from [<c01f5be8>]
(add_mtd_device+0xb0/0x110)
 r5:c7bea300 r4:c0448550
[<c01f5b38>] (add_mtd_device+0x0/0x110) from [<c01f6fd4>]
(add_mtd_partitions+0x480/0x52c)
 r5:c7bdaa10 r4:c7bea300
[<c01f6b54>] (add_mtd_partitions+0x0/0x52c) from [<c03390e0>]
(omap2_onenand_probe+0x360/0x438)
[<c0338d80>] (omap2_onenand_probe+0x0/0x438) from [<c01b738c>]
(platform_drv_probe+0x20/0x24)
 r8:c0445d20 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b736c>] (platform_drv_probe+0x0/0x24) from [<c01b662c>]
(driver_probe_device+0xd0/0x17c)
[<c01b655c>] (driver_probe_device+0x0/0x17c) from [<c01b6724>]
(__driver_attach+0x4c/0x70)
 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b66d8>] (__driver_attach+0x0/0x70) from [<c01b5cac>]
(bus_for_each_dev+0x4c/0x84)
 r7:c04488d4 r6:c01b66d8 r5:c7825eb4 r4:00000000
[<c01b5c60>] (bus_for_each_dev+0x0/0x84) from [<c01b6474>]
(driver_attach+0x20/0x28)
 r7:c7927de0 r6:00000000 r5:c04488d4 r4:00000000
[<c01b6454>] (driver_attach+0x0/0x28) from [<c01b6130>]
(bus_add_driver+0xa4/0x210)
[<c01b608c>] (bus_add_driver+0x0/0x210) from [<c01b6918>]
(driver_register+0x98/0x120)
 r8:00000000 r7:00000000 r6:00000000 r5:c04488d4 r4:c0455e80
[<c01b6880>] (driver_register+0x0/0x120) from [<c01b7724>]
(platform_driver_register+0x78/0x94)
[<c01b76ac>] (platform_driver_register+0x0/0x94) from [<c001de5c>]
(omap2_onenand_init+0x1c/0x28)
[<c001de40>] (omap2_onenand_init+0x0/0x28) from [<c002c298>]
(__exception_text_end+0x50/0x17c)
[<c002c248>] (__exception_text_end+0x0/0x17c) from [<c0008734>]
(kernel_init+0x70/0xdc)
[<c00086c4>] (kernel_init+0x0/0xdc) from [<c004ecec>] (do_exit+0x0/0x6e8)
 r5:00000000 r4:00000000
0x00260000-0x00280000 : "params"
kobject (c795b20c): tried to init an initialized object, something is
seriously wrong.
[<c00309e8>] (dump_stack+0x0/0x14) from [<c0170c40>] (kobject_init+0x40/0x78)
[<c0170c00>] (kobject_init+0x0/0x78) from [<c017116c>]
(kobject_init_and_add+0x20/0x44)
 r5:c795b20c r4:c7b9ccb8
[<c0171150>] (kobject_init_and_add+0x4/0x44) from [<c0167e10>]
(blk_register_filter+0x48/0x60)
 r5:c7926b40 r4:c795ada0
[<c0167dc8>] (blk_register_filter+0x0/0x60) from [<c0166d3c>]
(add_disk+0x60/0xb8)
 r4:c7b9cc00
[<c0166cdc>] (add_disk+0x0/0xb8) from [<c01f9bf4>]
(add_mtd_blktrans_dev+0x24c/0x284)
 r5:c7926b40 r4:00000002
[<c01f99a8>] (add_mtd_blktrans_dev+0x0/0x284) from [<c01fa1c4>]
(mtdblock_add_mtd+0x58/0x60)
 r8:00260000 r7:c0432a5c r6:00020000 r5:c0448588 r4:c7bea400
[<c01fa16c>] (mtdblock_add_mtd+0x0/0x60) from [<c01f97a4>]
(blktrans_notify_add+0x30/0x60)
 r5:c7bea400 r4:c0448588
[<c01f9774>] (blktrans_notify_add+0x0/0x60) from [<c01f5be8>]
(add_mtd_device+0xb0/0x110)
 r5:c7bea400 r4:c0448550
[<c01f5b38>] (add_mtd_device+0x0/0x110) from [<c01f6fd4>]
(add_mtd_partitions+0x480/0x52c)
 r5:c7bdaa10 r4:c7bea400
[<c01f6b54>] (add_mtd_partitions+0x0/0x52c) from [<c03390e0>]
(omap2_onenand_probe+0x360/0x438)
[<c0338d80>] (omap2_onenand_probe+0x0/0x438) from [<c01b738c>]
(platform_drv_probe+0x20/0x24)
 r8:c0445d20 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b736c>] (platform_drv_probe+0x0/0x24) from [<c01b662c>]
(driver_probe_device+0xd0/0x17c)
[<c01b655c>] (driver_probe_device+0x0/0x17c) from [<c01b6724>]
(__driver_attach+0x4c/0x70)
 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b66d8>] (__driver_attach+0x0/0x70) from [<c01b5cac>]
(bus_for_each_dev+0x4c/0x84)
 r7:c04488d4 r6:c01b66d8 r5:c7825eb4 r4:00000000
[<c01b5c60>] (bus_for_each_dev+0x0/0x84) from [<c01b6474>]
(driver_attach+0x20/0x28)
 r7:c7927de0 r6:00000000 r5:c04488d4 r4:00000000
[<c01b6454>] (driver_attach+0x0/0x28) from [<c01b6130>]
(bus_add_driver+0xa4/0x210)
[<c01b608c>] (bus_add_driver+0x0/0x210) from [<c01b6918>]
(driver_register+0x98/0x120)
 r8:00000000 r7:00000000 r6:00000000 r5:c04488d4 r4:c0455e80
[<c01b6880>] (driver_register+0x0/0x120) from [<c01b7724>]
(platform_driver_register+0x78/0x94)
[<c01b76ac>] (platform_driver_register+0x0/0x94) from [<c001de5c>]
(omap2_onenand_init+0x1c/0x28)
[<c001de40>] (omap2_onenand_init+0x0/0x28) from [<c002c298>]
(__exception_text_end+0x50/0x17c)
[<c002c248>] (__exception_text_end+0x0/0x17c) from [<c0008734>]
(kernel_init+0x70/0xdc)
[<c00086c4>] (kernel_init+0x0/0xdc) from [<c004ecec>] (do_exit+0x0/0x6e8)
 r5:00000000 r4:00000000
0x00280000-0x00780000 : "linux"
kobject (c795b20c): tried to init an initialized object, something is
seriously wrong.
[<c00309e8>] (dump_stack+0x0/0x14) from [<c0170c40>] (kobject_init+0x40/0x78)
[<c0170c00>] (kobject_init+0x0/0x78) from [<c017116c>]
(kobject_init_and_add+0x20/0x44)
 r5:c795b20c r4:c7b9e4b8
[<c0171150>] (kobject_init_and_add+0x4/0x44) from [<c0167e10>]
(blk_register_filter+0x48/0x60)
 r5:c7926100 r4:c795ada0
[<c0167dc8>] (blk_register_filter+0x0/0x60) from [<c0166d3c>]
(add_disk+0x60/0xb8)
 r4:c7b9e400
[<c0166cdc>] (add_disk+0x0/0xb8) from [<c01f9bf4>]
(add_mtd_blktrans_dev+0x24c/0x284)
 r5:c7926100 r4:00000003
[<c01f99a8>] (add_mtd_blktrans_dev+0x0/0x284) from [<c01fa1c4>]
(mtdblock_add_mtd+0x58/0x60)
 r8:00280000 r7:c0432a74 r6:00500000 r5:c0448588 r4:c7bea500
[<c01fa16c>] (mtdblock_add_mtd+0x0/0x60) from [<c01f97a4>]
(blktrans_notify_add+0x30/0x60)
 r5:c7bea500 r4:c0448588
[<c01f9774>] (blktrans_notify_add+0x0/0x60) from [<c01f5be8>]
(add_mtd_device+0xb0/0x110)
 r5:c7bea500 r4:c0448550
[<c01f5b38>] (add_mtd_device+0x0/0x110) from [<c01f6fd4>]
(add_mtd_partitions+0x480/0x52c)
 r5:c7bdaa10 r4:c7bea500
[<c01f6b54>] (add_mtd_partitions+0x0/0x52c) from [<c03390e0>]
(omap2_onenand_probe+0x360/0x438)
[<c0338d80>] (omap2_onenand_probe+0x0/0x438) from [<c01b738c>]
(platform_drv_probe+0x20/0x24)
 r8:c0445d20 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b736c>] (platform_drv_probe+0x0/0x24) from [<c01b662c>]
(driver_probe_device+0xd0/0x17c)
[<c01b655c>] (driver_probe_device+0x0/0x17c) from [<c01b6724>]
(__driver_attach+0x4c/0x70)
 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b66d8>] (__driver_attach+0x0/0x70) from [<c01b5cac>]
(bus_for_each_dev+0x4c/0x84)
 r7:c04488d4 r6:c01b66d8 r5:c7825eb4 r4:00000000
[<c01b5c60>] (bus_for_each_dev+0x0/0x84) from [<c01b6474>]
(driver_attach+0x20/0x28)
 r7:c7927de0 r6:00000000 r5:c04488d4 r4:00000000
[<c01b6454>] (driver_attach+0x0/0x28) from [<c01b6130>]
(bus_add_driver+0xa4/0x210)
[<c01b608c>] (bus_add_driver+0x0/0x210) from [<c01b6918>]
(driver_register+0x98/0x120)
 r8:00000000 r7:00000000 r6:00000000 r5:c04488d4 r4:c0455e80
[<c01b6880>] (driver_register+0x0/0x120) from [<c01b7724>]
(platform_driver_register+0x78/0x94)
[<c01b76ac>] (platform_driver_register+0x0/0x94) from [<c001de5c>]
(omap2_onenand_init+0x1c/0x28)
[<c001de40>] (omap2_onenand_init+0x0/0x28) from [<c002c298>]
(__exception_text_end+0x50/0x17c)
[<c002c248>] (__exception_text_end+0x0/0x17c) from [<c0008734>]
(kernel_init+0x70/0xdc)
[<c00086c4>] (kernel_init+0x0/0xdc) from [<c004ecec>] (do_exit+0x0/0x6e8)
 r5:00000000 r4:00000000
0x00780000-0x08000000 : "rootfs"
kobject (c795b20c): tried to init an initialized object, something is
seriously wrong.
[<c00309e8>] (dump_stack+0x0/0x14) from [<c0170c40>] (kobject_init+0x40/0x78)
[<c0170c00>] (kobject_init+0x0/0x78) from [<c017116c>]
(kobject_init_and_add+0x20/0x44)
 r5:c795b20c r4:c7b9ecb8
[<c0171150>] (kobject_init_and_add+0x4/0x44) from [<c0167e10>]
(blk_register_filter+0x48/0x60)
 r5:c7926d40 r4:c795ada0
[<c0167dc8>] (blk_register_filter+0x0/0x60) from [<c0166d3c>]
(add_disk+0x60/0xb8)
 r4:c7b9ec00
[<c0166cdc>] (add_disk+0x0/0xb8) from [<c01f9bf4>]
(add_mtd_blktrans_dev+0x24c/0x284)
 r5:c7926d40 r4:00000004
[<c01f99a8>] (add_mtd_blktrans_dev+0x0/0x284) from [<c01fa1c4>]
(mtdblock_add_mtd+0x58/0x60)
 r8:00780000 r7:c0432a8c r6:07880000 r5:c0448588 r4:c7bea600
[<c01fa16c>] (mtdblock_add_mtd+0x0/0x60) from [<c01f97a4>]
(blktrans_notify_add+0x30/0x60)
 r5:c7bea600 r4:c0448588
[<c01f9774>] (blktrans_notify_add+0x0/0x60) from [<c01f5be8>]
(add_mtd_device+0xb0/0x110)
 r5:c7bea600 r4:c0448550
[<c01f5b38>] (add_mtd_device+0x0/0x110) from [<c01f6fd4>]
(add_mtd_partitions+0x480/0x52c)
 r5:c7bdaa10 r4:c7bea600
[<c01f6b54>] (add_mtd_partitions+0x0/0x52c) from [<c03390e0>]
(omap2_onenand_probe+0x360/0x438)
[<c0338d80>] (omap2_onenand_probe+0x0/0x438) from [<c01b738c>]
(platform_drv_probe+0x20/0x24)
 r8:c0445d20 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b736c>] (platform_drv_probe+0x0/0x24) from [<c01b662c>]
(driver_probe_device+0xd0/0x17c)
[<c01b655c>] (driver_probe_device+0x0/0x17c) from [<c01b6724>]
(__driver_attach+0x4c/0x70)
 r7:c04488d4 r6:c04488d4 r5:c0432754 r4:c04326a8
[<c01b66d8>] (__driver_attach+0x0/0x70) from [<c01b5cac>]
(bus_for_each_dev+0x4c/0x84)
 r7:c04488d4 r6:c01b66d8 r5:c7825eb4 r4:00000000
[<c01b5c60>] (bus_for_each_dev+0x0/0x84) from [<c01b6474>]
(driver_attach+0x20/0x28)
 r7:c7927de0 r6:00000000 r5:c04488d4 r4:00000000
[<c01b6454>] (driver_attach+0x0/0x28) from [<c01b6130>]
(bus_add_driver+0xa4/0x210)
[<c01b608c>] (bus_add_driver+0x0/0x210) from [<c01b6918>]
(driver_register+0x98/0x120)
 r8:00000000 r7:00000000 r6:00000000 r5:c04488d4 r4:c0455e80
[<c01b6880>] (driver_register+0x0/0x120) from [<c01b7724>]
(platform_driver_register+0x78/0x94)
[<c01b76ac>] (platform_driver_register+0x0/0x94) from [<c001de5c>]
(omap2_onenand_init+0x1c/0x28)
[<c001de40>] (omap2_onenand_init+0x0/0x28) from [<c002c298>]
(__exception_text_end+0x50/0x17c)
[<c002c248>] (__exception_text_end+0x0/0x17c) from [<c0008734>]
(kernel_init+0x70/0xdc)
[<c00086c4>] (kernel_init+0x0/0xdc) from [<c004ecec>] (do_exit+0x0/0x6e8)
 r5:00000000 r4:00000000
