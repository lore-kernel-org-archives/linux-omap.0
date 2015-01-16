From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [v3,15/21] ARM: exynos4/5: convert pmu wakeup to stacked domains
Date: Fri, 16 Jan 2015 19:22:54 +0000
Message-ID: <54B9650E.3080505@arm.com>
References: <1421087187-26988-16-git-send-email-marc.zyngier@arm.com> <54B76102.6050706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54B76102.6050706@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi Pankaj,

On 15/01/15 06:41, Pankaj Dubey wrote:
> +CC: Thomas Abraham <thomas.ab@samsung.com>
> 
> Hi Mark,
> 
> On Monday 12 January 2015 11:56 PM, Marc Zyngier wrote:
>> Exynos has been (ab)using the gic_arch_extn to provide
>> wakeup from suspend, and it makes a lot of sense to convert
>> this code to use stacked domains instead.
>>
>> This patch does just this, updating the DT files to actually
>> reflect what the HW provides.
>>
>> BIG FAT WARNING: because the DTs were so far lying by not
>> exposing the fact that the PMU block is actually the first
>> interrupt controller in the chain for RTC, kernels with this patch
>> applied wont have any suspend-resume facility when booted
>> with old DTs, and old kernels with updated DTs may not even boot.
>>
>> Also, I stronly suspect that there is more than two wake-up
>> interrupts on these platforms, but I leave it to the maintainers
>> to fix their mess.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
> 
> I tested this series on Exynos5250, using kgene/for-next and 
> linux-next/next-20150114, but S2R failed on Exynos5250 based SMDK board.
> 
> Following is the log I got on SMDK5250 board, (note I have added some 
> debugging log to know what is happening)
> 
> I can see is S3C-RTC's "enable_irq_wake" is failing with error -6.
> I also observed that even though we are adding pmu_domain_ops using 
> irq_domain_add_hierarchy, but none of pmu_domain_ops are getting called.
> 
> Please let me know if I am missing anything or do I need to modify 
> anything to test S2R on Exynos SoC.

Thanks for giving it a go. One think I noticed is that I forgot to add a
"#interrupt-cells = <3>;" to the pmu_system_controller node.

Also, it would be interesting to know what is the hwirq associated with
the irq_desc you've printed below.

Thanks,

	M.

