From: Matthias Scheer <scheer@in.tum.de>
Subject: smsc911x: regression on overo platform
Date: Mon, 2 May 2011 14:31:59 +0000 (UTC)
Message-ID: <loom.20110502T161913-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54051 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759301Ab1EBOfL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 May 2011 10:35:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1QGuDL-0002b9-0r
	for linux-omap@vger.kernel.org; Mon, 02 May 2011 16:35:09 +0200
Received: from ppp-93-104-17-21.dynamic.mnet-online.de ([93.104.17.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 02 May 2011 16:35:07 +0200
Received: from scheer by ppp-93-104-17-21.dynamic.mnet-online.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 02 May 2011 16:35:07 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

introduced by: 6629398945426f388d61392eecd733336a6316a4
environment: OMAP3503, Gumstix Overo, linux-omap-2.6.39-rc5
kernel .config @ http://pastebin.com/QESCFb6j

Thank you for looking into it.

[    0.205139] kobject (c04ce3a8): tried to init an initialized object,
something is seriously wrong.
[    0.205200] [<c004258c>] (unwind_backtrace+0x0/0xe4) from [<c01d1794>]
(kobject_init+0x38/0x70)
[    0.205261] [<c01d1794>] (kobject_init+0x38/0x70) from [<c0213dd4>]
(device_initialize+0x20/0xa4)
[    0.205322] [<c0213dd4>] (device_initialize+0x20/0xa4) from [<c02179a0>]
(platform_device_register+0x10/0x1c)
[    0.205383] [<c02179a0>] (platform_device_register+0x10/0x1c) from
[<c00128f4>] (gpmc_smsc911x_init+0x110/0x184)
[    0.205413] [<c00128f4>] (gpmc_smsc911x_init+0x110/0x184) from [<c0011cdc>]
(overo_init+0xe8/0x32c)
[    0.205444] [<c0011cdc>] (overo_init+0xe8/0x32c) from [<c000b19c>]
(customize_machine+0x1c/0x28)
[    0.205505] [<c000b19c>] (customize_machine+0x1c/0x28) from [<c00333b4>]
(do_one_initcall+0x98/0x16c)
[    0.205535] [<c00333b4>] (do_one_initcall+0x98/0x16c) from [<c0008388>]
(kernel_init+0x8c/0x13c)
[    0.205566] [<c0008388>] (kernel_init+0x8c/0x13c) from [<c003dd38>]
(kernel_thread_exit+0x0/0x8)
[    0.205627] ------------[ cut here ]------------
[    0.205657] WARNING: at kernel/resource.c:491 __insert_resource+0x44/0x12c()
[    0.205688] Modules linked in:
[    0.205718] [<c004258c>] (unwind_backtrace+0x0/0xe4) from [<c0065428>]
(warn_slowpath_common+0x4c/0x64)
[    0.205749] [<c0065428>] (warn_slowpath_common+0x4c/0x64) from [<c0065458>]
(warn_slowpath_null+0x18/0x1c)
[    0.205810] [<c0065458>] (warn_slowpath_null+0x18/0x1c) from [<c006bd64>]
(__insert_resource+0x44/0x12c)
[    0.205841] [<c006bd64>] (__insert_resource+0x44/0x12c) from [<c006bfc0>]
(insert_resource_conflict+0x24/0x3c)
[    0.205871] [<c006bfc0>] (insert_resource_conflict+0x24/0x3c) from
[<c006bfe0>] (insert_resource+0x8/0x14)
[    0.205902] [<c006bfe0>] (insert_resource+0x8/0x14) from [<c02178e4>]
(platform_device_add+0xb4/0x160)
[    0.205963] [<c02178e4>] (platform_device_add+0xb4/0x160) from [<c00128f4>]
(gpmc_smsc911x_init+0x110/0x184)
[    0.205993] [<c00128f4>] (gpmc_smsc911x_init+0x110/0x184) from [<c0011cdc>]
(overo_init+0xe8/0x32c)
[    0.206024] [<c0011cdc>] (overo_init+0xe8/0x32c) from [<c000b19c>]
(customize_machine+0x1c/0x28)
[    0.206085] [<c000b19c>] (customize_machine+0x1c/0x28) from [<c00333b4>]
(do_one_initcall+0x98/0x16c)
[    0.206115] [<c00333b4>] (do_one_initcall+0x98/0x16c) from [<c0008388>]
(kernel_init+0x8c/0x13c)
[    0.206146] [<c0008388>] (kernel_init+0x8c/0x13c) from [<c003dd38>]
(kernel_thread_exit+0x0/0x8)
[    0.206542] ---[ end trace 1b75b31a2719ed1c ]---
[    0.206573] smsc911x: failed to claim resource 0
[    0.206573] Unable to register smsc911x device
[    0.206604] ------------[ cut here ]------------
[    0.206634] WARNING: at drivers/gpio/gpiolib.c:1236
gpmc_smsc911x_init+0x130/0x184()
[    0.206634] Modules linked in:
[    0.206665] [<c004258c>] (unwind_backtrace+0x0/0xe4) from [<c0065428>]
(warn_slowpath_common+0x4c/0x64)
[    0.206726] [<c0065428>] (warn_slowpath_common+0x4c/0x64) from [<c0065458>]
(warn_slowpath_null+0x18/0x1c)
[    0.206756] [<c0065458>] (warn_slowpath_null+0x18/0x1c) from [<c0012914>]
(gpmc_smsc911x_init+0x130/0x184)
[    0.206787] [<c0012914>] (gpmc_smsc911x_init+0x130/0x184) from [<c0011cdc>]
(overo_init+0xe8/0x32c)
[    0.206848] [<c0011cdc>] (overo_init+0xe8/0x32c) from [<c000b19c>]
(customize_machine+0x1c/0x28)
[    0.206878] [<c000b19c>] (customize_machine+0x1c/0x28) from [<c00333b4>]
(do_one_initcall+0x98/0x16c)
[    0.206909] [<c00333b4>] (do_one_initcall+0x98/0x16c) from [<c0008388>]
(kernel_init+0x8c/0x13c)
[    0.206939] [<c0008388>] (kernel_init+0x8c/0x13c) from [<c003dd38>]
(kernel_thread_exit+0x0/0x8)
[    0.206970] ---[ end trace 1b75b31a2719ed1d ]---
[    0.207031] Could not initialize smsc911x


