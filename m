From: Nishanth Menon <nm@ti.com>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Mon, 6 Apr 2015 10:17:37 -0500
Message-ID: <5522A391.6080503@ti.com>
References: <5522886D.5050409@ti.com> <20150406134541.GE6023@sirena.org.uk> <55228FE0.2040702@ti.com> <20150406135829.GH4027@n2100.arm.linux.org.uk> <20150406150127.GF6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35972 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbbDFPST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2015 11:18:19 -0400
In-Reply-To: <20150406150127.GF6023@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/06/2015 10:01 AM, Mark Brown wrote:
> On Mon, Apr 06, 2015 at 02:58:29PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:
> 
>>>> at least a description of the problem you're seeing and some attempt at
> 
>>> Test was a simple boot test. There seems to be a lockdep reported at the
>>> very least in the log provided (see
>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
>>> ).
> 
>> I think what Mark is trying to say is to include a fuller description of
>> the problem, and don't expect people to fire up their web browser to get
>> a basic overview of what the problem is.
> 
> Yes, indeed.  I hadn't actually opened the links, I might've got round
> to it later on.
> 
>> My guess is that the problem _appears_ to be that someone's added a call
>> to debug_check_no_locks_held() into schedule_hrtimeout_range_clock()
>> without considering what this means.
> 
>> What it means is that you can't now use usleep_range() from within any
>> driver probe function - which is absolutely absurd.
> 
> I can't think of any regulator side changes which might be relevant in
> that period.  It's possible that there might be something in the MFD I
> guess.
> 

Ran a few tests since my original email..

6261b06de565baafa590e58a531a1a5522cea0b6 ("regulator: Defer lookup of
supply to regulator_get") was the only patch that was introduced in
the interval. there seems nothing in mfd either.

I still have the following in my log.. trying to further down.

> [    1.970184] twl 0-0048: power (irq 344) chaining IRQs 347..354
> [    2.007751]
> [    2.009338] =====================================
> [    2.014343] [ BUG: swapper/0/1 still has locks held! ]
> [    2.019744] 4.0.0-rc6-next-20150402-00002-gff1da06adc96 #2 Not tainted
> [    2.026611] -------------------------------------
> [    2.031524] 4 locks held by swapper/0/1:
> [    2.035675]  #0:  (&dev->mutex){......}, at: [<c03d9c1c>] __driver_attach+0x48/0x98 
> [    2.043762]  #1:  (&dev->mutex){......}, at: [<c03d9c2c>] __driver_attach+0x58/0x98 
> [    2.051940]  #2:  (&dev->mutex){......}, at: [<c03d98d8>] device_attach+0x18/0x8c 
> [    2.059875]  #3:  (regulator_list_mutex){+.+.+.}, at: [<c03a239c>] regulator_register+0x14c/0xf64 
> [    2.069274]
> [    2.069274] stack backtrace:
> [    2.073852] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc6-next-20150402-00002-gff1da06adc96 #2 
> [    2.083465] Hardware name: Generic OMAP3 (Flattened Device Tree)
> [    2.089813] [<c0016334>] (unwind_backtrace) from [<c0012878>] (show_stack+0x10/0x14) 
> [    2.097991] [<c0012878>] (show_stack) from [<c05dd5ec>] (dump_stack+0x78/0x94) 
> [    2.105621] [<c05dd5ec>] (dump_stack) from [<c05e3144>] (schedule_hrtimeout_range_clock+0x18c/0x25c) 
> [    2.115234] [<c05e3144>] (schedule_hrtimeout_range_clock) from [<c00a7354>] (usleep_range+0x48/0x50) 
> [    2.124877] [<c00a7354>] (usleep_range) from [<c039fee4>] (_regulator_do_enable+0xa4/0x270) 
> [    2.133605] [<c039fee4>] (_regulator_do_enable) from [<c03a2ce4>] (regulator_register+0xa94/0xf64) 
> [    2.143035] [<c03a2ce4>] (regulator_register) from [<c03a3a90>] (devm_regulator_register+0x38/0x6c) 
> [    2.152587] [<c03a3a90>] (devm_regulator_register) from [<c03a9eac>] (twlreg_probe+0x118/0x29c) 
> [    2.161743] [<c03a9eac>] (twlreg_probe) from [<c03db0ac>] (platform_drv_probe+0x48/0x98) 
> [    2.170257] [<c03db0ac>] (platform_drv_probe) from [<c03d9b18>] (driver_probe_device+0x1b0/0x26c) 
> [    2.179626] [<c03d9b18>] (driver_probe_device) from [<c03d833c>] (bus_for_each_drv+0x5c/0x88) 
> [    2.188598] [<c03d833c>] (bus_for_each_drv) from [<c03d9934>] (device_attach+0x74/0x8c) 
> [    2.197021] [<c03d9934>] (device_attach) from [<c03d9044>] (bus_probe_device+0x88/0xb0) 
> [    2.205444] [<c03d9044>] (bus_probe_device) from [<c03d7564>] (device_add+0x324/0x520)  
> [    2.213745] [<c03d7564>] (device_add) from [<c04c7f64>] (of_platform_device_create_pdata+0x7c/0xb4)  
> [    2.223266] [<c04c7f64>] (of_platform_device_create_pdata) from [<c04c8078>] (of_platform_bus_create+0xdc/0x19
> 0)  
> [    2.233978] [<c04c8078>] (of_platform_bus_create) from [<c04c818c>] (of_platform_populate+0x60/0xa8)  
> [    2.243591] [<c04c818c>] (of_platform_populate) from [<c03fa620>] (twl_probe+0x380/0x5d8)  
> [    2.252197] [<c03fa620>] (twl_probe) from [<c0490bdc>] (i2c_device_probe+0x10c/0x154)  
> [    2.260467] [<c0490bdc>] (i2c_device_probe) from [<c03d9b18>] (driver_probe_device+0x1b0/0x26c)  
> [    2.269622] [<c03d9b18>] (driver_probe_device) from [<c03d9c68>] (__driver_attach+0x94/0x98)  
> [    2.278503] [<c03d9c68>] (__driver_attach) from [<c03d83bc>] (bus_for_each_dev+0x54/0x88)  
> [    2.287109] [<c03d83bc>] (bus_for_each_dev) from [<c03d9240>] (bus_add_driver+0xdc/0x1d4)  
> [    2.295715] [<c03d9240>] (bus_add_driver) from [<c03da43c>] (driver_register+0x78/0xf4)  
> [    2.304107] [<c03da43c>] (driver_register) from [<c0493ebc>] (i2c_register_driver+0x2c/0x78)  
> [    2.312988] [<c0493ebc>] (i2c_register_driver) from [<c0009784>] (do_one_initcall+0x80/0x1d8)  
> [    2.321990] [<c0009784>] (do_one_initcall) from [<c085ce74>] (kernel_init_freeable+0x1f4/0x2cc)  
> [    2.331146] [<c085ce74>] (kernel_init_freeable) from [<c05d8628>] (kernel_init+0x8/0xe4)  
> [    2.339660] [<c05d8628>] (kernel_init) from [<c000f490>] (ret_from_fork+0x14/0x24)  
> [    2.373199] twl4030_gpio twl4030-gpio: gpio (irq 339) chaining IRQs 355..372
> [    2.381103] gpiochip_find_base: found new base at 494
> [    2.386810] gpiochip_add: registered GPIOs 494 to 511 on device: twl4030

-- 
Regards,
Nishanth Menon