> ---------------------
> echo +10 > /sys/class/rtc/rtc1/wakealarm; sleep 1; echo mem > /sys/power/sta
> te
> [  257.428163] PM: Syncing filesystems ... done.
> [  257.431786] Freezing user space processes ... (elapsed 0.003 seconds) 
> done.
> [  257.439680] Freezing remaining freezable tasks ... (elapsed 0.001 
> seconds) done.
> [  257.544451] wake enabled for irq 116
> [  257.546916] CPU: 0 PID: 1311 Comm: ash Not tainted 
> 3.19.0-rc4-next-20150114-00023-g492ff37 #15
> [  257.555141] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  257.561231] [<c0014430>] (unwind_backtrace) from [<c0011594>] 
> (show_stack+0x10/0x14)
> [  257.568948] [<c0011594>] (show_stack) from [<c0418b00>] 
> (dump_stack+0x84/0xc4)
> [  257.576151] [<c0418b00>] (dump_stack) from [<c005ce30>] 
> (set_irq_wake_real+0x58/0x8c)
> [  257.583961] [<c005ce30>] (set_irq_wake_real) from [<c005cef0>] 
> (irq_set_irq_wake+0x8c/0xf0)
> [  257.592295] [<c005cef0>] (irq_set_irq_wake) from [<c02e9d94>] 
> (s3c_rtc_suspend+0xb8/0xdc)
> [  257.600456] [<c02e9d94>] (s3c_rtc_suspend) from [<c0298c80>] 
> (dpm_run_callback.isra.13+0x1c/0x60)
> [  257.609308] [<c0298c80>] (dpm_run_callback.isra.13) from [<c02996a0>] 
> (__device_suspend+0x128/0x2d0)
> [  257.618422] [<c02996a0>] (__device_suspend) from [<c029a850>] 
> (dpm_suspend+0x64/0x22c)
> [  257.626320] [<c029a850>] (dpm_suspend) from [<c0058488>] 
> (suspend_devices_and_enter+0x88/0x3dc)
> [  257.634999] [<c0058488>] (suspend_devices_and_enter) from 
> [<c00589c8>] (pm_suspend+0x1ec/0x24c)
> [  257.643680] [<c00589c8>] (pm_suspend) from [<c00576e0>] 
> (state_store+0x68/0xb8)
> [  257.650972] [<c00576e0>] (state_store) from [<c012835c>] 
> (kernfs_fop_write+0xb8/0x19c)
> [  257.658870] [<c012835c>] (kernfs_fop_write) from [<c00cf620>] 
> (vfs_write+0xa0/0x1ac)
> [  257.666595] [<c00cf620>] (vfs_write) from [<c00cfc78>] 
> (SyS_write+0x44/0x9c)
> [  257.673625] [<c00cfc78>] (SyS_write) from [<c000e6e0>] 
> (ret_fast_syscall+0x0/0x30)
> [  257.681176] genirq: PKD: irq_desc->name: (null): irq: 60
> [  257.686469] genirq: PKD: set_irq_wake_real: ret: -6
> [  257.691349] s3c-rtc 101e0000.rtc: enable_irq_wake failed: -6
> [  257.708926] PM: suspend of devices complete after 260.482 msecs
> [  257.713362] BUCK9: No configuration
> [  257.716840] BUCK8: No configuration
> [  257.720309] BUCK7: No configuration
> [  257.723776] BUCK6: No configuration
> [  257.727254] P1.8V_BUCK_OUT5: No configuration
> [  257.731597] LDO26: No configuration
> [  257.735066] LDO25: No configuration
> [  257.738532] LDO24: No configuration
> [  257.742009] LDO23: No configuration
> [  257.745481] LDO22: No configuration
> [  257.748954] LDO21: No configuration
> [  257.752419] LDO20: No configuration
> [  257.755897] LDO19: No configuration
> [  257.759370] LDO18: No configuration
> [  257.762835] LDO17: No configuration
> [  257.766314] P1.8V_LDO_OUT16: No configuration
> [  257.770653] P1.0V_LDO_OUT15: No configuration
> [  257.774994] P1.8V_LDO_OUT14: No configuration
> [  257.779334] P1.8V_LDO_OUT13: No configuration
> [  257.783668] P3.0V_LDO_OUT12: No configuration
> [  257.788013] P1.8V_LDO_OUT11: No configuration
> [  257.792353] P1.8V_LDO_OUT10: No configuration
> [  257.796693] LDO9: No configuration
> [  257.800079] P1.0V_LDO_OUT8: No configuration
> [  257.804332] P1.1V_LDO_OUT7: No configuration
> [  257.808579] P1.1V_LDO_OUT6: No configuration
> [  257.812838] P1.8V_LDO_OUT5: No configuration
> [  257.817091] P2.8V_LDO_OUT4: No configuration
> [  257.821345] P1.8V_LDO_OUT3: No configuration
> [  257.825599] P1.2V_LDO_OUT2: No configuration
> [  257.829851] P1.0V_LDO_OUT1: No configuration
> [  257.835786] PM: late suspend of devices complete after 1.676 msecs
> [  257.841913] PM: noirq suspend of devices complete after 1.420 msecs
> [  257.846737] Disabling non-boot CPUs ...
> [  257.850810] IRQ54 no longer affine to CPU1
> [  257.850922] CPU1: shutdown
> 
> ------------------------------------
> 
> Thanks,
> Pankaj Dubey
> 


-- 
Jazz is not dead. It just smells funny...
