From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: smsc911x: regression on overo platform
Date: Tue, 03 May 2011 08:24:53 +0300
Message-ID: <4DBF91A5.9060503@compulab.co.il>
References: <loom.20110502T161913-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:45490
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751196Ab1ECFY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 01:24:58 -0400
In-Reply-To: <loom.20110502T161913-232@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Scheer <scheer@in.tum.de>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Yeah, sorry about that.
There's a fix at (1), I hope Tony will merge it soon.

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/56499/focus=56542

On 05/02/11 17:31, Matthias Scheer wrote:
> introduced by: 6629398945426f388d61392eecd733336a6316a4
> environment: OMAP3503, Gumstix Overo, linux-omap-2.6.39-rc5
> kernel .config @ http://pastebin.com/QESCFb6j
> 
> Thank you for looking into it.
> 
> [    0.205139] kobject (c04ce3a8): tried to init an initialized object,
> something is seriously wrong.
> [    0.205200] [<c004258c>] (unwind_backtrace+0x0/0xe4) from [<c01d1794>]
> (kobject_init+0x38/0x70)
> [    0.205261] [<c01d1794>] (kobject_init+0x38/0x70) from [<c0213dd4>]
> (device_initialize+0x20/0xa4)
> [    0.205322] [<c0213dd4>] (device_initialize+0x20/0xa4) from [<c02179a0>]
> (platform_device_register+0x10/0x1c)
> [    0.205383] [<c02179a0>] (platform_device_register+0x10/0x1c) from
> [<c00128f4>] (gpmc_smsc911x_init+0x110/0x184)
> [    0.205413] [<c00128f4>] (gpmc_smsc911x_init+0x110/0x184) from [<c0011cdc>]
> (overo_init+0xe8/0x32c)
> [    0.205444] [<c0011cdc>] (overo_init+0xe8/0x32c) from [<c000b19c>]
> (customize_machine+0x1c/0x28)
> [    0.205505] [<c000b19c>] (customize_machine+0x1c/0x28) from [<c00333b4>]
> (do_one_initcall+0x98/0x16c)
> [    0.205535] [<c00333b4>] (do_one_initcall+0x98/0x16c) from [<c0008388>]
> (kernel_init+0x8c/0x13c)
> [    0.205566] [<c0008388>] (kernel_init+0x8c/0x13c) from [<c003dd38>]
> (kernel_thread_exit+0x0/0x8)
> [    0.205627] ------------[ cut here ]------------
> [    0.205657] WARNING: at kernel/resource.c:491 __insert_resource+0x44/0x12c()
> [    0.205688] Modules linked in:
> [    0.205718] [<c004258c>] (unwind_backtrace+0x0/0xe4) from [<c0065428>]
> (warn_slowpath_common+0x4c/0x64)
> [    0.205749] [<c0065428>] (warn_slowpath_common+0x4c/0x64) from [<c0065458>]
> (warn_slowpath_null+0x18/0x1c)
> [    0.205810] [<c0065458>] (warn_slowpath_null+0x18/0x1c) from [<c006bd64>]
> (__insert_resource+0x44/0x12c)
> [    0.205841] [<c006bd64>] (__insert_resource+0x44/0x12c) from [<c006bfc0>]
> (insert_resource_conflict+0x24/0x3c)
> [    0.205871] [<c006bfc0>] (insert_resource_conflict+0x24/0x3c) from
> [<c006bfe0>] (insert_resource+0x8/0x14)
> [    0.205902] [<c006bfe0>] (insert_resource+0x8/0x14) from [<c02178e4>]
> (platform_device_add+0xb4/0x160)
> [    0.205963] [<c02178e4>] (platform_device_add+0xb4/0x160) from [<c00128f4>]
> (gpmc_smsc911x_init+0x110/0x184)
> [    0.205993] [<c00128f4>] (gpmc_smsc911x_init+0x110/0x184) from [<c0011cdc>]
> (overo_init+0xe8/0x32c)
> [    0.206024] [<c0011cdc>] (overo_init+0xe8/0x32c) from [<c000b19c>]
> (customize_machine+0x1c/0x28)
> [    0.206085] [<c000b19c>] (customize_machine+0x1c/0x28) from [<c00333b4>]
> (do_one_initcall+0x98/0x16c)
> [    0.206115] [<c00333b4>] (do_one_initcall+0x98/0x16c) from [<c0008388>]
> (kernel_init+0x8c/0x13c)
> [    0.206146] [<c0008388>] (kernel_init+0x8c/0x13c) from [<c003dd38>]
> (kernel_thread_exit+0x0/0x8)
> [    0.206542] ---[ end trace 1b75b31a2719ed1c ]---
> [    0.206573] smsc911x: failed to claim resource 0
> [    0.206573] Unable to register smsc911x device
> [    0.206604] ------------[ cut here ]------------
> [    0.206634] WARNING: at drivers/gpio/gpiolib.c:1236
> gpmc_smsc911x_init+0x130/0x184()
> [    0.206634] Modules linked in:
> [    0.206665] [<c004258c>] (unwind_backtrace+0x0/0xe4) from [<c0065428>]
> (warn_slowpath_common+0x4c/0x64)
> [    0.206726] [<c0065428>] (warn_slowpath_common+0x4c/0x64) from [<c0065458>]
> (warn_slowpath_null+0x18/0x1c)
> [    0.206756] [<c0065458>] (warn_slowpath_null+0x18/0x1c) from [<c0012914>]
> (gpmc_smsc911x_init+0x130/0x184)
> [    0.206787] [<c0012914>] (gpmc_smsc911x_init+0x130/0x184) from [<c0011cdc>]
> (overo_init+0xe8/0x32c)
> [    0.206848] [<c0011cdc>] (overo_init+0xe8/0x32c) from [<c000b19c>]
> (customize_machine+0x1c/0x28)
> [    0.206878] [<c000b19c>] (customize_machine+0x1c/0x28) from [<c00333b4>]
> (do_one_initcall+0x98/0x16c)
> [    0.206909] [<c00333b4>] (do_one_initcall+0x98/0x16c) from [<c0008388>]
> (kernel_init+0x8c/0x13c)
> [    0.206939] [<c0008388>] (kernel_init+0x8c/0x13c) from [<c003dd38>]
> (kernel_thread_exit+0x0/0x8)
> [    0.206970] ---[ end trace 1b75b31a2719ed1d ]---
> [    0.207031] Could not initialize smsc911x
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
