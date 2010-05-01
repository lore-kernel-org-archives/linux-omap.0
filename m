From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 3/3] DSPBRIDGE: remove hw_prcm module and related 	functions
Date: Sat, 01 May 2010 10:34:08 -0500
Message-ID: <4BDC49F0.6050505@gmail.com>
References: <AcrVsjYetIHyTxGhSQuU4kCXDj8zwQ==>	 <496565EC904933469F292DDA3F1663E602CAF98C66@dlee06.ent.ti.com> <g2p94a0d4531005010827x1fc649c0h4bcbf2f1afbccb07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:35923 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0EAPeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 11:34:15 -0400
Received: by yxe1 with SMTP id 1so300532yxe.33
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 08:34:13 -0700 (PDT)
In-Reply-To: <g2p94a0d4531005010827x1fc649c0h4bcbf2f1afbccb07@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On 05/01/2010 10:27 AM, Felipe Contreras wrote:
> On Tue, Apr 6, 2010 at 8:54 PM, Guzman Lugo, Fernando<x0095840@ti.com>  wrote:
>>  From 4fb9fc015cea65dcd47172a8b180f380fe86be46 Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo<x0095840@ti.com>
>> Date: Tue, 30 Mar 2010 21:37:21 -0600
>> Subject: [PATCH] DSPBRIDGE: remove hw_prcm module and related functions
>>
>> This patches removes TI hw_prcm module and related functions
>> and replace them with kernel functions. As kernel functions
>> are exported, pointer function are used to build without
>> problem in case of building dspbridge as a module.
>>
>> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
>
> This is screwing things for me on a beagleboard:
>
> mem_ext_phys_pool_init: external physical memory map failed
this is interesting -> we ran out of IOremap memory??

> ------------[ cut here ]------------
> WARNING: at mm/page_alloc.c:1813 __alloc_pages_nodemask+0x144/0x514()
> Modules linked in: bridgedriver(+) mailbox_mach mailbox
> [<c002c3a0>] (unwind_backtrace+0x0/0xd4) from [<c004ce38>]
> (warn_slowpath_common+0x48/0x60)
> [<c004ce38>] (warn_slowpath_common+0x48/0x60) from [<c007cef0>]
> (__alloc_pages_nodemask+0x144/0x514)
> [<c007cef0>] (__alloc_pages_nodemask+0x144/0x514) from [<c002cafc>]
> (__dma_alloc+0xc0/0x27c)
> [<c002cafc>] (__dma_alloc+0xc0/0x27c) from [<c002cd30>]
> (dma_alloc_coherent+0x54/0x60)
> [<c002cd30>] (dma_alloc_coherent+0x54/0x60) from [<bf00d7f8>]
> (mem_alloc_phys_mem+0xb0/0xcc [bridgedriver])
> [<bf00d7f8>] (mem_alloc_phys_mem+0xb0/0xcc [bridgedriver]) from
> [<bf01d530>] (drv_request_resources+0x1bc/0x260 [bridgedriver])
> [<bf01d530>] (drv_request_resources+0x1bc/0x260 [bridgedriver]) from
> [<bf023370>] (dsp_init+0x64/0xe8 [bridgedriver])
> [<bf023370>] (dsp_init+0x64/0xe8 [bridgedriver]) from [<bf028da8>]
> (omap34_xx_bridge_probe+0x208/0x2d0 [bridgedriver])
> [<bf028da8>] (omap34_xx_bridge_probe+0x208/0x2d0 [bridgedriver]) from
> [<c01b3550>] (platform_drv_probe+0x18/0x1c)
> [<c01b3550>] (platform_drv_probe+0x18/0x1c) from [<c01b2748>]
> (driver_probe_device+0xa0/0x14c)
> [<c01b2748>] (driver_probe_device+0xa0/0x14c) from [<c01b2854>]
> (__driver_attach+0x60/0x84)
> [<c01b2854>] (__driver_attach+0x60/0x84) from [<c01b201c>]
> (bus_for_each_dev+0x44/0x74)
> [<c01b201c>] (bus_for_each_dev+0x44/0x74) from [<c01b1988>]
> (bus_add_driver+0x9c/0x218)
> [<c01b1988>] (bus_add_driver+0x9c/0x218) from [<c01b2b24>]
> (driver_register+0xa8/0x134)
> [<c01b2b24>] (driver_register+0xa8/0x134) from [<c0026330>]
> (do_one_initcall+0x58/0x1a8)
> [<c0026330>] (do_one_initcall+0x58/0x1a8) from [<c00713c8>]
> (sys_init_module+0xb0/0x1dc)
> [<c00713c8>] (sys_init_module+0xb0/0x1dc) from [<c0026dc0>]
> (ret_fast_syscall+0x0/0x2c)
> ---[ end trace ec6c9b46b6f26ea2 ]---
> shm reservation Failed
> cfg_get_dev_object: Failed, status 0xffffffff
> DSP Bridge driver initialization failed
>

