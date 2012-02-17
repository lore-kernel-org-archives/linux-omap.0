From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 8/8] arm: omap3: prevent per_clkdm from attempting
 manual domain transitions
Date: Fri, 17 Feb 2012 11:28:58 +0200
Message-ID: <1329470938.4102.408.camel@sokoban>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
 <1329320274-481-9-git-send-email-t-kristo@ti.com> <87pqdf99c2.fsf@ti.com>
 <1329382652.4102.386.camel@sokoban>
 <CAMQu2gx5JdKfTTUhi28N_=EZ3tDo7nTRA00ErrMpuGMkOh9rgw@mail.gmail.com>
 <1329398159.4102.391.camel@sokoban> <1329405804.4102.400.camel@sokoban>
 <CAMQu2gwMboftdRo9dE38ECp+5o2nTPgxeZ60JrbV0xd8HLNfUg@mail.gmail.com>
 <1329410895.4102.404.camel@sokoban>  <877gzmit2c.fsf@ti.com>
Reply-To: t-kristo@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <877gzmit2c.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2012-02-16 at 09:31 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > On Thu, 2012-02-16 at 21:15 +0530, Shilimkar, Santosh wrote:
> >> On Thu, Feb 16, 2012 at 8:53 PM, Tero Kristo <t-kristo@ti.com> wrote:
> >> > On Thu, 2012-02-16 at 15:15 +0200, Tero Kristo wrote:
> >> >> On Thu, 2012-02-16 at 15:27 +0530, Shilimkar, Santosh wrote:
> >> >> > On Thu, Feb 16, 2012 at 2:27 PM, Tero Kristo <t-kristo@ti.com> wrote:
> >> >> > > On Wed, 2012-02-15 at 11:37 -0800, Kevin Hilman wrote:
> >> >> > >> Tero Kristo <t-kristo@ti.com> writes:
> >> >> > >>
> >> >> > >> > Attempting this will cause problems especially with off-mode enabled.
> >> >> > >>
> >> >> > >> Please be more verbose about the problems seen, and the root cause(s).
> >> >> > >>
> >> >> > >
> >> >> > > I was actually looking forward for some help with this commit message,
> >> >> > > as I am still not quite sure what is going on in here. :) Here is the
> >> >> > > log for suspend (btw, cam_pwrdm does not go to off in mainline yet, but
> >> >> > > I think that is probably fixed by the patch from Paul,
> >> >> > > omap_set_pwrdm_state() does not work properly.) The warning comes out
> >> >> > > after wakeup from off-mode, and it is triggered by the disabling of
> >> >> > > autodeps before off-mode entry.
> >> >> > >
> >> >> > This mostly indicates that one of the per clock-domain module
> >> >> > clock turning ON seems to be not working well with auto deps
> >> >> > disabled. This leads to interconnect violation.
> >> >> >
> >> >> > if not tried already, can you put the per_clockdomain in SW_WKUP
> >> >> > in the low power code early resume path and see if this
> >> >> > error goes away.
> >> >>
> >> >> This seems to get rid of the dump also. It looks like some driver resume
> >> >> is not behaving nicely, I am trying to pinpoint the culprit currently
> >> >> and see whether it can provide more info.
> >> >
> >> > Okay, I have some more info about this now.
> >> >
> >> > What happens is that when entering off-mode, PER domain remains OFF even
> >> > during the execution of the exit phase from omap_sram_idle. Adding a
> >> > manual SW_WKUP it comes up and there are no issues. If autodeps are
> >> > enabled on the domain, it comes back from off mode as active.
> >> >
> >> > Looking further in the code, we have this at the end of omap_sram_idle:
> >> >
> >> >        if (per_next_state < PWRDM_POWER_ON) {
> >> >                per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> >> >                omap2_gpio_resume_after_idle();
> >> >                wake_per();
> >> >                if (per_prev_state == PWRDM_POWER_OFF)
> >> >                        omap3_per_restore_context();
> >> >        }
> >> >
> >> > ... which seems to assume that per domain is on. Gpio code does not
> >> > control any clocks currently, as it only requires the interface clock to
> >> > be on, and as this is autoidled....
> >> >
> >> > Any comments how we should handle this? Shall we just keep these two
> >> > patches for handling this or add some different hackery for the gpio
> >> > issue?
> >> >
> >> Good. I thought too that issue will disappear.
> >> The issue is pretty clear. Technically every driver pm_runtime() code should
> >> be able to manage a clock->clockdomain->power domain power up/down
> >> sequence. That should work without auto deps.
> >> 
> >> Do you narrowed down which driver resume is creating the dump ?
> >> UART , GPIO ?
> >
> > It is the gpio base stuff called from omap_sram_idle(), basically the
> > restore context part. If I force enable per domain before the code
> > snippet before, there is no dump, but if it is done after, I get the
> > dump.
> >
> > The thing is that gpio driver doesn't currently have this kind of
> > mechanism for the restore context part, at least not on omap3 due to
> > above clocking issue (only autoidled interface clock is used.)
> 
> I'm not sure if it fully addresses this, but Tarun's series converts
> GPIO to runtime PM.
> 
> Can you try with Tarun's series.  See the for_3.4/gpio_cleanup_fixes_v9
> branch here:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev.git

