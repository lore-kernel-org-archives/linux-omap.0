From: Roger Quadros <rogerq@ti.com>
Subject: Re: gpio: pcf857x: lockdep warning on v4.10-rc3
Date: Wed, 11 Jan 2017 17:55:25 +0200
Message-ID: <c62b749f-43c5-0f70-78f1-88977f8817cc@ti.com>
References: <48bef841-5267-fcdb-2398-095f6f7ae51e@ti.com>
 <6939c67f-f414-c022-85e3-4e8d8912fb34@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6939c67f-f414-c022-85e3-4e8d8912fb34@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Grygorii,

On 10/01/17 22:00, Grygorii Strashko wrote:
> Hi
> 
> On 01/10/2017 06:18 AM, Roger Quadros wrote:
>> Hi Linus,
>>
>> I see the following lockdep warning on v4.10-rc3 on TI's dra7-evm.
>>
>> reverting (d245b3f9bd3 "gpio: simplify adding threaded interrupts") seems to fix it.
>>
>>
>> [    2.358337] ------------[ cut here ]------------
>> [    2.363194] WARNING: CPU: 1 PID: 76 at kernel/locking/lockdep.c:3124 gpiochip_irq_map+0x40/0xa4
>> [    2.372350] DEBUG_LOCKS_WARN_ON(!key)
>> [    2.372354] Modules linked in:
>> [    2.379407] CPU: 1 PID: 76 Comm: kworker/1:1 Not tainted 4.10.0-rc3 #1075
>> [    2.386527] Hardware name: Generic DRA74X (Flattened Device Tree)
>> [    2.392920] Workqueue: events deferred_probe_work_func
>> [    2.398323] [<c011013c>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
>> [    2.406445] [<c010c300>] (show_stack) from [<c04a0018>] (dump_stack+0xac/0xe0)
>> [    2.414030] [<c04a0018>] (dump_stack) from [<c013700c>] (__warn+0xd8/0x104)
>> [    2.421344] [<c013700c>] (__warn) from [<c013706c>] (warn_slowpath_fmt+0x34/0x44)
>> [    2.429203] [<c013706c>] (warn_slowpath_fmt) from [<c04dd8a4>] (gpiochip_irq_map+0x40/0xa4)
>> [    2.437969] [<c04dd8a4>] (gpiochip_irq_map) from [<c01acc50>] (irq_domain_associate+0x70/0x1c0)
>> [    2.447102] [<c01acc50>] (irq_domain_associate) from [<c01ad51c>] (irq_create_mapping+0x64/0xcc)
>> [    2.456313] [<c01ad51c>] (irq_create_mapping) from [<c04dd6b8>] (_gpiochip_irqchip_add+0xd8/0x1a8)
>> [    2.465725] [<c04dd6b8>] (_gpiochip_irqchip_add) from [<c04e5b00>] (pcf857x_probe+0x260/0x38c)
>> [    2.474754] [<c04e5b00>] (pcf857x_probe) from [<c0633d30>] (i2c_device_probe+0x200/0x25c)
>> [    2.483332] [<c0633d30>] (i2c_device_probe) from [<c055d3ec>] (driver_probe_device+0x200/0x2d4)
>> [    2.492456] [<c055d3ec>] (driver_probe_device) from [<c055b914>] (bus_for_each_drv+0x64/0x98)
>> [    2.501396] [<c055b914>] (bus_for_each_drv) from [<c055d108>] (__device_attach+0xb0/0x118)
>> [    2.510062] [<c055d108>] (__device_attach) from [<c055c730>] (bus_probe_device+0x88/0x90)
>> [    2.518639] [<c055c730>] (bus_probe_device) from [<c055aa9c>] (device_add+0x3e4/0x59c)
>> [    2.526938] [<c055aa9c>] (device_add) from [<c06362cc>] (i2c_new_device+0x144/0x1a4)
>> [    2.535064] [<c06362cc>] (i2c_new_device) from [<c0636900>] (i2c_register_adapter+0x278/0x5a4)
>> [    2.544101] [<c0636900>] (i2c_register_adapter) from [<c0638aa4>] (omap_i2c_probe+0x4bc/0x6a0)
>> [    2.553141] [<c0638aa4>] (omap_i2c_probe) from [<c055f390>] (platform_drv_probe+0x4c/0xb0)
>> [    2.561808] [<c055f390>] (platform_drv_probe) from [<c055d3ec>] (driver_probe_device+0x200/0x2d4)
>> [    2.571120] [<c055d3ec>] (driver_probe_device) from [<c055b914>] (bus_for_each_drv+0x64/0x98)
>> [    2.580065] [<c055b914>] (bus_for_each_drv) from [<c055d108>] (__device_attach+0xb0/0x118)
>> [    2.588732] [<c055d108>] (__device_attach) from [<c055c730>] (bus_probe_device+0x88/0x90)
>> [    2.597320] [<c055c730>] (bus_probe_device) from [<c055cc10>] (deferred_probe_work_func+0x6c/0x9c)
>> [    2.606719] [<c055cc10>] (deferred_probe_work_func) from [<c0154dfc>] (process_one_work+0x1fc/0x76c)
>> [    2.616298] [<c0154dfc>] (process_one_work) from [<c0155598>] (worker_thread+0x22c/0x540)
>> [    2.624885] [<c0155598>] (worker_thread) from [<c015b918>] (kthread+0xf8/0x138)
>> [    2.632547] [<c015b918>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)
>> [    2.640162] ---[ end trace a0ca4c6c0c9a9ee8 ]---
>> [    2.646111] pcf857x 0-0020: probed
>> [    2.650052] gpiochip_find_base: found new base at 478
>> [    2.655386] gpio gpiochip10: (pcf8575): added GPIO chardev (254:10)
>> [    2.662262] gpiochip_setup_dev: registered GPIOs 478 to 493 on device: gpiochip10 (pcf8575)
>> [    2.672058] pcf857x 0-0021: probed
>>
> 
> I expect below patch will fix an issue. Could you try it?

Yes it fixes the issue.

--
cheers,
-roger
