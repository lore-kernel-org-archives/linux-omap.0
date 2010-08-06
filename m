From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: Issues with calling pm_runtime functions in
 platform_pm_suspend_noirq/IRQ disabled context.
Date: Fri, 6 Aug 2010 19:51:28 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E800BC1C@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED1089@dbde02.ent.ti.com>
	<874ofbppj4.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7F6ECA2@dbde02.ent.ti.com>
 <87eiee7xze.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab0HFOVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 10:21:40 -0400
In-Reply-To: <87eiee7xze.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, August 05, 2010 5:05 AM
> To: Basak, Partha
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Kalliguddi, Hema; Raja,
> Govindraj; Varadarajan, Charulatha; Nayak, Rajendra; Cousson, Benoit
> Subject: Re: Issues with calling pm_runtime functions in
> platform_pm_suspend_noirq/IRQ disabled context.
> 
> "Basak, Partha" <p-basak2@ti.com> writes:
> 
> >
> > Tested GPIO for Suspend with these changes & obtained dump of Circular
> Locking dependencies:
> >
> 
> It would *really* help to have these GPIO conversion patches posted
> against a public tree/branch one could see exactly what is going on and
> be able to reproduce this problem for easier analysis.  I have some
> hunches as to what is going wrong here, but cannot be sure.  I'd much
> rather be able to see and try the code.
> 
> Fortunately, lockdep is verbose enough to try and understand the
> symptoms here.  Lockdep seems to have detected that these two locks have
> been acquired in different order, resulting in *potential* deadlock.
> 
> Indeed, during init (#0 below) you have the hwmod_mutex acquired
> (hwmod_for_each_by_class()) then the dpm_list_mtx acquired
> (device_pm_add()).  Later, during suspend the dpm_list_mtx is aquired
> first (dpm_suspend_noirq()), then the omap_hwmod_mutex is acquired
> (omap_hwmod_idle()).
> 
> Taking the same locks in different order at different times is the
> circular dependency and a recipe for potential deadlock.
> 
> In our case, there is no real potential for deadlock here as the locks
> are only taken the hwmod->dpm order once during init, all other times
> (when the omap_device/hwmod are ready) it will happen in the dpm->hwmod
> order.
> 
> The simple fix here is probably to remove the locking in the
> omap_hwmod_for_each* functions.  Could you try that?
> 
We tried this, it works. But the GPIO patch series sent out(posted today, Aug 06 2010) are tested based on reverting the pm_bus.c suspend_no_irq patch. 

> I'm a bit confused why I don't see the same problem with the UART layer
> which currently also handles things in the idle path as well.
> 
> Kevin
> 
> > # echo mem > /sys/power/state
> > [  809.981658] PM: Syncing filesystems ... done.
> > [  810.037963] Freezing user space processes ... (elapsed 0.02 seconds)
> done.
> > [  810.067901] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) done.
> > [  810.105224] Suspending console(s) (use no_console_suspend to debug)
> > [  810.166748] PM: suspend of devices complete after 46.142 msecs
> > [  810.170562]
> > [  810.170593] =======================================================
> > [  810.170593] [ INFO: possible circular locking dependency detected ]
> > [  810.170623] 2.6.35-rc5-00131-g56e767c-dirty #34
> > [  810.170654] -------------------------------------------------------
> > [  810.170654] sh/670 is trying to acquire lock:
> > [  810.170684]  (omap_hwmod_mutex){+.+.+.}, at: [<c004fe84>]
> omap_hwmod_idle+0x1c/0x38
> > [  810.170745]
> > [  810.170745] but task is already holding lock:
> > [  810.170776]  (dpm_list_mtx){+.+...}, at: [<c023baf8>]
> dpm_suspend_noirq+0x28/0x188
> > [  810.170806]
> > [  810.170837] which lock already depends on the new lock.
> > [  810.170837]
> > [  810.170837]
> > [  810.170837] the existing dependency chain (in reverse order) is:
> > [  810.170867]
> > [  810.170867] -> #1 (dpm_list_mtx){+.+...}:
> > [  810.170898]        [<c009bc3c>] lock_acquire+0x60/0x74
> > [  810.170959]        [<c0437a9c>] mutex_lock_nested+0x58/0x2e4
> > [  810.170989]        [<c023bcc0>] device_pm_add+0x14/0xcc
> > [  810.171020]        [<c0235304>] device_add+0x3b8/0x564
> > [  810.171051]        [<c0238834>] platform_device_add+0x104/0x160
> > [  810.171112]        [<c005f2a8>] omap_device_build_ss+0x14c/0x1c8
> > [  810.171142]        [<c005f36c>] omap_device_build+0x48/0x50
> > [  810.171173]        [<c004d34c>] omap2_init_gpio+0xf0/0x15c
> > [  810.171203]        [<c004f254>]
> omap_hwmod_for_each_by_class+0x60/0xa4
> > [  810.171264]        [<c0040340>] do_one_initcall+0x58/0x1b4
> > [  810.171295]        [<c0008574>] kernel_init+0x98/0x150
> > [  810.171325]        [<c0041968>] kernel_thread_exit+0x0/0x8
> > [  810.171356]
> > [  810.171356] -> #0 (omap_hwmod_mutex){+.+.+.}:
> > [  810.171386]        [<c009b4e4>] __lock_acquire+0x108c/0x1784
> > [  810.171447]        [<c009bc3c>] lock_acquire+0x60/0x74
> > [  810.171478]        [<c0437a9c>] mutex_lock_nested+0x58/0x2e4
> > [  810.171508]        [<c004fe84>] omap_hwmod_idle+0x1c/0x38
> > [  810.171539]        [<c005eb9c>] omap_device_idle_hwmods+0x20/0x3c
> > [  810.171600]        [<c005ec88>] _omap_device_deactivate+0x58/0x14c
> > [  810.171630]        [<c005ef50>] omap_device_idle+0x4c/0x6c
> > [  810.171661]        [<c0053e7c>] platform_pm_runtime_suspend+0x4c/0x74
> > [  810.171691]        [<c023c9f8>] __pm_runtime_suspend+0x204/0x34c
> > [  810.171722]        [<c023cbe0>] pm_runtime_suspend+0x20/0x34
> > [  810.171752]        [<c0053dbc>] platform_pm_runtime_idle+0x8/0x10
> > [  810.171783]        [<c023c344>] __pm_runtime_idle+0x15c/0x198
> > [  810.171813]        [<c023c3f8>] pm_runtime_idle+0x1c/0x30
> > [  810.171844]        [<c0053dac>] platform_pm_suspend_noirq+0x48/0x50
> > [  810.171875]        [<c023ad4c>] pm_noirq_op+0xa0/0x184
> > [  810.171905]        [<c023bb7c>] dpm_suspend_noirq+0xac/0x188
> > [  810.171936]        [<c00a5d00>] suspend_devices_and_enter+0x94/0x1d8
> > [  810.171966]        [<c00a5f00>] enter_state+0xbc/0x120
> > [  810.171997]        [<c00a5654>] state_store+0xa4/0xb8
> > [  810.172027]        [<c01ea9e0>] kobj_attr_store+0x18/0x1c
> > [  810.172088]        [<c0129acc>] sysfs_write_file+0x10c/0x144
> > [  810.172119]        [<c00df83c>] vfs_write+0xb0/0x148
> > [  810.172149]        [<c00df984>] sys_write+0x3c/0x68
> > [  810.172180]        [<c0040920>] ret_fast_syscall+0x0/0x3c
> > [  810.172210]
> > [  810.172210] other info that might help us debug this:
> > [  810.172210]
> > [  810.172241] 4 locks held by sh/670:
> > [  810.172241]  #0:  (&buffer->mutex){+.+.+.}, at: [<c01299e8>]
> sysfs_write_file+0x28/0x144
> > [  810.172302]  #1:  (s_active#5){.+.+.+}, at: [<c0129aa8>]
> sysfs_write_file+0xe8/0x144
> > [  810.172363]  #2:  (pm_mutex){+.+.+.}, at: [<c00a5e64>]
> enter_state+0x20/0x120
> > [  810.172393]  #3:  (dpm_list_mtx){+.+...}, at: [<c023baf8>]
> dpm_suspend_noirq+0x28/0x188
> > [  810.172454]
> > [  810.172454] stack backtrace:
> > [  810.172515] [<c00460d4>] (unwind_backtrace+0x0/0xe4) from
> [<c00996f4>] (print_circular_bug+0xc4/0xdc)
> > [  810.172576] [<c00996f4>] (print_circular_bug+0xc4/0xdc) from
> [<c009b4e4>] (__lock_acquire+0x108c/0x1784)
> > [  810.172637] [<c009b4e4>] (__lock_acquire+0x108c/0x1784) from
> [<c009bc3c>] (lock_acquire+0x60/0x74)
> > [  810.172698] [<c009bc3c>] (lock_acquire+0x60/0x74) from [<c0437a9c>]
> (mutex_lock_nested+0x58/0x2e4)
> > [  810.172760] [<c0437a9c>] (mutex_lock_nested+0x58/0x2e4) from
> [<c004fe84>] (omap_hwmod_idle+0x1c/0x38)
> > [  810.172821] [<c004fe84>] (omap_hwmod_idle+0x1c/0x38) from
> [<c005eb9c>] (omap_device_idle_hwmods+0x20/0x3c)
> > [  810.172882] [<c005eb9c>] (omap_device_idle_hwmods+0x20/0x3c) from
> [<c005ec88>] (_omap_device_deactivate+0x58/0x14c)
> > [  810.172943] [<c005ec88>] (_omap_device_deactivate+0x58/0x14c) from
> [<c005ef50>] (omap_device_idle+0x4c/0x6c)
> > [  810.173004] [<c005ef50>] (omap_device_idle+0x4c/0x6c) from
> [<c0053e7c>] (platform_pm_runtime_suspend+0x4c/0x74)
> > [  810.173065] [<c0053e7c>] (platform_pm_runtime_suspend+0x4c/0x74) from
> [<c023c9f8>] (__pm_runtime_suspend+0x204/0x34c)
> > [  810.173095] [<c023c9f8>] (__pm_runtime_suspend+0x204/0x34c) from
> [<c023cbe0>] (pm_runtime_suspend+0x20/0x34)
> > [  810.173156] [<c023cbe0>] (pm_runtime_suspend+0x20/0x34) from
> [<c0053dbc>] (platform_pm_runtime_idle+0x8/0x10)
> > [  810.173217] [<c0053dbc>] (platform_pm_runtime_idle+0x8/0x10) from
> [<c023c344>] (__pm_runtime_idle+0x15c/0x198)
> > [  810.173248] [<c023c344>] (__pm_runtime_idle+0x15c/0x198) from
> [<c023c3f8>] (pm_runtime_idle+0x1c/0x30)
> > [  810.173309] [<c023c3f8>] (pm_runtime_idle+0x1c/0x30) from
> [<c0053dac>] (platform_pm_suspend_noirq+0x48/0x50)
> > [  810.173339] [<c0053dac>] (platform_pm_suspend_noirq+0x48/0x50) from
> [<c023ad4c>] (pm_noirq_op+0xa0/0x184)
> >>
> >> By the time the drivers _noirq hooks are called, the PM core has
> >> shutdown all the drivers, prevented any runtime PM transitions and
> >> disabled interrupts, so no pending runtime transitions will be queued
> >> so the sleeping patch of the __pm_runtime_* should never be entered.
> >>
> >> > We are facing a similar issue with a few drivers USB, UART & GPIO
> >> > where, we need to enable/disable clocks & restore/save context in the
> >> > CPU-Idle path with interrupts locked.
> >>
> >
> >
> >> These are unrelated issues.  The above is for the static suspend/resume
> >> case.  These are for runtime PM.
> >>
> >> > As we are unable to use Runtime APIs, we are using omap_device APIs
> >> > directly with the following modification in the .activate_funcion/
> >> > deactivate_funcion (example UART driver)
> >>
> >> [...]
> >>
> >> The UART driver is a special case as it is managed from deep inside the
> >> idle path.
> >>
> >> > Can you feedback on my observations and comment on the approach taken
> >> > for these drivers?
> >>
> >> I cannot comment until I understand why these drivers need to
> >> enable/disable with interrupts off.
> >>
> >> In general, any use of the interrupts-off versions of the omap_device
> >> APIs need to be thorougly justified.
> >>
> >> Even the UART one will go away when the omap-serial driver is converted
> >> to runtime PM.
> >>
> >
> > For GPIO, it is a must to relinquish clocks in Idle-path as it is
> possible to have a GPIO bank requested and still allow PER domain to go to
> OFF.
> >
> > For USB, this is required because of a h/w issue.
> >
> > My point is, just by exposing a _omap_hwmod_idle()(mutex-free version)
> will not let us call pm_runtime APIs in Idle path as we are not supposed
> to enable interrupts there. We have faced problems with USB big-time in
> Idle path while using pm_runtime functions. So, we are resorting to
> calling omap_device_idle() in CPU_Idle path, and runtime functions in
> thread-context.
> >
> > Is this acceptable, given the limitations?
> >
> >> Kevin
> >>