It does something for the issue, but I still get this during suspend to
off:

[   11.284973] PM: Syncing filesystems ... done.
[   11.379241] Freezing user space processes ... (elapsed 0.02 seconds)
done.
[   11.408233] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) don
e.
[   11.439239] Suspending console(s) (use no_console_suspend to debug)
[   11.564178] PM: suspend of devices complete after 115.506 msecs
[   11.567382] PM: late suspend of devices complete after 3.204 msecs
[   11.567443] Disabling non-boot CPUs ...
[   12.004089] Powerdomain (cam_pwrdm) didn't enter target state 0
[   12.004119] Could not enter target state in pm_suspend
[   12.009368] PM: early resume of devices complete after 4.944 msecs
[   12.436645] PM: resume of devices complete after 426.086 msecs
[   12.480285] Restarting tasks ... done.
/sys/kernel/debu[   12.488433] ------------[ cut here ]------------
[   12.494415] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1604 _idle
+0x164/0x1
7c()
[   12.502258] omap_hwmod: gpio6: idle state can only be entered from
enabled st
ate
[   12.509979] Modules linked in:
[   12.513214] [<c001bcd0>] (unwind_backtrace+0x0/0xf4) from
[<c0042968>] (warn_
slowpath_common+0x4c/0x64)
[   12.523071] [<c0042968>] (warn_slowpath_common+0x4c/0x64) from
[<c0042a14>] (
warn_slowpath_fmt+0x30/0x40)
[   12.533081] [<c0042a14>] (warn_slowpath_fmt+0x30/0x40) from
[<c0028d68>] (_id
le+0x164/0x17c)
[   12.541931] [<c0028d68>] (_idle+0x164/0x17c) from [<c00298b0>]
(omap_hwmod_id
le+0x28/0x3c)
[   12.550567] [<c00298b0>] (omap_hwmod_idle+0x28/0x3c) from
[<c003c664>] (omap_
device_idle_hwmods+0x24/0x3c)
[   12.560699] [<c003c664>] (omap_device_idle_hwmods+0x24/0x3c) from
[<c003c898>
] (_omap_device_deactivate+0xa4/0x138)
[   12.571594] [<c003c898>] (_omap_device_deactivate+0xa4/0x138) from
[<c003c954
>] (omap_device_idle+0x28/0x54)
[   12.581909] [<c003c954>] (omap_device_idle+0x28/0x54) from
[<c003c99c>] (_od_
runtime_suspend+0x1c/0x24)
[   12.591735] [<c003c99c>] (_od_runtime_suspend+0x1c/0x24) from
[<c02c5010>] (_
_rpm_callback+0x2c/0x78)
[   12.601379] [<c02c5010>] (__rpm_callback+0x2c/0x78) from [<c02c54d0>]
(rpm_su
spend+0x264/0x6c4)
[   12.610504] [<c02c54d0>] (rpm_suspend+0x264/0x6c4) from [<c02c6998>]
(__pm_ru
ntime_suspend+0x5c/0x74)
[   12.620178] [<c02c6998>] (__pm_runtime_suspend+0x5c/0x74) from
[<c02731a4>] (
omap2_gpio_prepare_for_idle+0x50/0x64)
[   12.631103] [<c02731a4>] (omap2_gpio_prepare_for_idle+0x50/0x64) from
[<c002b
d30>] (omap_sram_idle+0xa0/0x3b0)
[   12.641571] [<c002bd30>] (omap_sram_idle+0xa0/0x3b0) from
[<c002c1d8>] (omap3
_pm_idle+0x60/0x178)
[   12.650848] [<c002c1d8>] (omap3_pm_idle+0x60/0x178) from [<c0015c10>]
(cpu_id
le+0xc4/0x108)
[   12.659606] [<c0015c10>] (cpu_idle+0xc4/0x108) from [<c0626828>]
(start_kerne
l+0x2b0/0x304)
[   12.668365] ---[ end trace 441b8fea2b56dcb1 ]---


Also, this goes away if I manually force wakeup for the per domain, so
this might be caused by some additional latency.

-Tero
