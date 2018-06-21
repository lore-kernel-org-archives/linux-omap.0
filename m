From: Roger Quadros <rogerq@ti.com>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Date: Thu, 21 Jun 2018 17:53:41 +0300
Message-ID: <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com>
 <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
 <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
 <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Morris <samorris@lexmark.com>
Cc: Tony Lindgren <tony@atomide.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, Tejun Heo <tj@kernel.org>, linux-omap@vger.kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org, Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 21/06/18 17:31, Samuel Morris wrote:
> On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wrote:
>> +Rafael
>>
>> On 20/06/18 18:30, Samuel Morris wrote:
>>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:
>>>> Tony,
>>>>
>>>> On 20/06/18 13:29, Tony Lindgren wrote:
>>>>> Hi,
>>>>>
>>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:
>>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.
>>>>>
>>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
>>>>> hotplug to save power").
>>>>>
>>>>> Reverting the patch makes things work again. Any ideas what
>>>>> might be going wrong here? Things clearly idle but then there
>>>>> seems to be some register access with clocks disabled.
>>>>
>>>> The commit is doing this in probe.
>>>>
>>>> +       pm_runtime_set_active(dev);
>>>>         pm_runtime_enable(dev);
>>>> -       pm_runtime_get_sync(dev);
>>>> +       pm_runtime_forbid(dev);
>>>>
>>>> On OMAP, the device is not guaranteed to be active at probe and so we can't
>>>> say pm_runtime_set_active() and get rid of pm_runtime_get_sync().
>>>
>>> Okay, by calling set_active(), I'm preventing the rpm_resume from
>>> completing that would normally happen in pm_runtime_forbid(). I assume
>>> you mean that there are parent devices that need to be resumed before
>>
>> Actually, in the OMAP case, the AHCI controller device isn't active when probe is called.
>> For other platforms this might not be the case. So we need to be careful here.
>>
>>> this device may be assumed active. I'm going to try removing the
>>> set_active(), then move that clause to the end of
>>> ahci_platform_init_host(). The pm_runtime_forbid() is effectively the
>>> same as get_sync(), it just also sets the runtime_auto flag to false.
>>> I don't think we should be saying the device is active until the host
>>> is initialized, so that seems like a better, common place for the
>>> pm_runtime init callbacks anyway. How does that sound?
>>
>> Device active and initialized are different things. If the device is powered up
>> and can be accessed it is active, even if it is not yet initialized.
>> I don't think we should club the two.
>>
>> Why do you need to call pm_runtime_set_active() at all in the probe sequence?
> 
> What I meant was, I'm not going to call pm_runtime_set_active()
> anymore. The device status would be changed to RPM_ACTIVE at the end
> of rpm_resume() in either runtime_get() or runtime_forbid(). It is
> expected to be active after those have been called. Calling
> set_active() before the runtime_forbid() before was to prevent the
> device from actually calling the resume() callbacks, because the host
> had not yet been initialized, and resuming the host at that point was
> causing hangs. I was hoping that actually doing a runtime_resume()
> after the host has been initialized would work, and make all parent
> devices happy, though I am turning on a host that's already on and
> initialized. It should be just about the same as what was there
> before, just runtime_forbid() replacing get_sync(), and all that moved
> to the ahci_platform_init_host() function.
> 
> Now that I think about it though, I want all the parent devices
> resumed before I resume the current device, and probably before host
> initialization, and I suspect that's why you need to call
> runtime_get_sync(). Maybe I should just put the
> ahci_platform_init_host() in the runtime_resume callback, and only run
> it the first time that resume() is called. That would require
> modifying all drivers that call ahci_platform_init_host() though. Or,
> I could just not call ahci_platform_resume_host() on the first
> runtime_resume(). That seems like the simplest solution. How about
> that?

This approach is quirky and might not work properly on all platforms.

As Rafael mentioned, we can't really assume weather the device was active
or not during probe. It might be active on some platforms and not on others.

We need a way for the driver to figure out what's the actual hardware state
and then execute a pm_runtime_get_sync() if it is not active during probe.

I don't know how though. DT flag maybe?

