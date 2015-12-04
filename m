From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 07:35:05 -0800
Message-ID: <20151204153504.GF23396@atomide.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com>
 <56608B72.1040101@ti.com>
 <20151203213715.GA23396@atomide.com>
 <56616E74.9000604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56616E74.9000604@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151204 02:45]:
> On 12/03/2015 11:37 PM, Tony Lindgren wrote:
> >* Grygorii Strashko <grygorii.strashko@ti.com> [151203 10:36]:
> >>
> >>I think, this patch should not break our wake-up functionality.
> >>It will just change the moment when pcs_irq_handler() will be called:
> >>
> >>before this change:
> >>- suspend_enter()
> >>   ....
> >>   - arch_suspend_enable_irqs();
> >>     - ^ right here
> >>
> >>after this change:
> >>- suspend_enter()
> >>   ....
> >>   dpm_resume_noirq()
> >>   - resume_device_irqs()
> >>     ^ here
> >>
> >>Correct? And as for me this is more safe.
> >
> >I think there's more to it though. With both applied, it produces this on
> >coming back up from suspend:
> >
> >PM: noirq resume of devices complete after 18.127 msecs
> >------------[ cut here ]------------
> >WARNING: CPU: 0 PID: 123 at kernel/irq/manage.c:605 irq_set_irq_wake+0xbc/0xfc()
> >Unbalanced IRQ 375 wake disable
> >Modules linked in: ledtrig_default_on leds_gpio led_class rtc_twl twl4030_wdt
> >CPU: 0 PID: 123 Comm: bash Tainted: G        W       4.4.0-rc3-dirty #2682
> >Hardware name: Generic OMAP36xx (Flattened Device Tree)
> >[<c0017df0>] (unwind_backtrace) from [<c0014084>] (show_stack+0x10/0x14)
> ><c0014084>] (show_stack) from [<c03492d0>] (dump_stack+0x84/0x9c)
> >[<c03492d0>] (dump_stack) from [<c003ca2c>] (warn_slowpath_common+0x7c/0xb8)
> >[<c003ca2c>] (warn_slowpath_common) from [<c003ca98>] (warn_slowpath_fmt+0x30/0x40)
> >[<c003ca98>] (warn_slowpath_fmt) from [<c009b66c>] (irq_set_irq_wake+0xbc/0xfc)
> >[<c009b66c>] (irq_set_irq_wake) from [<c03f0f1c>] (device_wakeup_disarm_wake_irqs+0x70/0x12c)
> >[<c03f0f1c>] (device_wakeup_disarm_wake_irqs) from [<c03ee4ac>] (dpm_resume_noirq+0x20c/0x2e4)
> >[<c03ee4ac>] (dpm_resume_noirq) from [<c0095e94>] (suspend_devices_and_enter+0x1e4/0x6bc)
> >[<c0095e94>] (suspend_devices_and_enter) from [<c00966c4>] (pm_suspend+0x358/0x4b8)
> >[<c00966c4>] (pm_suspend) from [<c0094fdc>] (state_store+0x64/0xb8)
> >[<c0094fdc>] (state_store) from [<c034b46c>] (kobj_attr_store+0x14/0x20)
> >[<c034b46c>] (kobj_attr_store) from [<c01ea4d8>] (sysfs_kf_write+0x4c/0x50)
> >[<c01ea4d8>] (sysfs_kf_write) from [<c01e9afc>] (kernfs_fop_write+0xbc/0x1cc)
> >[<c01e9afc>] (kernfs_fop_write) from [<c0171c7c>] (__vfs_write+0x24/0xd8)
> >[<c0171c7c>] (__vfs_write) from [<c0172520>] (vfs_write+0x94/0x154)
> >[<c0172520>] (vfs_write) from [<c0172d1c>] (SyS_write+0x40/0x94)
> >[<c0172d1c>] (SyS_write) from [<c000f760>] (ret_fast_syscall+0x0/0x1c)
> >---[ end trace 321b51565e161bee ]---
> >
> >And these both need to be applied together when we have a fix for the above
> >as otherwise we'll get the lock recursion Sudeep mentioned in patch 2/2.
> >
> 
> Most probably below diff will fix above issue:
> 
> diff --git a/arch/arm/mach-omap2/prm_common.c
> b/arch/arm/mach-omap2/prm_common.c
> index 3fc2cbe..69cde67 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -338,6 +338,7 @@ int omap_prcm_register_chain_handler(struct
> omap_prcm_irq_setup *irq_setup)
>                 ct->chip.irq_ack = irq_gc_ack_set_bit;
>                 ct->chip.irq_mask = irq_gc_mask_clr_bit;
>                 ct->chip.irq_unmask = irq_gc_mask_set_bit;
> +               ct->chip.flags = IRQCHIP_SKIP_SET_WAKE;
> 
>                 ct->regs.ack = irq_setup->ack + i * 4;
>                 ct->regs.mask = irq_setup->mask + i * 4;
> 
> 

That fixes the warning on resume, but adds a new one during init:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/irq/pm.c:51 irq_pm_install_action+0x9c/0xec()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc3-00001-g6a5e5ec #2694
Hardware name: Generic OMAP36xx (Flattened Device Tree)
[<c0017df0>] (unwind_backtrace) from [<c0014084>] (show_stack+0x10/0x14)
[<c0014084>] (show_stack) from [<c03492f0>] (dump_stack+0x84/0x9c)
[<c03492f0>] (dump_stack) from [<c003ca34>] (warn_slowpath_common+0x7c/0xb8)
[<c003ca34>] (warn_slowpath_common) from [<c003cb0c>] (warn_slowpath_null+0x1c/0x24)
[<c003cb0c>] (warn_slowpath_null) from [<c00a27d8>] (irq_pm_install_action+0x9c/0xec)
[<c00a27d8>] (irq_pm_install_action) from [<c009ccb0>] (__setup_irq+0x434/0x5e0)
[<c009ccb0>] (__setup_irq) from [<c009cfb0>] (request_threaded_irq+0xc4/0x15c)
[<c009cfb0>] (request_threaded_irq) from [<c08c25e8>] (omap3_pm_init+0x10c/0x400)
[<c08c25e8>] (omap3_pm_init) from [<c08bc66c>] (omap3_init_late+0xc/0x14)
[<c08bc66c>] (omap3_init_late) from [<c08b5820>] (init_machine_late+0x1c/0x90)
[<c08b5820>] (init_machine_late) from [<c0009804>] (do_one_initcall+0x80/0x1e0)
[<c0009804>] (do_one_initcall) from [<c08b2ec4>] (kernel_init_freeable+0x218/0x2e8)
[<c08b2ec4>] (kernel_init_freeable) from [<c064584c>] (kernel_init+0x8/0xec)
[<c064584c>] (kernel_init) from [<c000f7f0>] (ret_from_fork+0x14/0x24)
---[ end trace 81093452bf564522 ]---

And then there's still at least one problem remaining with the original patch
where togging the parent irq in pin specific irq pcs_irq_set_wake does not
make sense. Will comment on that separately.

Regards,

Tony
