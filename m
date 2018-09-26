From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: switch to use irq_chip pm runtime
Date: Wed, 26 Sep 2018 15:24:50 -0500
Message-ID: <48408c84-793a-bf16-4a59-c9b266a5726f@ti.com>
References: <20180925191446.31504-1-grygorii.strashko@ti.com>
 <20180926171200.GV5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926171200.GV5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org



On 09/26/2018 12:12 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [180925 19:19]:
>> The PM runtime management can be delegated from OMAP GPIO driver to the IRQ
>> chip core, since commit be45beb2df69 ("genirq: Add runtime power management
>> support for IRQ chips") introduces runtime power management support for IRQ
>> chips.
>>
>> Hence, drop custom PM runtime support for OMAP GPIO IRQs and switch to IRQ
>> chip core PM runtime (set irq_chip->parent_device).
> 
> This would be cool but looks like this patch oopses early during boot
> at least on omap3 though, maybe because BANK_USED is not for
> irqs only?

thanks for testing.

>From IRQ chip PM point of view there is unexpected call to HW from 
gpiochip_irq_map()
 irq_set_chip_and_handler(irq, chip->irq.chip, handle_bad_irq);
    irq_set_chip_and_handler_name
	__irq_set_handler
		__irq_do_set_handler
			if (handle == handle_bad_irq) {
				if (desc->irq_data.chip != &no_irq_chip)
					mask_ack_irq(desc); <<--

Not sure, but seems when handler installed first time it's more correct to first
set handler and then chip:
 irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
                              irq_flow_handler_t handle, const char *name)
 {
-       irq_set_chip(irq, chip);
        __irq_set_handler(irq, handle, 0, name);
+       irq_set_chip(irq, chip);
 }

above is also seems more correct when handler uninstalled, otherwise
chip will be set to no_irq_chip first and mask_ack_irq() will not be called
(case 	irq_set_chip_and_handler(irq, NULL, NULL)).

For OMAP GPIO will need to keep pm_runtime calls in irq_bus_lock/unlock.

Will re-send.



> 
> 
> 8< ---------------------
> gpio gpiochip0: (gpio-0-31): added GPIO chardev (254:0)
> gpiochip_setup_dev: registered GPIOs 0 to 31 on device: gpiochip0 (gpio-0-31)
> OMAP GPIO hardware version 2.5
> gpio gpiochip1: (gpio-32-63): added GPIO chardev (254:1)
> gpiochip_setup_dev: registered GPIOs 32 to 63 on device: gpiochip1 (gpio-32-63)
> gpio gpiochip2: (gpio-64-95): added GPIO chardev (254:2)
> gpiochip_setup_dev: registered GPIOs 64 to 95 on device: gpiochip2 (gpio-64-95)
> gpio gpiochip3: (gpio-96-127): added GPIO chardev (254:3)
> gpiochip_setup_dev: registered GPIOs 96 to 127 on device: gpiochip3 (gpio-96-127)
> gpio gpiochip4: (gpio-128-159): added GPIO chardev (254:4)
> gpiochip_setup_dev: registered GPIOs 128 to 159 on device: gpiochip4 (gpio-128-159)
> gpio gpiochip5: (gpio-160-191): added GPIO chardev (254:5)
> gpiochip_setup_dev: registered GPIOs 160 to 191 on device: gpiochip5 (gpio-160-191)
> omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> gpiochip_find_base: found new base at 508
> gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
> gpiochip_setup_dev: registered GPIOs 508 to 511 on device: gpiochip6 (omap-gpmc)
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfb056028
> pgd = (ptrval)
> [fb056028] *pgd=49011452(bad)
> Internal error: : 1028 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc4+ #4913
> Hardware name: Generic OMAP36xx (Flattened Device Tree)
> PC is at omap_gpio_ack_irq+0x54/0x5c
> LR is at omap_gpio_ack_irq+0x20/0x5c
> pc : [<c05bc6cc>]    lr : [<c05bc698>]    psr: 200000d3
> sp : c7103718  ip : 00000001  fp : c710372c
> r10: c72b2860  r9 : c17028b8  r8 : 00000000
> r7 : 00000000  r6 : c01c4418  r5 : 00000000  r4 : c7297414
> r3 : fb056028  r2 : 00000002  r1 : 00000028  r0 : fb056000
> Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 80004019  DAC: 00000051
> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> ...
> [<c05bc6cc>] (omap_gpio_ack_irq) from [<c01c9470>] (__irq_do_set_handler+0x1c0/0x1e4)
> [<c01c9470>] (__irq_do_set_handler) from [<c01c94ec>] (__irq_set_handler+0x58/0x88)
> [<c01c94ec>] (__irq_set_handler) from [<c01c9554>] (irq_set_chip_and_handler_name+0x38/0x3c)
> [<c01c9554>] (irq_set_chip_and_handler_name) from [<c05b3fd4>] (gpiochip_irq_map+0x94/0x13c)
> [<c05b3fd4>] (gpiochip_irq_map) from [<c01cc7e0>] (irq_domain_associate+0x80/0x1c0)
> [<c01cc7e0>] (irq_domain_associate) from [<c01cd210>] (irq_create_mapping+0x74/0xdc)
> [<c01cd210>] (irq_create_mapping) from [<c01cd904>] (irq_create_fwspec_mapping+0x15c/0x338)
> [<c01cd904>] (irq_create_fwspec_mapping) from [<c01cdb48>] (irq_create_of_mapping+0x68/0x88)
> [<c01cdb48>] (irq_create_of_mapping) from [<c07cb038>] (of_irq_get+0x74/0xc4)
> [<c07cb038>] (of_irq_get) from [<c07cb0bc>] (of_irq_to_resource+0x34/0xe8)
> [<c07cb0bc>] (of_irq_to_resource) from [<c07cb1b8>] (of_irq_to_resource_table+0x48/0x5c)
> [<c07cb1b8>] (of_irq_to_resource_table) from [<c07c625c>] (of_device_alloc+0xf8/0x294)
> [<c07c625c>] (of_device_alloc) from [<c07c6450>] (of_platform_device_create_pdata+0x58/0xc8)
> [<c07c6450>] (of_platform_device_create_pdata) from [<c07c64e0>] (of_platform_device_create+0x20/0x24)
> [<c07c64e0>] (of_platform_device_create) from [<c07d1d68>] (gpmc_probe_generic_child+0x2ec/0x990)
> [<c07d1d68>] (gpmc_probe_generic_child) from [<c07d27ec>] (gpmc_probe+0x3e0/0x5a8)
> [<c07d27ec>] (gpmc_probe) from [<c067d0e8>] (platform_drv_probe+0x58/0xa8)
> [<c067d0e8>] (platform_drv_probe) from [<c067aa44>] (really_probe+0x200/0x2cc)
> [<c067aa44>] (really_probe) from [<c067ace0>] (driver_probe_device+0x6c/0x174)
> [<c067ace0>] (driver_probe_device) from [<c067afa0>] (__device_attach_driver+0xc0/0xe4)
> [<c067afa0>] (__device_attach_driver) from [<c0678a3c>] (bus_for_each_drv+0x8c/0xd4)
> [<c0678a3c>] (bus_for_each_drv) from [<c067a7b4>] (__device_attach+0xdc/0x14c)
> [<c067a7b4>] (__device_attach) from [<c067b020>] (device_initial_probe+0x1c/0x20)
> [<c067b020>] (device_initial_probe) from [<c0679a70>] (bus_probe_device+0x98/0xa0)
> [<c0679a70>] (bus_probe_device) from [<c06762b4>] (device_add+0x364/0x628)
> [<c06762b4>] (device_add) from [<c07c5f1c>] (of_device_add+0x40/0x48)
> [<c07c5f1c>] (of_device_add) from [<c07c6494>] (of_platform_device_create_pdata+0x9c/0xc8)
> [<c07c6494>] (of_platform_device_create_pdata) from [<c07c66e4>] (of_platform_bus_create+0x1b4/0x254)
> [<c07c66e4>] (of_platform_bus_create) from [<c07c6730>] (of_platform_bus_create+0x200/0x254)
> [<c07c6730>] (of_platform_bus_create) from [<c07c68d4>] (of_platform_populate+0x6c/0xbc)
> [<c07c68d4>] (of_platform_populate) from [<c0e14284>] (pdata_quirks_init+0x7c/0xa0)
> [<c0e14284>] (pdata_quirks_init) from [<c0e13c40>] (omap_generic_init+0x1c/0x28)
> [<c0e13c40>] (omap_generic_init) from [<c0e04474>] (customize_machine+0x2c/0x38)
> [<c0e04474>] (customize_machine) from [<c0103390>] (do_one_initcall+0x90/0x398)
> [<c0103390>] (do_one_initcall) from [<c0e01494>] (kernel_init_freeable+0x478/0x558)
> [<c0e01494>] (kernel_init_freeable) from [<c09aad78>] (kernel_init+0x18/0x124)
> [<c09aad78>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> Exception stack(0xc7103fb0 to 0xc7103ff8)
> 3fa0:                                     00000000 00000000 00000000 00000000
> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e3510000 0a000001 e0803001 e5832000 (e5933000)
> ---[ end trace 43f0b1bf9cbb2007 ]---
> 

-- 
regards,
-grygorii
