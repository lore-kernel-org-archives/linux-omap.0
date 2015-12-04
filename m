From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 12:44:04 +0200
Message-ID: <56616E74.9000604@ti.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com> <56608B72.1040101@ti.com>
 <20151203213715.GA23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151203213715.GA23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/03/2015 11:37 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [151203 10:36]:
>>
>> I think, this patch should not break our wake-up functionality.
>> It will just change the moment when pcs_irq_handler() will be called:
>>
>> before this change:
>> - suspend_enter()
>>    ....
>>    - arch_suspend_enable_irqs();
>>      - ^ right here
>>
>> after this change:
>> - suspend_enter()
>>    ....
>>    dpm_resume_noirq()
>>    - resume_device_irqs()
>>      ^ here
>>
>> Correct? And as for me this is more safe.
>
> I think there's more to it though. With both applied, it produces this on
> coming back up from suspend:
>
> PM: noirq resume of devices complete after 18.127 msecs
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 123 at kernel/irq/manage.c:605 irq_set_irq_wake+0xbc/0xfc()
> Unbalanced IRQ 375 wake disable
> Modules linked in: ledtrig_default_on leds_gpio led_class rtc_twl twl4030_wdt
> CPU: 0 PID: 123 Comm: bash Tainted: G        W       4.4.0-rc3-dirty #2682
> Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [<c0017df0>] (unwind_backtrace) from [<c0014084>] (show_stack+0x10/0x14)
> <c0014084>] (show_stack) from [<c03492d0>] (dump_stack+0x84/0x9c)
> [<c03492d0>] (dump_stack) from [<c003ca2c>] (warn_slowpath_common+0x7c/0xb8)
> [<c003ca2c>] (warn_slowpath_common) from [<c003ca98>] (warn_slowpath_fmt+0x30/0x40)
> [<c003ca98>] (warn_slowpath_fmt) from [<c009b66c>] (irq_set_irq_wake+0xbc/0xfc)
> [<c009b66c>] (irq_set_irq_wake) from [<c03f0f1c>] (device_wakeup_disarm_wake_irqs+0x70/0x12c)
> [<c03f0f1c>] (device_wakeup_disarm_wake_irqs) from [<c03ee4ac>] (dpm_resume_noirq+0x20c/0x2e4)
> [<c03ee4ac>] (dpm_resume_noirq) from [<c0095e94>] (suspend_devices_and_enter+0x1e4/0x6bc)
> [<c0095e94>] (suspend_devices_and_enter) from [<c00966c4>] (pm_suspend+0x358/0x4b8)
> [<c00966c4>] (pm_suspend) from [<c0094fdc>] (state_store+0x64/0xb8)
> [<c0094fdc>] (state_store) from [<c034b46c>] (kobj_attr_store+0x14/0x20)
> [<c034b46c>] (kobj_attr_store) from [<c01ea4d8>] (sysfs_kf_write+0x4c/0x50)
> [<c01ea4d8>] (sysfs_kf_write) from [<c01e9afc>] (kernfs_fop_write+0xbc/0x1cc)
> [<c01e9afc>] (kernfs_fop_write) from [<c0171c7c>] (__vfs_write+0x24/0xd8)
> [<c0171c7c>] (__vfs_write) from [<c0172520>] (vfs_write+0x94/0x154)
> [<c0172520>] (vfs_write) from [<c0172d1c>] (SyS_write+0x40/0x94)
> [<c0172d1c>] (SyS_write) from [<c000f760>] (ret_fast_syscall+0x0/0x1c)
> ---[ end trace 321b51565e161bee ]---
>
> And these both need to be applied together when we have a fix for the above
> as otherwise we'll get the lock recursion Sudeep mentioned in patch 2/2.
>

Most probably below diff will fix above issue:

diff --git a/arch/arm/mach-omap2/prm_common.c 
b/arch/arm/mach-omap2/prm_common.c
index 3fc2cbe..69cde67 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -338,6 +338,7 @@ int omap_prcm_register_chain_handler(struct 
omap_prcm_irq_setup *irq_setup)
                 ct->chip.irq_ack = irq_gc_ack_set_bit;
                 ct->chip.irq_mask = irq_gc_mask_clr_bit;
                 ct->chip.irq_unmask = irq_gc_mask_set_bit;
+               ct->chip.flags = IRQCHIP_SKIP_SET_WAKE;

                 ct->regs.ack = irq_setup->ack + i * 4;
                 ct->regs.mask = irq_setup->mask + i * 4;


-- 
regards,
-grygorii