> 
>>
>> Documentation for pm_runtime_set_active() says,
>> "(it is only valid to use this function if 'power.runtime_error' is set
>> or 'power.disable_depth' is greater than zero);"
>>
>>>
>>>>
>>>>
>>>>>
>>>>>> Full log of trace please refer this link,
>>>>>> https://lkft.validation.linaro.org/scheduler/job/291535#L946
>>>>>>
>>>>>> Here is back trace,
>>>>>> [    3.561640] omap_rng 48090000.rng: Random Number Generator ver. 20
>>>>>> [    3.611949] brd: module loaded
>>>>>> [    3.641298] loop: module loaded
>>>>>> [    3.646435] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
>>>>>> [    3.658481] ------------[ cut here ]------------
>>>>>> [    3.663196] WARNING: CPU: 0 PID: 1 at
>>>>>> /srv/oe/build/tmp-rpb-glibc/work-shared/am57xx-evm/kernel-source/drivers/bus/omap_l3_noc.c:147
>>>>>> l3_interrupt_handler+0x27c/0x39c
>>>>>> [    3.678052] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_CFG
>>>>>> (Read): Data Access in User mode during Functional access
>>>>>> [    3.689330] Modules linked in:
>>>>>> [    3.692426] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>>>>>> 4.18.0-rc1-next-20180619 #1
>>>>>> [    3.699952] Hardware name: Generic DRA74X (Flattened Device Tree)
>>>>>> [    3.706099] [<c04156f0>] (unwind_backtrace) from [<c040eec4>]
>>>>>> (show_stack+0x20/0x24)
>>>>>> [    3.713897] [<c040eec4>] (show_stack) from [<c116a668>]
>>>>>> (dump_stack+0xb0/0xdc)
>>>>>> [    3.721171] [<c116a668>] (dump_stack) from [<c0450a14>] (__warn+0x118/0x130)
>>>>>> [    3.728270] [<c0450a14>] (__warn) from [<c0450a84>]
>>>>>> (warn_slowpath_fmt+0x58/0x74)
>>>>>> [    3.735808] [<c0450a84>] (warn_slowpath_fmt) from [<c08be648>]
>>>>>> (l3_interrupt_handler+0x27c/0x39c)
>>>>>> [    3.744742] [<c08be648>] (l3_interrupt_handler) from [<c04cd270>]
>>>>>> (__handle_irq_event_percpu+0x90/0x45c)
>>>>>> [    3.754286] [<c04cd270>] (__handle_irq_event_percpu) from
>>>>>> [<c04cd678>] (handle_irq_event_percpu+0x3c/0x8c)
>>>>>> [    3.764001] [<c04cd678>] (handle_irq_event_percpu) from
>>>>>> [<c04cd710>] (handle_irq_event+0x48/0x6c)
>>>>>> [    3.772933] [<c04cd710>] (handle_irq_event) from [<c04d170c>]
>>>>>> (handle_fasteoi_irq+0xb0/0x164)
>>>>>> [    3.781513] [<c04d170c>] (handle_fasteoi_irq) from [<c04cc344>]
>>>>>> (generic_handle_irq+0x34/0x44)
>>>>>> [    3.790183] [<c04cc344>] (generic_handle_irq) from [<c04cca48>]
>>>>>> (__handle_domain_irq+0x6c/0xc4)
>>>>>> [    3.798941] [<c04cca48>] (__handle_domain_irq) from [<c0402528>]
>>>>>> (gic_handle_irq+0x68/0xac)
>>>>>> [    3.807347] [<c0402528>] (gic_handle_irq) from [<c04019bc>]
>>>>>> (__irq_svc+0x5c/0x7c)
>>>>>> [    3.814874] Exception stack(0xee179c70 to 0xee179cb8)
>>>>>> [    3.819963] 9c60:                                     fc140000
>>>>>> ee3e2f10 ee3a9810 00000000
>>>>>> [    3.828189] 9c80: 00000000 ee3e2f10 fc140004 fc140000 ee3a9800
>>>>>> ee3a9810 00000000 ee179cdc
>>>>>> [    3.836414] 9ca0: ee179ce0 ee179cc0 c0c3b364 c0c3b2ec 60000013 ffffffff
>>>>>> [    3.843079] [<c04019bc>] (__irq_svc) from [<c0c3b2ec>]
>>>>>> (ahci_enable_ahci+0x24/0x70)
>>>>>> [    3.850789] [<c0c3b2ec>] (ahci_enable_ahci) from [<c0c3b364>]
>>>>>> (ahci_save_initial_config+0x2c/0x388)
>>>>>> [    3.859894] [<c0c3b364>] (ahci_save_initial_config) from
>>>>>> [<c0c3cbdc>] (ahci_platform_init_host+0x9c/0x4f4)
>>>>>> [    3.869609] [<c0c3cbdc>] (ahci_platform_init_host) from
>>>>>> [<c0c3c33c>] (ahci_probe+0xa0/0xc0)
>>>>>> [    3.878018] [<c0c3c33c>] (ahci_probe) from [<c0ba40f0>]
>>>>>> (platform_drv_probe+0x58/0xac)
>>>>>> [    3.885989] [<c0ba40f0>] (platform_drv_probe) from [<c0ba1aec>]
>>>>>> (driver_probe_device+0x25c/0x338)
>>>>>> [    3.894915] [<c0ba1aec>] (driver_probe_device) from [<c0ba1cbc>]
>>>>>> (__driver_attach+0xf4/0xf8)
>>>>>> [    3.903411] [<c0ba1cbc>] (__driver_attach) from [<c0b9f9ac>]
>>>>>> (bus_for_each_dev+0x78/0xc4)
>>>>>> [    3.911643] [<c0b9f9ac>] (bus_for_each_dev) from [<c0ba13b8>]
>>>>>> (driver_attach+0x2c/0x30)
>>>>>> [    3.919696] [<c0ba13b8>] (driver_attach) from [<c0ba0cfc>]
>>>>>> (bus_add_driver+0x114/0x220)
>>>>>> [    3.927752] [<c0ba0cfc>] (bus_add_driver) from [<c0ba2e2c>]
>>>>>> (driver_register+0x88/0x11c)
>>>>>> [    3.935896] [<c0ba2e2c>] (driver_register) from [<c0ba4044>]
>>>>>> (__platform_driver_register+0x50/0x58)
>>>>>> [    3.945003] [<c0ba4044>] (__platform_driver_register) from
>>>>>> [<c1aa9cf0>] (ahci_driver_init+0x24/0x28)
>>>>>> [    3.954195] [<c1aa9cf0>] (ahci_driver_init) from [<c0403a8c>]
>>>>>> (do_one_initcall+0x9c/0x434)
>>>>>> [    3.962517] [<c0403a8c>] (do_one_initcall) from [<c1a01410>]
>>>>>> (kernel_init_freeable+0x3b8/0x53c)
>>>>>> [    3.971276] [<c1a01410>] (kernel_init_freeable) from [<c118551c>]
>>>>>> (kernel_init+0x18/0x128)
>>>>>> [    3.979597] [<c118551c>] (kernel_init) from [<c04010ac>]
>>>>>> (ret_from_fork+0x14/0x28)
>>>>>> [    3.987210] Exception stack(0xee179fb0 to 0xee179ff8)
>>>>>> [    3.992298] 9fa0:                                     00000000
>>>>>> 00000000 00000000 00000000
>>>>>> [    4.000524] 9fc0: 00000000 00000000 00000000 00000000 00000000
>>>>>> 00000000 00000000 00000000
>>>>>> [    4.008750] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>>>>> [    4.015405] irq event stamp: 663130
>>>>>> [    4.018926] hardirqs last  enabled at (663129): [<c118d9d4>]
>>>>>> _raw_spin_unlock_irqrestore+0x40/0x6c
>>>>>> [    4.027939] hardirqs last disabled at (663130): [<c04019ac>]
>>>>>> __irq_svc+0x4c/0x7c
>>>>>> [    4.035384] softirqs last  enabled at (661486): [<c0402c98>]
>>>>>> __do_softirq+0x2a8/0x5e8
>>>>>> [    4.043262] softirqs last disabled at (661449): [<c04594a4>]
>>>>>> irq_exit+0x178/0x1a4
>>>>>> [    4.050826] ---[ end trace 095abac70926448f ]---
>>>>>>
>>>>>> Best regards
>>>>>> Naresh Kamboju
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>> --
>>>> cheers,
>>>> -roger
>>>>
>>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
>> --
>> cheers,
>> -roger
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
