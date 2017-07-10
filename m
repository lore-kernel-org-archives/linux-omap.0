From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 4/5] soc: ti: Add pm33xx driver for basic suspend
 support
Date: Mon, 10 Jul 2017 13:46:45 +0200
Message-ID: <20170710114645.GI29638@localhost>
References: <20170519200438.9502-1-d-gerlach@ti.com>
 <20170519200438.9502-5-d-gerlach@ti.com>
 <20170703165419.GC27842@localhost>
 <452f80bb-34fb-e27e-d743-43cf30453f4e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <452f80bb-34fb-e27e-d743-43cf30453f4e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 06, 2017 at 02:08:07PM -0500, Dave Gerlach wrote:
> On 07/03/2017 11:54 AM, Johan Hovold wrote:
> > On Fri, May 19, 2017 at 03:04:37PM -0500, Dave Gerlach wrote:
> >> AM335x and AM437x support various low power modes as documented
> >> in section 8.1.4.3 of the AM335x Technical Reference Manual and
> >> section 6.4.3 of the AM437x Technical Reference Manual.
> >>
> >> DeepSleep0 mode offers the lowest power mode with limited
> >> wakeup sources without a system reboot and is mapped as
> >> the suspend state in the kernel. In this state, MPU and
> >> PER domains are turned off with the internal RAM held in
> >> retention to facilitate the resume process. As part of
> >> the boot process, the assembly code is copied over to OCMCRAM
> >> so it can be executed to turn of the EMIF and put DDR into self
> >> refresh.
> >>
> >> Both platforms have a Cortex-M3 (WKUP_M3) which assists the MPU
> >> in DeepSleep0 entry and exit. WKUP_M3 takes care
> >> of the clockdomain and powerdomain transitions based on the
> >> intended low power state. MPU needs to load the appropriate
> >> WKUP_M3 binary onto the WKUP_M3 memory space before it can
> >> leverage any of the PM features like DeepSleep. This loading
> >> is handled by the remoteproc driver wkup_m3_rproc.
> >>
> >> Communication with the WKUP_M3 is handled by a wkup_m3_ipc
> >> driver that exposes the specific PM functionality to be used
> >> the PM code.

> > And similarly to the emif-sram device, you may need to create a
> > device-link also to the ipc device to prevent its driver from being
> > unbound.
> 
> As described in the ti-emif-pm thread for that driver, we also call exported
> symbols directly from wkup_m3_ipc driver, so pm33xx cannot probe at all if
> wkup_m3_ipc is not loaded, and wkup_m3_ipc cannot be removed once pm33xx has
> been loaded on top.

As discussed in the other thread, the ipc driver can be unbound from its
device even if the module remains loaded.

> > 
> >> +		ret = -EPROBE_DEFER;
> >> +		goto err_free_sram;
> >> +	}
> >> +
> >> +	am33xx_pm_set_ipc_ops();
> >> +
> >> +#ifdef CONFIG_SUSPEND
> >> +	suspend_set_ops(&am33xx_pm_ops);
> >> +#endif /* CONFIG_SUSPEND */
> > 
> > This renders a lockdep splash about a circular locking dependency when
> > suspending since we're taking the pm_mutex in suspend_set_ops here, and
> > during suspend we flush any deferred probes while already holding the
> > mutex:
> > 
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  4.12.0-rc7 #11 Not tainted
> >  ------------------------------------------------------
> >  bash/404 is trying to acquire lock:
> >   (deferred_probe_work){+.+.+.}, at: [<c014cf3c>] flush_work+0x30/0x27c
> >  
> >  but task is already holding lock:
> >   (pm_mutex){+.+...}, at: [<c01792dc>] pm_suspend+0x190/0xc94
> >  
> >  which lock already depends on the new lock.
> >  
> >  
> >  the existing dependency chain (in reverse order) is:
> >  
> >  -> #1 (pm_mutex){+.+...}:
> >         __mutex_lock+0x80/0x694
> >         mutex_lock_nested+0x2c/0x34
> >         suspend_set_ops+0x4c/0x128
> >         am33xx_pm_probe+0x1fc/0x3a8
> >         platform_drv_probe+0x5c/0xc0
> >         driver_probe_device+0x37c/0x490
> >         __device_attach_driver+0xac/0x128
> >         bus_for_each_drv+0x74/0xa8
> >         __device_attach+0xc4/0x154
> >         device_initial_probe+0x1c/0x20
> >         bus_probe_device+0x98/0xa0
> >         deferred_probe_work_func+0x4c/0xe4
> >         process_one_work+0x1f4/0x758
> >         worker_thread+0x1e0/0x514
> >         kthread+0x128/0x158
> >         ret_from_fork+0x14/0x24
> >  
> >  -> #0 (deferred_probe_work){+.+.+.}:
> >         lock_acquire+0x108/0x264
> >         flush_work+0x60/0x27c
> >         wait_for_device_probe+0x24/0xa4
> >         dpm_prepare+0xd0/0x91c
> >         dpm_suspend_start+0x1c/0x70
> >         suspend_devices_and_enter+0xc4/0xeac
> >         pm_suspend+0x890/0xc94
> >         state_store+0x80/0xdc
> >         kobj_attr_store+0x1c/0x28
> >         sysfs_kf_write+0x5c/0x60
> >         kernfs_fop_write+0x128/0x254
> >         __vfs_write+0x38/0x128
> >         vfs_write+0xb4/0x174
> >         SyS_write+0x54/0xb0
> >         ret_fast_syscall+0x0/0x1c
> > 
> 
> Yes thanks, I have seen this before myself now. I will need to look closer into
> eliminating this. I am not sure how it is happening, pm_suspend should not be
> able to be called if suspend_set_ops has not completed, at which point it should
> have released the mutex.

So perhaps the deadlock cannot happen in practise then even if both
paths can indeed be taken (which triggers the lockdep warning).

Johan
