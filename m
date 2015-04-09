From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: OMAP: 4.0-rc7: dma_async_device_register issue
Date: Thu, 9 Apr 2015 16:17:26 +0200
Message-ID: <CAGm1_kv8NW-Ld8oe5JD6BbAmfS4bqpw05H82aWtE2p8fX6i8fw@mail.gmail.com>
References: <CAGm1_kuo2KSK7d=SNY_w6m3Medu_Vvj-YRwkZfTJUKQ4+G7=fQ@mail.gmail.com>
 <20150409133703.GA4149@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35342 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbbDIORr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2015 10:17:47 -0400
Received: by pddn5 with SMTP id n5so154456866pdd.2
        for <linux-omap@vger.kernel.org>; Thu, 09 Apr 2015 07:17:46 -0700 (PDT)
In-Reply-To: <20150409133703.GA4149@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Apr 9, 2015 at 3:37 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Apr 09, 2015 at 10:42:15AM +0200, Yegor Yefremov wrote:
>> I see this during the boot:
>>
>> platform musb-hdrc.1.auto: Driver musb-hdrc requests probe deferral
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at drivers/dma/dmaengine.c:863
>> dma_async_device_register+0x2a8/0x4d8()
>> this driver doesn't support generic slave capabilities reporting
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc7 #1
>> Hardware name: Generic AM33XX (Flattened Device Tree)
>> [<c0015ce4>] (unwind_backtrace) from [<c0012370>] (show_stack+0x10/0x14)
>> [<c0012370>] (show_stack) from [<c05f7a2c>] (dump_stack+0x84/0x9c)
>> [<c05f7a2c>] (dump_stack) from [<c003d868>] (warn_slowpath_common+0x7c/0xb8)
>> [<c003d868>] (warn_slowpath_common) from [<c003d8d4>]
>> (warn_slowpath_fmt+0x30/0x40)
>> [<c003d8d4>] (warn_slowpath_fmt) from [<c02dd5f8>]
>> (dma_async_device_register+0x2a8/0x4d8)
>> [<c02dd5f8>] (dma_async_device_register) from [<c02e1a14>]
>> (cppi41_dma_probe+0x3f4/0x470)
>> [<c02e1a14>] (cppi41_dma_probe) from [<c032152c>] (platform_drv_probe+0x44/0xa4)
>> [<c032152c>] (platform_drv_probe) from [<c031fc48>]
>> (driver_probe_device+0x104/0x23c)
>> [<c031fc48>] (driver_probe_device) from [<c031e27c>]
>> (bus_for_each_drv+0x64/0x98)
>> [<c031e27c>] (bus_for_each_drv) from [<c031fb10>] (device_attach+0x74/0x8c)
>> [<c031fb10>] (device_attach) from [<c031f1f4>] (bus_probe_device+0x88/0xb0)
>> [<c031f1f4>] (bus_probe_device) from [<c031d56c>] (device_add+0x378/0x520)
>> [<c031d56c>] (device_add) from [<c045c588>]
>> (of_platform_device_create_pdata+0xe8/0x144)
>> [<c045c588>] (of_platform_device_create_pdata) from [<c045c6cc>]
>> (of_platform_bus_create+0xdc/0x18c)
>> [<c045c6cc>] (of_platform_bus_create) from [<c045c8a8>]
>> (of_platform_populate+0x5c/0xac)
>> [<c045c8a8>] (of_platform_populate) from [<c0402a7c>]
>> (am335x_child_probe+0x28/0x44)
>> [<c0402a7c>] (am335x_child_probe) from [<c032152c>]
>> (platform_drv_probe+0x44/0xa4)
>> [<c032152c>] (platform_drv_probe) from [<c031fc48>]
>> (driver_probe_device+0x104/0x23c)
>> [<c031fc48>] (driver_probe_device) from [<c031fe58>] (__driver_attach+0x94/0x98)
>> [<c031fe58>] (__driver_attach) from [<c031e1d0>] (bus_for_each_dev+0x6c/0xa0)
>> [<c031e1d0>] (bus_for_each_dev) from [<c031f46c>] (bus_add_driver+0x144/0x1f0)
>> [<c031f46c>] (bus_add_driver) from [<c03205b0>] (driver_register+0x78/0xf8)
>> [<c03205b0>] (driver_register) from [<c0008b84>] (do_one_initcall+0x80/0x1dc)
>> [<c0008b84>] (do_one_initcall) from [<c087fd88>]
>> (kernel_init_freeable+0x110/0x1d8)
>> [<c087fd88>] (kernel_init_freeable) from [<c05f472c>] (kernel_init+0x8/0xec)
>> [<c05f472c>] (kernel_init) from [<c000e910>] (ret_from_fork+0x14/0x24)
>> ---[ end trace e3462ce3acfe8469 ]---
>>
>> So far I could only find this patch, but it is
>> drivers/dma/qcom_bam_dma.c related: https://lkml.org/lkml/2015/3/5/324
>>
>> My DTS: https://github.com/visionsystemsgmbh/onrisc_br_bsp/blob/master/board/vscom/dts/3.15/onrisc-baltos-ir-5221.dts
>
> try this patch:
>
> https://marc.info/?l=linux-usb&m=142851161717345&w=2

Thanks. It's working.

Yegor
