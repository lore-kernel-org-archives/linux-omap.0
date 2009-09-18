From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: Memory leaks on l-o kernel
Date: Fri, 18 Sep 2009 17:11:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9915B4@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C4C0E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49386 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZIRLlL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 07:41:11 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8IBfDv7013497
	for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2009 06:41:14 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C4C0E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "olbpdev@list.ti.com - OMAP Linux Baseport Development Team (May contain
	non-TIers)" <olbpdev@list.ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

Adding LO list:
(Cc'ng Madhu)
Some additional memory leak (not the one reported by CONFIG_DEBUG_KMEMLEAK):

1. In twl4030_mmc_init struct_ omap_mmc_platform_data is allocated using kzalloc.
2. The pointer to the allocated memory is stored in hsmmc_data which is __initdata (contents will be lost after the init section cleanup).
Now look at this piece of code:

mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
                if (!mmc) {
                        pr_err("Cannot allocate memory for mmc device!\n");
                        return;
                }

This is within a loop. For all but first iteration if kzalloc fails, the function returns and the hsmmc_data is cleaned up (during the init memory cleanup) and pointer to the successfully allocated omap_mmc_platform_data blocks are lost. 

Thanks,
-Romit

>-----Original Message-----
>From: Gadiyar, Anand
>Sent: Friday, September 18, 2009 3:27 PM
>To: olbpdev@list.ti.com - OMAP Linux Baseport Development Team (May contain
>non-TIers)
>Subject: Memory leaks on l-o kernel
>
>I enabled CONFIG_DEBUG_KMEMLEAK on the linux-omap kernel, and at boot it
>throws up this on the SDP:
>
>Worth a look?
>
>kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>
>/ # cat /sys/kernel/debug/kmemleak
>unreferenced object 0xc78e7c00 (size 192):
>  comm "swapper", pid 1, jiffies 4294928994
>  backtrace:
>    [<c002fa38>] save_stack_trace+0x24/0x28
>    [<c00a61b0>] create_object+0x134/0x21c
>    [<c00a63b4>] kmemleak_alloc+0x40/0x84
>    [<c00a3d74>] kmem_cache_alloc+0xa8/0xb8
>    [<c000f224>] twl4030_mmc_init+0x54/0x298
>    [<c003b1d4>] sdp3430_twl_gpio_setup+0x2c/0x84
>    [<c02bfa14>] gpio_twl4030_probe+0x198/0x1b4
>    [<c01c79c0>] platform_drv_probe+0x20/0x24
>    [<c01c6ab8>] driver_probe_device+0xa8/0x154
>    [<c01c6c34>] __device_attach+0x44/0x48
>    [<c01c6044>] bus_for_each_drv+0x50/0x90
>    [<c01c6cbc>] device_attach+0x58/0x70
>    [<c01c5e80>] bus_attach_device+0x30/0x64
>    [<c01c488c>] device_add+0x3fc/0x560
>    [<c01c8044>] platform_device_add+0xfc/0x158
>    [<c01cd5b0>] add_numbered_child+0xe4/0x130
>unreferenced object 0xc78e7d00 (size 192):
>  comm "swapper", pid 1, jiffies 4294928994
>  backtrace:
>    [<c002fa38>] save_stack_trace+0x24/0x28
>    [<c00a61b0>] create_object+0x134/0x21c
>    [<c00a63b4>] kmemleak_alloc+0x40/0x84
>    [<c00a3d74>] kmem_cache_alloc+0xa8/0xb8
>    [<c000f224>] twl4030_mmc_init+0x54/0x298
>    [<c003b1d4>] sdp3430_twl_gpio_setup+0x2c/0x84
>    [<c02bfa14>] gpio_twl4030_probe+0x198/0x1b4
>    [<c01c79c0>] platform_drv_probe+0x20/0x24
>    [<c01c6ab8>] driver_probe_device+0xa8/0x154
>    [<c01c6c34>] __device_attach+0x44/0x48
>    [<c01c6044>] bus_for_each_drv+0x50/0x90
>    [<c01c6cbc>] device_attach+0x58/0x70
>    [<c01c5e80>] bus_attach_device+0x30/0x64
>    [<c01c488c>] device_add+0x3fc/0x560
>    [<c01c8044>] platform_device_add+0xfc/0x158
>    [<c01cd5b0>] add_numbered_child+0xe4/0x130
