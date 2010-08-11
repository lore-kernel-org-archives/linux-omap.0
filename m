From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: omap_hwmod: remove locking from hwmod_for_each
 iterators
Date: Tue, 10 Aug 2010 23:37:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1008102323360.27472@utopia.booyaka.com>
References: <1281457882-30327-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38425 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab0HKFhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 01:37:51 -0400
In-Reply-To: <1281457882-30327-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, p-basak2@ti.com

Hi Kevin,

On Tue, 10 Aug 2010, Kevin Hilman wrote:

> Remove unnecessary locking in the 'for_each' iterators.  Any locking should
> be taken care of by using hwmod API functions in the functions called by the
> iterators.
> 
> In addition, having locking here causes lockdep to detect possible circular
> dependencies (originally reported by Partha Basak <p-basak2@ti.com>.)
> 
> For example, during init (#0 below) you have the hwmod_mutex acquired
> (hwmod_for_each_by_class()) then the dpm_list_mtx acquired
> (device_pm_add()).  Later, during suspend the dpm_list_mtx is aquired
> first (dpm_suspend_noirq()), then the omap_hwmod_mutex is acquired
> (omap_hwmod_idle()).
> 
> [  810.170593] =======================================================
> [  810.170593] [ INFO: possible circular locking dependency detected ]
> [  810.170623] 2.6.35-rc5-00131-g56e767c-dirty #34
> [  810.170654] -------------------------------------------------------
> [  810.170654] sh/670 is trying to acquire lock:
> [  810.170684]  (omap_hwmod_mutex){+.+.+.}, at: [<c004fe84>] omap_hwmod_idle+0x1c/0x38
> [  810.170745]
> [  810.170745] but task is already holding lock:
> [  810.170776]  (dpm_list_mtx){+.+...}, at: [<c023baf8>] dpm_suspend_noirq+0x28/0x188
> [  810.170806]
> [  810.170837] which lock already depends on the new lock.
> [  810.170837]
> [  810.170837]
> [  810.170837] the existing dependency chain (in reverse order) is:
> [  810.170867]
> [  810.170867] -> #1 (dpm_list_mtx){+.+...}:
> [  810.170898]        [<c009bc3c>] lock_acquire+0x60/0x74
> [  810.170959]        [<c0437a9c>] mutex_lock_nested+0x58/0x2e4
> [  810.170989]        [<c023bcc0>] device_pm_add+0x14/0xcc
> [  810.171020]        [<c0235304>] device_add+0x3b8/0x564
> [  810.171051]        [<c0238834>] platform_device_add+0x104/0x160
> [  810.171112]        [<c005f2a8>] omap_device_build_ss+0x14c/0x1c8
> [  810.171142]        [<c005f36c>] omap_device_build+0x48/0x50
> [  810.171173]        [<c004d34c>] omap2_init_gpio+0xf0/0x15c
> [  810.171203]        [<c004f254>] omap_hwmod_for_each_by_class+0x60/0xa4
> [  810.171264]        [<c0040340>] do_one_initcall+0x58/0x1b4
> [  810.171295]        [<c0008574>] kernel_init+0x98/0x150
> [  810.171325]        [<c0041968>] kernel_thread_exit+0x0/0x8
> [  810.171356]
> [  810.171356] -> #0 (omap_hwmod_mutex){+.+.+.}:
> [  810.171386]        [<c009b4e4>] __lock_acquire+0x108c/0x1784
> [  810.171447]        [<c009bc3c>] lock_acquire+0x60/0x74
> [  810.171478]        [<c0437a9c>] mutex_lock_nested+0x58/0x2e4
> [  810.171508]        [<c004fe84>] omap_hwmod_idle+0x1c/0x38
> [  810.171539]        [<c005eb9c>] omap_device_idle_hwmods+0x20/0x3c
> [  810.171600]        [<c005ec88>] _omap_device_deactivate+0x58/0x14c
> [  810.171630]        [<c005ef50>] omap_device_idle+0x4c/0x6c
> [  810.171661]        [<c0053e7c>] platform_pm_runtime_suspend+0x4c/0x74
> [  810.171691]        [<c023c9f8>] __pm_runtime_suspend+0x204/0x34c
> [  810.171722]        [<c023cbe0>] pm_runtime_suspend+0x20/0x34
> [  810.171752]        [<c0053dbc>] platform_pm_runtime_idle+0x8/0x10
> [  810.171783]        [<c023c344>] __pm_runtime_idle+0x15c/0x198
> [  810.171813]        [<c023c3f8>] pm_runtime_idle+0x1c/0x30
> [  810.171844]        [<c0053dac>] platform_pm_suspend_noirq+0x48/0x50
> [  810.171875]        [<c023ad4c>] pm_noirq_op+0xa0/0x184
> [  810.171905]        [<c023bb7c>] dpm_suspend_noirq+0xac/0x188
> [  810.171936]        [<c00a5d00>] suspend_devices_and_enter+0x94/0x1d8
> [  810.171966]        [<c00a5f00>] enter_state+0xbc/0x120
> [  810.171997]        [<c00a5654>] state_store+0xa4/0xb8
> [  810.172027]        [<c01ea9e0>] kobj_attr_store+0x18/0x1c
> [  810.172088]        [<c0129acc>] sysfs_write_file+0x10c/0x144
> [  810.172119]        [<c00df83c>] vfs_write+0xb0/0x148
> [  810.172149]        [<c00df984>] sys_write+0x3c/0x68
> [  810.172180]        [<c0040920>] ret_fast_syscall+0x0/0x3c

The intention of the mutex_lock() in the omap_hwmod_for_each*() case is to 
protect against changes to omap_hwmod_list during the list iteration.  It 
is true that omap_hwmod_list is only likely to change very early in boot, 
as the hwmods are registered, so perhaps this is not necessary in 
practice.  But at least theoretically it seems necessary, since I don't 
think that list_for_each_entry() is safe if a list addition is in progress 
simultaneously.

On the other hand, taking the mutex during most of the other 
omap_hwmod calls, such as 
omap_hwmod_{enable,idle,shutdown,enable_clocks,disable_clocks,reset,enable_wakeup,disable_wakeup}
is definitely not needed since those functions do not affect 
omap_hwmod_list.  The goal of the mutex there was simply to protect 
against concurrent calls to those functions.  To do that, perhaps the lock 
could be moved into the struct omap_hwmod?  I believe you suggested this 
during our PM discussions in Bengaluru.  That would carry a slight memory 
space penalty, but would also deserialize hwmod operations on an SMP 
system.  If you agree, perhaps you might spin a patch for that instead?


- Paul
